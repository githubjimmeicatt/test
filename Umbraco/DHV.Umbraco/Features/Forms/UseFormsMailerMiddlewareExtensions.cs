using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Wsg.CorporateUmbraco.Features.Forms;

namespace Wsg.CorporateUmbraco
{

    public static class FormsMailerMiddlewareExtensions
    {
        public static IApplicationBuilder UseFormsMailer(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<FormsMailerMiddleware>();
        }
    }

    public class FormsMailerMiddleware
    {
        private readonly RequestDelegate _next;

        public FormsMailerMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        //scoped lifetime service DI via invoke
        //https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#lifetime-and-registration-options
        public async Task Invoke(HttpContext httpContext, SendFormSubmittedNotification notification, SendFormSubmittedConfirmation confirmation)
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
                //send mails affter form is saved in umbraco
                await notification.SendAsync(formId, root, token);
                await confirmation.SendAsync(formId, root, token);
            }
        }
    }
}
