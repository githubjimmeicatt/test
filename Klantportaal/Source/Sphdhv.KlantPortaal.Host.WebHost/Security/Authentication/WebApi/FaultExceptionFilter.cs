using Icatt.ServiceModel;
using Sphdhv.DeelnemerPortalApi.Contract;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using System.Net.Http;
using System.Web.Http.Filters;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi
{
    public class FaultExceptionFilter : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            var ex = context.Exception;
            if (!(ex is FaultException)) return;

            if(ex.InnerException.GetType().Name == typeof(PortalApiException).Name)
            {
                context.Response = new HttpResponseMessage
                {
                    Content = new ObjectContent<ResponseModel<ActueelPensioenModel>>(
                    new ResponseModel<ActueelPensioenModel>(400, ex.InnerException.Message),
                    new JsonpFormatter())
                };
            }
            base.OnException(context);
        }
    }
}