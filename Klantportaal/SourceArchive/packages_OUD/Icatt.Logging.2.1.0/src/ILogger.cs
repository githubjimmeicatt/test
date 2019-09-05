using System;

namespace Icatt.Logging
{
    /// <summary>
    /// Interface defining the conpany logging standard. Use <see cref="LoggerBase{TAppAreaEnum,TLogMessageEnum}"/> for concrete implementations
    /// </summary>
    /// <typeparam name="TAppAreaEnum"></typeparam>
    /// <typeparam name="TLogMessageEnum"></typeparam>
    public interface ILogger<in TAppAreaEnum, in TLogMessageEnum>: IExceptionLogger
    {
        event EventHandler<SessionStartedEventArgs> SessionStarted;

        event EventHandler<RequestStartedEventArgs> RequestStarted;

        void LogException(TAppAreaEnum appArea, Exception ex);

        [JetBrains.Annotations.StringFormatMethod("detailFormat")]
        void Log(TAppAreaEnum applicationArea, LoggingLevel level, TLogMessageEnum msgNr,string detailFormat, params object[] arguments);

    }
}
