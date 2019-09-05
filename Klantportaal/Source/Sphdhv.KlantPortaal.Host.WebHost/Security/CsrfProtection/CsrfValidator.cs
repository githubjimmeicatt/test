using System;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection
{
    public class CsrfValidator<TContext>
    {
        protected string CookieName { get; }
        protected string ParameterName { get; }

        public CsrfValidator(string cookieName, string parameterName)
        {
            this.CookieName = cookieName;
            this.ParameterName = parameterName;
        }

        public void Execute(TContext actionContext)
        {
            var cookieValue = GetCookie(actionContext, CookieName);
            var querystringValue = GetQueryString(actionContext, ParameterName);

            if (
                string.IsNullOrWhiteSpace(cookieValue)
                ||
                0 != string.Compare(cookieValue, querystringValue, StringComparison.Ordinal)
            )
            {
                OnViolation(actionContext);
            }
        }

        public Func<TContext, string, string> GetQueryString;
        public Func<TContext, string, string> GetCookie;
        public Action<TContext> OnViolation;
    }
}