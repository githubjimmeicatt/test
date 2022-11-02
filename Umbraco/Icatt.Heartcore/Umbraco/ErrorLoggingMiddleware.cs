using System;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Yarp.ReverseProxy.Forwarder;

namespace Microsoft.AspNetCore.Builder
{
    public static class ErrorLoggingMiddlewareExtensions
    {
        public static IServiceCollection AddUmbracoErrorBodyLogging(this IServiceCollection services) => services.AddSingleton<IForwarderHttpClientFactory, CustomClientFactory>();

        // https://microsoft.github.io/reverse-proxy/articles/http-client-config.html#custom-iforwarderhttpclientfactory
        private class CustomClientFactory : ForwarderHttpClientFactory
        {
            private readonly ILogger<CustomClientFactory> _logger;

            public CustomClientFactory(ILogger<CustomClientFactory> logger) => _logger = logger;

            protected override HttpMessageHandler WrapHandler(ForwarderHttpClientContext context, HttpMessageHandler handler) => base.WrapHandler(context, new ErrorLoggingHandler(handler, _logger));
        }

        private class ErrorLoggingHandler : DelegatingHandler
        {
            private readonly ILogger _logger;

            public ErrorLoggingHandler(HttpMessageHandler inner, ILogger logger) : base(inner)
            {
                _logger = logger;
            }

            protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
            {
                var result = await base.SendAsync(request, cancellationToken);
                if ((int)result.StatusCode >= 500)
                {
                    string text;
                    var encoding = result.Content.Headers.TryGetValues("Content-Encoding", out var e) ? e.ToArray() : Array.Empty<string>();
                    if (encoding.Any(e => e.Equals("br", StringComparison.OrdinalIgnoreCase)))
                    {
                        await using var stream = await result.Content.ReadAsStreamAsync(cancellationToken);
                        await using var brotli = new BrotliStream(stream, CompressionMode.Decompress);
                        using var reader = new StreamReader(brotli);
                        text = await reader.ReadToEndAsync();

                    }
                    else if (encoding.Any(e => e.Equals("gzip", StringComparison.OrdinalIgnoreCase)))
                    {
                        await using var stream = await result.Content.ReadAsStreamAsync(cancellationToken);
                        await using var gzip = new GZipStream(stream, CompressionMode.Decompress);
                        using var reader = new StreamReader(gzip);
                        text = await reader.ReadToEndAsync();
                    }
                    else
                    {
                        text = await result.Content.ReadAsStringAsync(cancellationToken);
                    }
                    _logger.LogError("Error in response van umbraco: {StatusCode}, {UmbracoError}", result.StatusCode, text);

                }
                return result;
            }
        }
    }
}
