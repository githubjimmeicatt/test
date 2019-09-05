using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Icatt.Infrastructure;
using Icatt.Logging.Exceptions;

namespace Icatt.Logging
{

    /// <summary>
    /// Abstract implementation of <see cref="ILogger{TAppAreaEnum,TLogMessageEnum}"/>. Use this base class for implementing concrete loggers
    /// </summary>
    /// <typeparam name="TAppAreaEnum"></typeparam>
    /// <typeparam name="TLogMessageEnum"></typeparam>
    public abstract class LoggerBase<TAppAreaEnum, TLogMessageEnum> : ExceptionLoggerBase, ILogger<TAppAreaEnum, TLogMessageEnum>
    {
        private readonly IContextFactory _contextFactory;
        private readonly IDictionary<TLogMessageEnum, string> _messageDictionary;

        protected LoggerBase(IContextFactory contextFactory, IDictionary<TLogMessageEnum, string> messageDictionary = null):base(contextFactory)
        {
            if (!typeof (TAppAreaEnum).IsEnum || !typeof (TLogMessageEnum).IsEnum)
                throw new InvalidILoggerImplementation(GetType(), typeof (TAppAreaEnum), typeof (TLogMessageEnum));

            if (Enum.GetUnderlyingType(typeof(TLogMessageEnum)) != typeof(int))
                throw new InvalidILoggerImplementation(GetType(), typeof(TAppAreaEnum), typeof(TLogMessageEnum));

            _messageDictionary = messageDictionary;
            _contextFactory = contextFactory;

        }

        /// <summary>
        /// Writes message and detail strings
        /// </summary>
        /// <param name="appName"></param>
        /// <param name="appArea"></param>
        /// <param name="level"></param>
        /// <param name="sessionId"></param>
        /// <param name="requestId"></param>
        /// <param name="messageNr">Corresponding message nr. Must not be zero</param>
        /// <param name="message">Message string. Must not be null or empty</param>
        /// <param name="detail">Detailed info. Can be null</param>
        /// <param name="createdAtUtc"></param>
        /// <param name="timestamp"></param>
        protected abstract void WriteLog(string appName, string appArea, LoggingLevel level, Guid sessionId, Guid requestId, int messageNr, string message, string detail, DateTime createdAtUtc, long timestamp);

        public void LogException(TAppAreaEnum appArea, Exception ex)
        {
            //Prevent overload of building logmessage
            if (!LevelEnabled(LoggingLevel.Exception)) return;

            var areaName = BuildAreaName(appArea);

            var appName = Properties.Settings.Default.LoggingApplication;

            var requestId = GetRequestId();
            var sessionId = GetSessionId();

            try
            {
                //geen fire and forget, wel timeout op task
                var t = new Task(() => WriteLog(appName, areaName, requestId, sessionId, ex, DateTime.UtcNow, Stopwatch.GetTimestamp()));
                t.Start();
                t.Wait(Properties.Settings.Default.WriteLogTimeoutInMilliSeconds);


            }
            catch (Exception )
            {
                //Hide logging exception for caller... cannot log if logging fails :-(
            }
        }

        private string BuildAreaName(TAppAreaEnum appArea)
        {
            var areaEnum = appArea as Enum;
            if (areaEnum == null)
                throw new InvalidILoggerImplementation(GetType(), typeof (TAppAreaEnum), typeof (TLogMessageEnum));
            var areaName = areaEnum.ToString();
            return areaName;
        }


        public void Log(TAppAreaEnum appArea, LoggingLevel level, TLogMessageEnum msgNr, string detailFormat,
            params object[] arguments)
        {
            //Prevent overload of building logmessage if level is not enabled
            if (!LevelEnabled(level)) return;

            if (msgNr == null) throw new ArgumentNullException("msgNr");
            if (appArea == null) throw new ArgumentNullException("appArea");

            var message = BuildMessage(msgNr);
            var areaName = BuildAreaName(appArea);

            //Because of type checks in constructor and null argument check this can be done without further ado
            var msgInt = Convert.ToInt32(msgNr);

            //Logging must be robust.. do not fail on formatting the detail string
            string detail;
            try
            {
                detail = arguments == null || arguments.Length == 0
                            ? detailFormat
                            : string.Format(detailFormat, arguments);
            }
            catch (FormatException)
            {
                var argList = arguments == null
                    ? " (arguments NULL)"
                    : arguments.Aggregate(" !!Logger String.format failed for the detail format string with these arguments: ",(s, i) => s + i.ToString() + ", ");

                detail = detailFormat + argList;
            }

            var appName = Properties.Settings.Default.LoggingApplication;

            var requestId = GetRequestId();
            var sessionId = GetSessionId();

            try
            {
                //geen fire and forget, wel timeout op task
                var t = new Task(() => WriteLog(appName, areaName, level, sessionId, requestId, msgInt, message, detail, DateTime.UtcNow, Stopwatch.GetTimestamp()));
                t.Start();
                t.Wait(Properties.Settings.Default.WriteLogTimeoutInMilliSeconds);
            }
            catch (Exception)
            {
                //Hide logging exception for caller... cannot log if logging fails :-(
            }
        }

        private string BuildMessage(TLogMessageEnum msgNr)
        {
            string message;

            var msgEnum = msgNr as Enum;
            if (msgEnum == null)
                throw new InvalidILoggerImplementation(GetType(), typeof (TAppAreaEnum), typeof (TLogMessageEnum));

            if (_messageDictionary == null || !_messageDictionary.TryGetValue(msgNr, out message))
            {
                return msgEnum.ToString();
            }

            return message;

        }
    }
}
