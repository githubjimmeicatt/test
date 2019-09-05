using System;
using log4net.Appender;
using log4net.Core;
using Icatt.Logging.DataAccess;
using Icatt.Logging.Entities;

namespace Icatt.Log4Net
{
	public class DatabaseAppender : AppenderSkeleton
	{
	    private readonly ILoggingRepositoryFactory _factory;


        /// <summary>
        /// Property is set to the LoggingRepositoryFactoryType element value
        /// </summary>
        //public string LoggingRepositoryFactoryType { get; set; }

	    public DatabaseAppender(ILoggingRepositoryFactory factory)
	    {
	        _factory = factory;
	    }

	    public DatabaseAppender() :this (new LoggingRepositoryFactory(Properties.Settings.Default.DatabaseAppenderTimeoutInSeconds))
	    {
	    }


	    protected override bool RequiresLayout
	    {
	        get
	        {
                return false;
            }
        }


	    /// <summary>
        /// Property is set to the ConnectionStringOrname element value
        /// </summary>
        public string ConnectionStringOrname { get; set; }


        #region Overrides of BufferingAppenderSkeleton

        /// <summary> Save given logging event to logging datebase. </summary>
        protected override void Append( LoggingEvent e )
		{
            
			using (var rep = _factory.Create(ConnectionStringOrname) )
			{
				if ( e.Level == CustomLevels.ExceptionLevel )
                    AppendException(rep, e );
				else
					AppendEntry(rep, e );
            }
		}


	    #endregion

		#region Private and protected support methods

		private void AppendEntry( ILoggingRepository repository, LoggingEvent e )
		{
            // Get custom fields from event.
            var appName = e.Properties[CustomProperties.ApplicationNameProperty] as string;
            var area =  e.Properties[CustomProperties.ApplicationAreaProperty] as string;
			var details =  e.Properties[CustomProperties.DetailsProperty] as string;
		    var msgNrValue = e.Properties[CustomProperties.MessageNumberProperty];
            var msgnr = msgNrValue == null ? -1 : (int) msgNrValue;
		    var timeStamp = (long)e.Properties[CustomProperties.TimestampProperty];
            var createdAdUtc = (DateTime) e.Properties[CustomProperties.CreatedAtUtcProperty];
            var sessionId = (Guid?)e.Properties[CustomProperties.SessionIdProperty];
            var requestId = (Guid?)e.Properties[CustomProperties.RequestIdProperty];

            // Create and add entry for event.
            var logEntry = new LogEntry
			    {
					Id = Guid.NewGuid(),
                    Message = e.RenderedMessage, 
                    Details = details,
			        ApplicationName = appName,
                    ApplicationArea = area,
			        LogLevel = e.Level.Value,
			        CreatedAtUtc = createdAdUtc,
                    Timestamp = timeStamp,
                    MessageId = msgnr,
                    RequestId = requestId,
                    SessionId = sessionId
			    };

		    repository.Add(logEntry);

		}

		private void AppendException(ILoggingRepository rep, LoggingEvent e )
		{
			// Check argument.
		    var ex = e.Properties[CustomProperties.ExceptionProperty] as Exception ?? e.ExceptionObject;
			if ( ex == null )
			{
				ErrorHandler.Error("Custom property ExceptionProperty was not set on the LoggingEvent event and the ExceptionObject property was null. No exception can be logged");
				return;
			}


		    RecursiveAppendException(rep, e, ex,false);

		
		}


	    private ExceptionEntry RecursiveAppendException(ILoggingRepository rep, LoggingEvent e, Exception ex,bool isInnerException)
	    {
            // Create a log entry for the exception.
            var log = NewExceptionEntry(e, ex,isInnerException);

            // Unwind the inner exceptions.
            var innerException = ex.InnerException;
            var depth = 0;
            if (innerException != null)
            {
                var innerEntry = RecursiveAppendException(rep, e, innerException,true);
                log.InnerExceptionId = innerEntry.Id;
                depth = innerEntry.Depth+1;
            }
            // Add the original exception and submit to the database.

            log.Depth = depth;
            rep.Add(log);

	        return log;

	    }

        // Create a new exception record object from system exception.	
        private  ExceptionEntry NewExceptionEntry(LoggingEvent logEvent, Exception ex, bool isInnerException)
		{
            var appName = (string)logEvent.Properties[CustomProperties.ApplicationNameProperty];
            var area = (string) logEvent.Properties[CustomProperties.ApplicationAreaProperty];
            var timestamp = (long)logEvent.Properties[CustomProperties.TimestampProperty];
            var createdAtUtc = (DateTime)logEvent.Properties[CustomProperties.CreatedAtUtcProperty];
            var sessionId = (Guid)logEvent.Properties[CustomProperties.SessionIdProperty];
            var requestId = (Guid)logEvent.Properties[CustomProperties.RequestIdProperty];

            return new ExceptionEntry
		    {
				Id = Guid.NewGuid(),
		        ApplicationName = appName,
                ApplicationArea = area,
		        Message = ex.Message,
                Type = ex.GetType().ToString(),
		        Source = ex.Source,
                StackTrace = ex.StackTrace,
		        TargetSite = ( ex.TargetSite != null && ex.TargetSite.DeclaringType != null ? ex.TargetSite.DeclaringType.FullName + "." + ex.TargetSite.Name : "" ),
		        InnerExceptionId = null,
                IsInnerException = isInnerException,
				CreatedAtUtc = createdAtUtc,
                Timestamp = timestamp,
                SessionId = sessionId,
                RequestId = requestId
		    };
		}

		#endregion
	}
}
