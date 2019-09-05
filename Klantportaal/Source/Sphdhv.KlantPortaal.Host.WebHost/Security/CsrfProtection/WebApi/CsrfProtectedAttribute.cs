using System.Linq;
using System.Net.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection.WebApi
{
    public class CsrfProtectedAttribute : ActionFilterAttribute
    {
        private CsrfValidator<HttpActionContext> _template;
        

        public CsrfProtectedAttribute() : this(CsrfSettings.CookieName, CsrfSettings.ParameterName)
        {

        }

        public CsrfProtectedAttribute(string cookieName, string parameterName)
        {
            _template = new CsrfValidator<HttpActionContext>(cookieName, parameterName)
            {
                GetCookie = GetCookie,
                GetQueryString = GetQueryString,
                OnViolation = OnViolation
            };
        }

        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            _template.Execute(actionContext);
            base.OnActionExecuting(actionContext);
        }

        protected virtual void OnViolation(HttpActionContext filterContext)
        {
            filterContext.Response = new HttpResponseMessage()
            {
                Content = new ObjectContent<ResponseMessage>(
                    CsrfResponses.ViolationResponse,
                    new JsonpFormatter(filterContext.Request)
                )
            };
        }

        private static string GetQueryString(HttpActionContext filterContext, string key)
        {
            var request = filterContext.Request;
            var queryStrings = request.GetQueryNameValuePairs();
            if (queryStrings == null)
                return null;

            var match = queryStrings.FirstOrDefault(kv => string.Compare(kv.Key, key, true) == 0);
            if (string.IsNullOrEmpty(match.Value))
                return null;

            return match.Value;
        }

        private static string GetCookie(HttpActionContext filterContext, string key)
        {
            var request = filterContext.Request;
            var authCookie = request.Headers.GetCookies(key).FirstOrDefault();
            if (authCookie == null)
                return null;

            return authCookie[key].Value;
        }
    }
}