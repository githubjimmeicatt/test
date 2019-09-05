using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Icatt.Logging.DbContext;
using Icatt.Logging.Entities;


namespace Icatt.Logging.DataAccess
{
    public class LoggingRepository : ILoggingRepository
    {
        public const int PageSizeLimit = 10000;
        private readonly LoggingDbContext _context;


        public LoggingRepository(string nameOrConnectionstring, int databaseAppenderTimeoutInSeconds,bool createIfNotExists )
        {
            _context = new LoggingDbContext(nameOrConnectionstring, databaseAppenderTimeoutInSeconds,createIfNotExists ? LoggingDbContext.DatabaseInitializationMode.CreateIfNotExists : LoggingDbContext.DatabaseInitializationMode.NoInitialization);
        }


        public LoggingRepository(string nameOrConnectionstring, int databaseAppenderTimeoutInSeconds) : this(nameOrConnectionstring,databaseAppenderTimeoutInSeconds, false )
        {
        }

        public LoggingRepository(int databaseAppenderTimeoutInSeconds): this(null,databaseAppenderTimeoutInSeconds)
        {
        }

        public void Dispose()
        {
            if (_context == null) return;

            _context.Dispose();
        }


        public void Add(LogEntry logEntry)
        {
            _context.LogEntries.Add(logEntry);
            _context.SaveChanges();
        }

        public void Add(ExceptionEntry exceptionEntry)
        {
            _context.ExceptionEntries.Add(exceptionEntry);
            _context.SaveChanges();
        }


        /// <summary>
        /// Queries the LogEntry table. Only returns 1000 records by default
        /// </summary>
        /// <param name="filter"></param>
        /// <param name="take">Page size. Is limited to <see cref="PageSizeLimit"/></param>
        /// <param name="skip"></param>
        /// <param name="ascending"></param>
        /// <returns></returns>
        public IList<LogEntry> GetLogEntries(LogEntryFilter filter = null, int take = 1000, int skip = 0, bool ascending = false)
        {
            if (take > PageSizeLimit)
                throw new ArgumentOutOfRangeException("take", take,string.Format("The nr of records is limited to {0} to avoid long running queries and possible table lock expansion blocking log writing. Execute multiple calls using skip and take to retrieve more records", PageSizeLimit));

            var result = QueryLogEntries(filter);

            IOrderedQueryable<LogEntry> sorted;
            if (ascending)
            {
                sorted = result.OrderBy(e => e.CreatedAtUtc).ThenBy(e => e.Timestamp);
            }
            else
            {
                sorted = result.OrderByDescending(e => e.CreatedAtUtc).ThenByDescending(e => e.Timestamp);
            }

            return sorted.Skip(skip).Take(take).ToList();
        }

        
        public IList<ExceptionEntry> GetExceptionEntries(ExceptionEntryFilter filter=null, int take = 1000, int skip = 0, bool ascending = false)
        {
            if (take > PageSizeLimit)
                throw new ArgumentOutOfRangeException("take", take,string.Format("The nr of records is limited to {0} to avoid long running queries ans possible table lock expansion blocking log writing. Execute multiple calls using skip and take to retrieve more records", PageSizeLimit));


            var result = QueryExceptionEntries(filter);

            IOrderedQueryable<ExceptionEntry> sorted;
            if (ascending)
            {
                sorted = result.OrderBy(e => e.CreatedAtUtc).ThenBy(e => e.Timestamp).ThenBy(e => e.Depth); 
            }
            else
            {
                //Inner exceptions have the same timestamp but lower depth. Order of occurrence is inner exception first, so return them last if last entries are returned first
                sorted = result.OrderByDescending(e => e.CreatedAtUtc).ThenByDescending(e => e.Timestamp).ThenByDescending(e =>e.Depth);
            }

            return sorted.Skip(skip).Take(take).ToList();
        }

        public int DeleteAllEntriesBefore(DateTime limit, TimeSpan? span = null)
        {
            return DeleteLogEntriesBefore(limit, span) + DeleteExceptionEntriesBefore(limit, span);
        }

        public int CountLogEntries(LogEntryFilter filter=null)
        {
            var result = QueryLogEntries(filter);
            return result.Count();
        }

        public int CountExceptionEntries(ExceptionEntryFilter filter=null)
        {
            var result = QueryExceptionEntries(filter);

            return result.Count();
        }

      
        public LogEntry GetLogEntry(Guid id, DateTime? createdAtUtc = null)
        {
            return _context.LogEntries.SingleOrDefault(entry =>
                    (!createdAtUtc.HasValue || (createdAtUtc.HasValue && entry.CreatedAtUtc == createdAtUtc.Value))
                && entry.Id == id
            );

        }

       
        public ExceptionEntry GetExceptionEntry(Guid id, DateTime? createdAtUtc = null)
        {
            return _context.ExceptionEntries.SingleOrDefault(entry => entry.CreatedAtUtc == createdAtUtc && entry.Id == id);
        }



        /// <summary>
        /// Deletes all log entries created before, not including, <see cref="limit"/> in small batches to prevent a full table lock
        /// </summary>
        /// <param name="limit"></param>
        /// <param name="span"></param>
        /// <returns></returns>
        public int DeleteLogEntriesBefore(DateTime limit, TimeSpan? span = null)
        {
            //Get the olderst enty
            var oldest = _context.LogEntries.OrderBy(e => e.CreatedAtUtc).FirstOrDefault();

            if (oldest == null) return 0; //No entry records

            span = span ?? TimeSpan.FromHours(24);
            var batchLimit = oldest.CreatedAtUtc;

            var count = 0;
            do
            {

                batchLimit = batchLimit + span.Value;

                if (batchLimit > limit)
                    batchLimit = limit;

                var sqlResult = new SqlParameter
                {
                    ParameterName = "@nrofrows",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                };

                var sqlBatchlimit = new SqlParameter("@batchlimit", SqlDbType.DateTime2)
                {
                    Value = batchLimit
                };

                _context.Database.ExecuteSqlCommand("SET NOCOUNT OFF;DELETE FROM dbo.LogEntry WHERE CreatedAtUtc < @batchlimit; SELECT @nrofrows = @@ROWCOUNT; ", sqlBatchlimit, sqlResult);

                count += (int)sqlResult.Value;

            } while (batchLimit < limit);


            return count;
        }

        /// <summary>
        /// Deletes all exception entries created before, not including, <see cref="limit"/> in small batches to prevent a full table lock
        /// </summary>
        /// <param name="limit"></param>
        /// <param name="span">Batch size as TimeSpan</param>
        /// <returns></returns>
        public int DeleteExceptionEntriesBefore(DateTime limit, TimeSpan? span = null)
        {

            //Get the olderst enty
            var oldest = _context.ExceptionEntries.OrderBy(e => e.CreatedAtUtc).FirstOrDefault();

            if (oldest == null) return 0; //No entry records

            span = span ?? TimeSpan.FromHours(24);
            var batchLimit = oldest.CreatedAtUtc;

            var count = 0;
            do
            {

                batchLimit = batchLimit + span.Value;

                if (batchLimit > limit)
                    batchLimit = limit;

                var sqlResult = new SqlParameter
                {
                    ParameterName = "@nrofrows",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                };

                var sqlBatchlimit = new SqlParameter("@batchlimit", SqlDbType.DateTime2)
                {
                    Value = batchLimit
                };

                _context.Database.ExecuteSqlCommand("SET NOCOUNT OFF;DELETE FROM dbo.ExceptionEntry WHERE CreatedAtUtc < @batchlimit; SELECT @nrofrows = @@ROWCOUNT; ", sqlBatchlimit, sqlResult);

                count += (int)sqlResult.Value;

            } while (batchLimit < limit);


            return count;
        }

        private IQueryable<LogEntry> QueryLogEntries(LogEntryFilter filter = null)
        {

            var q = _context.LogEntries.AsQueryable();

            if (filter == null)
            {
                return q;
            }



            if (filter.AppNamePart != null)
            {
                q = q.Where(e => e.ApplicationName != null &&
                                 e.ApplicationName.ToUpper().Contains(filter.AppNamePart.ToUpper()));
            }

            if (filter.AreaNamePart != null)
            {
                q = q.Where(e => e.ApplicationArea != null &&
                                 e.ApplicationArea.ToUpper().Contains(filter.AreaNamePart.ToUpper()));
            }

            if (filter.RequestId != null)
            {
                q = q.Where(e => e.RequestId == filter.RequestId);

            }

            if (filter.SessionId != null)
            {
                q = q.Where(e => e.SessionId == filter.SessionId);

            }


            if (filter.MinLoggingLevel != null)
            {
                q = q.Where(e => e.LogLevel >= filter.MinLoggingLevel.Value);

            }
            if (filter.MaxLoggingLevel != null)
            {
                q = q.Where(e => e.LogLevel <= filter.MaxLoggingLevel.Value);

            }

            if (filter.MessageNr != null)
            {
                q = q.Where(e => e.MessageId == filter.MessageNr.Value);
            }

            if (filter.ContainedInMessage != null)
            {
                q =
                    q.Where(
                        e =>
                            e.Message != null &&
                            e.Message.ToUpper().Contains(filter.ContainedInMessage.ToUpper()));
            }

            if (filter.ContainedInDetail != null)
            {
                q =
                    q.Where(
                        e =>
                            e.Details != null &&
                            e.Details.ToUpper().Contains(filter.ContainedInDetail.ToUpper()));
            }

            if (filter.Starttime != null)
            {
                q = q.Where(e => e.CreatedAtUtc >= filter.Starttime.Value);
            }

            if (filter.Endtime != null)
            {
                q = q.Where(e => e.CreatedAtUtc < filter.Endtime.Value);
            }

            if (filter.StartStamp != null)
            {
                q = q.Where(e => e.Timestamp >= filter.StartStamp.Value);
            }

            if (filter.EndStamp != null)
            {
                q = q.Where(e => e.Timestamp < filter.EndStamp.Value);
            }



            return q;
        }

        private IQueryable<ExceptionEntry> QueryExceptionEntries(ExceptionEntryFilter filter)
        {


            var q = _context.ExceptionEntries.AsQueryable();

            if (filter == null)
                return q;

            if (filter.AppNamePart != null)
            {
                q = q.Where(e => e.ApplicationName != null &&
                                 e.ApplicationName.ToUpper().Contains(filter.AppNamePart.ToUpper()));
            }

            if (filter.AreaNamePart != null)
            {
                q = q.Where(e => e.ApplicationArea != null &&
                                 e.ApplicationArea.ToUpper().Contains(filter.AreaNamePart.ToUpper()));
            }

            if (filter.RequestId != null)
            {
                q = q.Where(e => e.RequestId == filter.RequestId);

            }

            if (filter.SessionId != null)
            {
                q = q.Where(e => e.SessionId == filter.SessionId);

            }
            if (filter.MessagePart != null)
            {
                q =
                    q.Where(
                        e =>
                            e.Message != null &&
                            e.Message.ToUpper().Contains(filter.MessagePart.ToUpper()));
            }

            if (filter.ExceptionTypePart != null)
            {
                q =
                    q.Where(
                        e =>
                            e.Type != null &&
                            e.Type.ToUpper().Contains(filter.ExceptionTypePart.ToUpper()));
            }

            if (filter.StackTracePart != null)
            {
                q =
                    q.Where(
                        e =>
                            e.StackTrace != null &&
                            e.StackTrace.ToUpper().Contains(filter.StackTracePart.ToUpper()));
            }

            if (filter.IsInnerException != null)
            {
                q =
                    q.Where(e => e.IsInnerException == filter.IsInnerException.Value);
            }

            if (filter.HasInnerException != null)
            {
                q = q.Where(e => e.InnerExceptionId != null);
            }


            if (filter.Starttime != null)
            {
                q = q.Where(e => e.CreatedAtUtc >= filter.Starttime.Value);
            }

            if (filter.Endtime != null)
            {
                q = q.Where(e => e.CreatedAtUtc < filter.Endtime.Value);
            }

            if (filter.StartStamp != null)
            {
                q = q.Where(e => e.Timestamp >= filter.StartStamp.Value);
            }

            if (filter.EndStamp != null)
            {
                q = q.Where(e => e.Timestamp < filter.EndStamp.Value);
            }


            return q;

        }


    }
}