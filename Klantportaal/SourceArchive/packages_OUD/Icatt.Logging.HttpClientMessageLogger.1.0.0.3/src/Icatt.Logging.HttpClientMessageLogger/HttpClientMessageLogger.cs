using System;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Infrastructure;

namespace Icatt.Logging
{
    public class HttpClientMessageLogger : DelegatingHandler
    {
        private readonly ILogger<ApplicationAreaEnum, LogMessageEnum> _logger;
        private bool _loggerEnabled = Properties.Settings.Default.LoggerEnabled;

        public bool LoggerEnabled
        {
            get { return _loggerEnabled; }
            set { _loggerEnabled = value; }
        }

        public HttpClientMessageLogger(ILoggerFactory loggerFactory, IContextFactory contextFactory, HttpMessageHandler innerHandler) : base(innerHandler)
        {
            _logger = loggerFactory.Create<ApplicationAreaEnum, LogMessageEnum>(contextFactory);
        }

        protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            //Execute and log possible exception
            Exception exception = null;
            HttpResponseMessage response = null;
            try
            {
                response = await base.SendAsync(request, cancellationToken).ConfigureAwait(true);
            }
            catch (Exception e)
            {
                exception = e;
                throw;
            }
            finally
            {
                if (null != exception || LoggerEnabled)
                {
                    //Log request
                    var requestLog = request.ToString() + Environment.NewLine + await GetContentAsString(request.Content).ConfigureAwait(true);
                    _logger.Log(ApplicationAreaEnum.HttpClient, LoggingLevel.Information, LogMessageEnum.Request, requestLog);

                    if (null != exception)
                    {
                        _logger.LogException(exception);
                    }

                    //Log response
                    if (null != response)
                    {
                        var responseLog = response.ToString() + Environment.NewLine + await GetContentAsString(response.Content).ConfigureAwait(true);
                        _logger.Log(ApplicationAreaEnum.HttpClient, LoggingLevel.Information, LogMessageEnum.Response, responseLog);
                    }
                }
            }

            return response;
        }

        private static async Task<string> GetContentAsString(HttpContent content)
        {
            if (content != null)
            {
                if (typeof(ByteArrayContent) == content.GetType())
                {
                    return Convert.ToBase64String(await content.ReadAsByteArrayAsync());
                }
                else
                {
                    return await content.ReadAsStringAsync();
                }
            }
            return null;
        }
    }
}