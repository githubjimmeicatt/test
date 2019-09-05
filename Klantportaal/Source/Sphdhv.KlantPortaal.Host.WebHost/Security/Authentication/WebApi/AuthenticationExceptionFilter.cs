using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http.Filters;
using System.Web.Security;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi
{
    public class AuthenticationExceptionFilter : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            if (context.Response == null)
            {
                var ex = context.Exception;

                var localEx = ex;

                var aggEx = ex as AggregateException;
                if (aggEx != null)
                {
                    localEx = aggEx.InnerExceptions.FirstOrDefault(ax => ax is AuthenticationException || ax is AuthorizationException);
                }

                if (!(localEx is AuthorizationException || localEx is AuthenticationException)) return;

                FormsAuthenticationTicket fat = new FormsAuthenticationTicket(1, "", DateTime.Now, DateTime.Now.AddMinutes(-30), false, "", FormsAuthentication.FormsCookiePath);
                var expireFormsCookie = new CookieHeaderValue(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(fat))
                {
                    Domain = FormsAuthentication.CookieDomain,
                    Path = FormsAuthentication.FormsCookiePath,
                    HttpOnly = true,
                    Secure = FormsAuthentication.RequireSSL
                };

                context.Response = new HttpResponseMessage();
                context.Response.Headers.AddCookies(new List<CookieHeaderValue>() { expireFormsCookie });
                context.Response.Content = new ObjectContent<ResponseModel<ActueelPensioenModel>>(
                    new ResponseModel<ActueelPensioenModel>(401, "Authentication/Authorization failed."),
                    new JsonpFormatter(context.Request)
                );

            }

            base.OnException(context);
        }
    }
}