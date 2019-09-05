using System;
using System.Diagnostics;
using Icatt.Infrastructure;

namespace Icatt.Logging
{
    /// <summary>
    /// Abstract implementation of <see cref="IExceptionLogger"/>. Use this base class for implementing concrete exception loggers
    /// </summary>
    public abstract class ExceptionLoggerBase : IExceptionLogger
    {
        private readonly IContextFactory _contextFactory;

        public event EventHandler<SessionStartedEventArgs> SessionStarted;
        public event EventHandler<RequestStartedEventArgs> RequestStarted;

        protected ExceptionLoggerBase(IContextFactory contextFactory)
        {
            _contextFactory = contextFactory;
        }

        protected abstract bool LevelEnabled(LoggingLevel level);

        protected abstract void WriteLog(string appName, string appArea, Guid requestId, Guid sessionId, Exception ex, DateTime createdAtUtc, long timestamp);

        public void LogException(Exception ex)
        {
            //Prevent overload of building logmessage
            if (!LevelEnabled(LoggingLevel.Exception)) return;

            var appName = Properties.Settings.Default.LoggingApplication;
            var requestId = GetRequestId();
            var sessionId = GetSessionId();

            WriteLog(appName, null, requestId, sessionId, ex, DateTime.UtcNow, Stopwatch.GetTimestamp());
        }

        protected internal Guid GetRequestId()
        {
            var requestIdService = _contextFactory.CreateRequestIdService();

            var id = requestIdService.GetRequestId();

            if (id.HasValue) return id.Value;

            id = requestIdService.EnsureRequestId();

            OnRequestStarted(new RequestStartedEventArgs(id.Value));

            return id.Value;
        }

        protected internal Guid GetSessionId()
        {

            var sessionIdService = _contextFactory.CreateSessionIdService();

            var id = sessionIdService.GetSessionId();

            if (id.HasValue) return id.Value;

            id = sessionIdService.EnsureSessionId();

            OnSessionStarted(new SessionStartedEventArgs(id.Value));

            return id.Value;
        }

        protected virtual void OnSessionStarted(SessionStartedEventArgs e)
        {
            if (SessionStarted != null)
                SessionStarted.Invoke(this, e);
        }

        protected virtual void OnRequestStarted(RequestStartedEventArgs e)
        {
            if (RequestStarted != null)
                RequestStarted.Invoke(this, e);
        }
    }
}