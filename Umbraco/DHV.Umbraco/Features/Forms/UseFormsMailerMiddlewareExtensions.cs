using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using Wsg.CorporateUmbraco.Config;
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
            var confirmAdres = string.Empty;
            var requestData = string.Empty;

           
            if (httpContext.Request.Path.HasValue && httpContext.Request.Path.StartsWithSegments("/forms"))
            {

                //get the formId and any form data from the request before posting to umbraco

                var pathSegments = httpContext.Request.Path.Value.Split("/");
                if (pathSegments.Length > 1)
                {
                    formId = pathSegments[2];
                }


                httpContext.Request.EnableBuffering();

                using var reader = new StreamReader(
                    httpContext.Request.Body,
                    encoding: Encoding.UTF8,
                    detectEncodingFromByteOrderMarks: false,
                    bufferSize: 1024,
                    leaveOpen: true);

                requestData = await reader.ReadToEndAsync();

                httpContext.Request.Body.Position = 0;
            }

            await _next(httpContext);

            if (httpContext.Request.Path.StartsWithSegments("/forms"))
            {

                if (httpContext.Response.StatusCode < 300)
                {
                    var cancellationToken = httpContext?.RequestAborted ?? CancellationToken.None;

                    //send mails affter form is saved in umbraco
                    await notification.SendAsync(formId, cancellationToken);
                    await confirmation.SendAsync(formId, requestData, cancellationToken);


                }

            }


        }
    }


}
