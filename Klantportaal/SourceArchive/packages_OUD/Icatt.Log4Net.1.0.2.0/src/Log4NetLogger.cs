using System;
using System.Collections.Generic;
using System.Reflection;
using Icatt.Infrastructure;
using log4net;
using log4net.Core;
using Icatt.Logging;


namespace Icatt.Log4Net
{
    /// <summary>
    /// Class that implements <see cref="ILogger"/> by using Log4Net. 
    /// </summary>
    /// <typeparam name="TAppAreaEnum"></typeparam>
    /// <typeparam name="TLogMessageEnum"></typeparam>
    /// <remarks>Consuming apps can to create a concrete implementating with the enumerators the list the area's en messages in that app
    /// </remarks>
    public class Log4NetLogger<TAppAreaEnum,TLogMessageEnum> : LoggerBase<TAppAreaEnum, TLogMessageEnum>
    {

        // ReSharper disable once StaticMemberInGenericType - intentional, independent of type variation
        private static  ILog _log4NetLogger;

        // ReSharper disable once StaticMemberInGenericType - intentional, independent of type variation
        private static readonly object Lock = new object();

        private static ILog StaticLogger
        {
            get
            {
                if (_log4NetLogger == null)
                {
                    lock (Lock)
                    {
                        if (_log4NetLogger == null)
                        {
                            //TODO configure repository in app startup
                            _log4NetLogger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
                        }
                    }
                }

                return _log4NetLogger;
            }
        }

        public Log4NetLogger(IContextFactory contextFactory,IDictionary<TLogMessageEnum,  string> messageDictionary = null)
                : base(contextFactory,  messageDictionary)
        {
        }


        #region implementation abstract base members

        protected override bool LevelEnabled(LoggingLevel level)
        {
            var log4NetLevel = MapToLog4NetLevel(level);

            //Avoid overhead of building event by checking level first
            return StaticLogger.Logger.IsEnabledFor(log4NetLevel);
        }


        protected override void WriteLog(string appName, string appArea,Guid requestId, Guid sessionId, Exception ex, DateTime createdAtUtc, long timestamp)
        {
            if (ex == null) return; //Logger should not throw

            var logEvent = CreateLoggingEvent(CustomLevels.ExceptionLevel, ex.Message, ex);
            logEvent.Properties[CustomProperties.ApplicationNameProperty] = appName;
            logEvent.Properties[CustomProperties.ApplicationAreaProperty] = appArea;
            logEvent.Properties[CustomProperties.SessionIdProperty] = sessionId;
            logEvent.Properties[CustomProperties.RequestIdProperty] = requestId;
            logEvent.Properties[CustomProperties.CreatedAtUtcProperty] = createdAtUtc;
            logEvent.Properties[CustomProperties.TimestampProperty] = timestamp;

            StaticLogger.Logger.Log(logEvent);
        }

        protected override void WriteLog(string appName, string appArea, LoggingLevel level, Guid sessionId, Guid requestId, int messageNr, string message, string detail, DateTime createdAtUtc, long timestamp)
        {
            var log4NetLevel = MapToLog4NetLevel(level);

            // Create log event for custuom field support.
            var logEvent = CreateLoggingEvent(log4NetLevel, message);

            // Add the custom fields.
            logEvent.Properties[CustomProperties.ApplicationNameProperty] = appName;
            logEvent.Properties[CustomProperties.ApplicationAreaProperty] = appArea;
            logEvent.Properties[CustomProperties.DetailsProperty] = detail;
            logEvent.Properties[CustomProperties.MessageNumberProperty] = messageNr;
            logEvent.Properties[CustomProperties.TimestampProperty] = timestamp;
            logEvent.Properties[CustomProperties.CreatedAtUtcProperty] = createdAtUtc;
            logEvent.Properties[CustomProperties.SessionIdProperty] = sessionId;
            logEvent.Properties[CustomProperties.RequestIdProperty] = requestId;

            StaticLogger.Logger.Log(logEvent);

        }

        #endregion

        #region private methods

        private static Level MapToLog4NetLevel(LoggingLevel level)
        {
            Level log4NetLevel;
            switch (level)
            {
                case LoggingLevel.Finest:
                    log4NetLevel = Level.Finest;
                    break;
                //case LoggingLevel.Finer:
                case LoggingLevel.InfoDetail:
                    log4NetLevel = Level.Finer;
                    break;
                case LoggingLevel.Fine:
                    log4NetLevel = Level.Debug;
                    break;
                case LoggingLevel.Information:
                    log4NetLevel = Level.Info;
                    break;
                case LoggingLevel.Notice:
                    log4NetLevel = Level.Notice;
                    break;
                case LoggingLevel.Warning:
                    log4NetLevel = Level.Warn;
                    break;
                case LoggingLevel.Error:
                    log4NetLevel = Level.Error;
                    break;
                case LoggingLevel.Severe:
                    log4NetLevel = Level.Severe;
                    break;
                case LoggingLevel.Critical:
                    log4NetLevel = Level.Critical;
                    break;
                case LoggingLevel.Alert:
                    log4NetLevel = Level.Alert;
                    break;
                case LoggingLevel.Fatal:
                    log4NetLevel = Level.Fatal;
                    break;
                case LoggingLevel.Emergency:
                    log4NetLevel = Level.Emergency;
                    break;
                default:
                    log4NetLevel = Level.Error;
                    break;
            }
            return log4NetLevel;
        }

        private LoggingEvent CreateLoggingEvent(Level level, string message, Exception exception = null)
        {
            // Create log event for custum field support.
            return new LoggingEvent(MethodBase.GetCurrentMethod().DeclaringType, LogManager.GetRepository(), StaticLogger.Logger.Name, level, message, exception);
        }

        #endregion

    }
}