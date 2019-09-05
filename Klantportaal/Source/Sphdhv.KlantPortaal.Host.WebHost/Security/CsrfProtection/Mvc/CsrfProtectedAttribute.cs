using System.Web.Mvc;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection.Mvc
{
    public class CsrfProtectedAttribute : ActionFilterAttribute
    {
        private CsrfValidator<ActionExecutingContext> _template;

        public CsrfProtectedAttribute():this(CsrfSettings.CookieName, CsrfSettings.ParameterName)
        {

        }
       
        public CsrfProtectedAttribute(string cookieName, string parameterName)
        {
            _template = new CsrfValidator<ActionExecutingContext>(cookieName, parameterName)
            {
                GetCookie = GetCookie,
                GetQueryString = GetQueryString,
                OnViolation = OnViolation
            };
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            _template.Execute(filterContext);
        }

        protected virtual void OnViolation(ActionExecutingContext filterContext)
        {
            filterContext.Result = new JsonResult()
            {
                Data = CsrfResponses.ViolationResponse,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        private string GetCookie(ActionExecutingContext context, string csrfTokenCookieName)
        {
            var request = context.HttpContext.Request;
            return request.Cookies[csrfTokenCookieName]?.Value;
        }

        private string GetQueryString(ActionExecutingContext context, string csrfTokenParamName)
        {
            var request = context.HttpContext.Request;
            return request.QueryString[csrfTokenParamName];
        }
    }
}