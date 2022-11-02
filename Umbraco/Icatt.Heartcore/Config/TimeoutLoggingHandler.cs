using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class CancellationLoggingHandlerExtensions
    {
        public static IHttpClientBuilder LogAndAbsorbTimeout(this IHttpClientBuilder builder)
        {
            builder.AddHttpMessageHandler(s => new CancellationLoggingHandler(s.GetRequiredService<ILogger<CancellationLoggingHandler>>()));
            return builder;
        }

        private class CancellationLoggingHandler : DelegatingHandler
        {
            private readonly ILogger<CancellationLoggingHandler> _log;

            public CancellationLoggingHandler(ILogger<CancellationLoggingHandler> log) : base()
            {
                _log = log;
            }

            protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
            {
                try
                {
                    return await base.SendAsync(request, cancellationToken);
                }
                catch (TaskCanceledException ex) when (!cancellationToken.IsCancellationRequested)
                {
                    // Handle timeout.
                    _log.LogWarning(ex, "Timeout for request to {url}", request.RequestUri?.ToString());
                    return new HttpResponseMessage();
                }
            }
        }
    }


}
