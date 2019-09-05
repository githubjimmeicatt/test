using System;
using System.Collections.Generic;
using Icatt.Logging.Entities;
using LogEntry = Icatt.Logging.Entities.LogEntry;

namespace Icatt.Logging.DataAccess
{
    public interface ILoggingRepository : IDisposable
    {
        void Add(LogEntry logEntry);

        void Add(ExceptionEntry exceptionEntry);

        /// <summary>
        /// Queries the LogEntry table. Only returns 1000 records by default
        /// </summary>
        IList<LogEntry> GetLogEntries(LogEntryFilter filter= null, int take = 1000, int skip = 0, bool ascending = false);

        /// <summary>
        /// Counts all records that match the filter
        /// </summary>
        int CountLogEntries(LogEntryFilter filter=null);

        /// <summary>
        /// Queries the ExceptionEntry table. Only returns 1000 records by default
        /// </summary>
        IList<ExceptionEntry> GetExceptionEntries(ExceptionEntryFilter filter=null, int take = 1000, int skip = 0, bool @ascending = false);

        /// <summary>
        /// Counts all records that match the filter
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        int CountExceptionEntries(ExceptionEntryFilter filter=null);

        int DeleteLogEntriesBefore(DateTime utcNow, TimeSpan? span = null);
        int DeleteExceptionEntriesBefore(DateTime utcNow, TimeSpan? span = null);
        int DeleteAllEntriesBefore(DateTime limit, TimeSpan? span = null);

        /// <summary>
        /// Retrieves a single LogEntry by Id and CreatedAtUtc. NB!!! Omitting the <paramref name="createdAtUtc"/> paramter makes the query MUCH MUCH slower, because the table only has an index on CreatedAtUtc
        /// </summary>
        /// <param name="id">Uniquely identifies the LogEntry</param>
        /// <param name="createdAtUtc">EXACT CreatedAtUtc for the LogEntry to speed up query.NB!!! Omitting this parameter makes the query MUCH MUCH slower, because the table only has an index on CreatedAtUtc</param>
        /// <returns></returns>
        LogEntry GetLogEntry(Guid id, DateTime? createdAtUtc = null);

        /// <summary>
        /// Retrieves a single ExceptionEntry by Id and CreatedAtUtc. NB!!! Omitting the <paramref name="createdAtUtc"/> paramter makes the query MUCH MUCH slower, because the table only has an index on CreatedAtUtc
        /// </summary>
        /// <param name="id">Uniquely identifies the ExceptionEntry</param>
        /// <param name="createdAtUtc">EXACT CreatedAtUtc for the ExceptionEntry to speed up query. NB!!! Omitting this parameter makes the query MUCH MUCH slower, because the table only has an index on CreatedAtUtc</param>
        /// <returns></returns>
        ExceptionEntry GetExceptionEntry( Guid id, DateTime? createdAtUtc = null);

    }
}
