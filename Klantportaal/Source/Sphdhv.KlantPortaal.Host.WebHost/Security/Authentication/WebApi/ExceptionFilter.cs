using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using System;
using System.Linq;
using System.Net.Http;
using System.Web.Http.Filters;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi
{
    public class GeneralExceptionFilter : ExceptionFilterAttribute
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

                if ((localEx is AuthorizationException || localEx is AuthenticationException)) return;


                context.Response = new HttpResponseMessage
                {
                    Content = new ObjectContent<ResponseModel<string>>(
                        new ResponseModel<string>(500, "Request processing failed."),
                        new JsonpFormatter()
                    )
                };

            }
            
            base.OnException(context);
        }
    }
}