using Serilog;
using Serilog.Exceptions;

namespace Sphdhv.KlantPortaal.Host.WebHost
{
    public class LoggingConfig
    {
        public static LoggerConfiguration RegisterConfig()
        {
            return new LoggerConfiguration()
                .ReadFrom.AppSettings()
                .MinimumLevel.Debug()
                .Enrich.FromLogContext()
                .Enrich.WithMachineName()
                .Enrich.WithHttpRequestId()
                .Enrich.WithHttpRequestUrl()
                .Enrich.WithHttpRequestType()
                .Enrich.WithExceptionDetails()
                .Enrich.WithHttpSessionId();
        }
    }
}
