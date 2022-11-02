using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace Icatt.Heartcore.Umbraco.Forms
{

    public static class FormProcessingExtensions
    {
        public static IApplicationBuilder UseUmbracoFormsProcessing(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<FormProcessingMiddleware>();
        }
    }

    internal record FormSubmission(string FormDefinitionId, Uri BackofficeUrl, JsonElement Body) : IFormSubmission;

    public interface IFormSubmission
    {
        string FormDefinitionId { get; }
        Uri BackofficeUrl { get; }
        JsonElement Body { get; }
    }

    public interface IFormProcessor
    {
        bool ShouldProcess(IFormSubmission formInstance);
        Task Process(IFormSubmission formInstance, CancellationToken cancellationToken);
    }

    internal class FormProcessingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<FormProcessingMiddleware> _logger;
        private readonly Uri _baseUri;

        public FormProcessingMiddleware(RequestDelegate next, ILogger<FormProcessingMiddleware> logger, UmbracoHeartcoreConfig config)
        {
            _next = next;
            _logger = logger;
            _baseUri = new Uri(config.BackofficeUrl);
        }

        //scoped lifetime service DI via invoke
        //https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#lifetime-and-registration-options
        public async Task Invoke(HttpContext httpContext, IEnumerable<IFormProcessor> processors)
        {
            var formId = string.Empty;
            var shouldSend = false;
            JsonElement root = default;
            var token = httpContext.RequestAborted;

            if (httpContext.Request.Method == HttpMethods.Post && httpContext.Request.Path.HasValue && httpContext.Request.Path.StartsWithSegments("/forms"))
            {

                //get the formId and any form data from the request before posting to umbraco

                var pathSegments = httpContext.Request.Path.Value.Split("/");
                if (pathSegments.Length > 1)
                {
                    formId = pathSegments[2];
                }

                if (!string.IsNullOrWhiteSpace(formId))
                {
                    shouldSend = true;
                    httpContext.Request.EnableBuffering();
                    using var doc = await JsonDocument.ParseAsync(httpContext.Request.Body, cancellationToken: token);
                    root = doc.RootElement.Clone();
                    httpContext.Request.Body.Position = 0;
                }
            }

            await _next(httpContext);

            if (shouldSend && httpContext.Response.StatusCode < 300)
            {
                //send mails affter form is saved in umbraco, don't fail on exceptions
                try
                {
                    var uri = new Uri(_baseUri, $"umbraco/#/forms/form/entries/{formId}");
                    var formSubmission = new FormSubmission(formId, uri, root);

                    foreach (var processor in processors)
                    {
                        if (!processor.ShouldProcess(formSubmission)) continue;
                        await processor.Process(formSubmission, token);
                    }
                }
                catch (Exception e)
                {
                    _logger.LogError(e, "Error sending notification and/or confirmation of form submission for {FormId}", formId);
                }
            }
        }
    }
}
