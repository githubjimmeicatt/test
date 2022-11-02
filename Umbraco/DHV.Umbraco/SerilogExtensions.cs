using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Serilog;
using Serilog.AspNetCore;
using Serilog.Core;
using Serilog.Events;

namespace Wsg.CorporateUmbraco
{
    public static class SerilogExtensions
    {
        public static RequestLoggingOptions SetCancellationLogLevel(this RequestLoggingOptions options, LogEventLevel logLevel)
        {
            var inner = options.GetLevel;
            options.GetLevel = (HttpContext httpContext, double elapsed, Exception exception) =>
                httpContext.RequestAborted.IsCancellationRequested
                    ? logLevel
                    : inner(httpContext, elapsed, exception);
            return options;
        }

        public static LoggerConfiguration IgnoreRequestCancellation(this LoggerConfiguration config, IServiceProvider services)
        {
            var filter = new RequestCancellationLogEventFilter(services.GetRequiredService<IHttpContextAccessor>());
            return config
                .Filter.With(filter)
                .Enrich.With(filter);
        }

        public static RequestLoggingOptions EnrichWithHostName(this RequestLoggingOptions opt) 
        {
            var inner = opt.EnrichDiagnosticContext;
            
            opt.EnrichDiagnosticContext = (diagnosticContext, httpContext) =>
            {
                diagnosticContext.Set("Host", httpContext.Request.Host.Host);
                inner?.Invoke(diagnosticContext, httpContext);
            };

            return opt;
        }
    }

    public class RequestCancellationLogEventFilter : ILogEventFilter, ILogEventEnricher
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public RequestCancellationLogEventFilter(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public bool IsEnabled(LogEvent logEvent) =>
            !IsCancelled()
            || logEvent.Exception is not TaskCanceledException;

        public void Enrich(LogEvent logEvent, ILogEventPropertyFactory propertyFactory)
        {
            if (IsCancelled() && logEvent.Properties.ContainsKey("StatusCode"))
            {
                logEvent.AddOrUpdateProperty(propertyFactory.CreateProperty("StatusCode", "Canceled"));
            }
        }

        private bool IsCancelled() =>
            _httpContextAccessor.HttpContext is not null
            && _httpContextAccessor.HttpContext.RequestAborted.IsCancellationRequested;
    }


}
