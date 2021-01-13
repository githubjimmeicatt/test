
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.KlantPortaal.Host.WebHost.Models;
using Sphdhv.KlantPortaal.Host.WebHost.Properties;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.Security.Environment;
using Sphdhv.Security.Manager.Authentication.Interface;
using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Security;
using AuthMethodType = Icatt.OAuth.Contract.AuthMethodType;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class AuthenticationController : Controller
    {
        // GET: Login (login user op klantportaal
        public ActionResult Login([FromUri(Name = "relaystate")]string relaystate = null)
        {
            //Return URL is hier de DNN return url

            //

            var container = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext
            {
                ApplicationId = Settings.Default.ApplicationId,
                EnvironmentId = Settings.Default.EnvironmentId,
            };
            var proxy = container.ProxyFactory.CreateProxy<Manager.Authentication.Interface.IAuthenticationManager>(context);

            var authMethod = proxy.AuthenticationMethod(context.ApplicationId, context.EnvironmentId, "", relaystate ?? "");

            if (authMethod.Type == AuthMethodType.FormPost)
            {

                var form = new LoginModel()
                {
                    Destination = authMethod.Url,
                    Parameters = authMethod.Parameters
                };

                return View(form);

            }
            if (Url.IsLocalUrl(authMethod.Url))
            {
                Redirect(authMethod.Url);
            }
            return new RedirectResult("noLocalUrl");
        }

        // ReSharper disable once InconsistentNaming - Naming taken from format used by DIGID API
        public async Task<ActionResult> VerifyToken([FromUri(Name = "SAMLart")]string SAMLart = null, [FromUri(Name = "RelayState")]string RelayState = null)
        {
            var container = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext
            {
                ApplicationId = Settings.Default.ApplicationId,
                EnvironmentId = Settings.Default.EnvironmentId
            };


            var proxy = container.ProxyFactory.CreateProxy<Manager.Authentication.Interface.IAuthenticationManager>(context);

            var response = await proxy.ExchangeTokenAsync(SAMLart, RelayState);


            if (response.Status == Manager.Authentication.Contract.StatusCode.CancelledByUser  || 
                response.Status == Manager.Authentication.Contract.StatusCode.ServiceFailure ||
                response.Status == Manager.Authentication.Contract.StatusCode.UnknownDossier )
            {
                //Goto login page
                var statusMessage = response.Status.ToString();
                return new RedirectResult($"/?statuscode={HttpUtility.UrlEncode(statusMessage)}#login");              
            }


            if (response.Status != Manager.Authentication.Contract.StatusCode.Success)
            {
                return new RedirectResult($"/#login");               
            }
            else
            {
                var claims = response?.Claims;
                var bsnClaim = claims?.SingleOrDefault(c => c.Type == "digid.nl/bsn");
                var dossierClaim = claims?.SingleOrDefault(c => c.Type == "pensioenfondshakoningdhv.nl/dossiernummer");
                var csrfClaim = claims?.SingleOrDefault(c => c.Type == "CSRF");

                using (var provider1 = new System.Security.Cryptography.SHA512Managed())
                {
                    (context as ISessionMarkerContext).Marker = Convert.ToBase64String(provider1.ComputeHash(System.Text.Encoding.UTF8.GetBytes(dossierClaim.Value)));
                }

                var sessionProxy = container.ProxyFactory.CreateProxy<ISessionManager>(context);
                sessionProxy.StartSession();

                Response.Cookies.Add(CreateAuthenticationCookie(bsnClaim?.Value, dossierClaim?.Value, csrfClaim?.Value, false));
                Response.Cookies.Add(CreateCookie("CSRF_COOKIE", csrfClaim?.Value));
                Response.Cookies.Add(CreateCookie("KP_CSRF_CLIENT", csrfClaim?.Value, false));
                return new RedirectResult("/#start");
            }
        }


        public ActionResult LogOff()
        {

            var context = new KlantPortaalContext
            {
                ApplicationId = Settings.Default.ApplicationId,
                EnvironmentId = Settings.Default.EnvironmentId,
                Ip = this.Request.UserHostAddress
            };



            var authContainer = new AuthenticationFactoryContainer<KlantPortaalContext>();
            (context as IAuthenticationTicket).AuthenticationTicket = GetCookie(this.Request, FormsAuthentication.FormsCookieName);
            var p = authContainer.ProxyFactory.CreateProxy<IAuthenticationManager>(context);
            if (p.AuthenticateUser())
            {
                var factoryContainer = new KlantPortaalFactoryContainer();
                var manager = factoryContainer.ProxyFactory.CreateProxy<ISessionManager>(context);
                manager.EndSession();
            }

            //cookie verwijderen
            FormsAuthentication.SignOut();

            return new RedirectResult("/#login");
        }

        private static HttpCookie CreateAuthenticationCookie(string bsnOrUserName, string dossiernr, string csfr, bool impersonate)
        {
            var cookieIssuedDate = DateTime.Now;

            string userData;
            if (impersonate)
            {
                userData = string.Format("{0}|{1}|{2}|{3}", bsnOrUserName, dossiernr, csfr, "impersonate");
            }
            else
            {
                userData = string.Format("{0}|{1}|{2}", bsnOrUserName, dossiernr, csfr);
            }


            var ticket = new FormsAuthenticationTicket(0,
                userData,
                cookieIssuedDate,
                cookieIssuedDate.AddMinutes(FormsAuthentication.Timeout.TotalMinutes),
                false,
                userData,
                FormsAuthentication.FormsCookiePath);

            return CreateCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket));
        }

        private static HttpCookie CreateCookie(string name, string value, bool httpOnly = true)
        {
            return new HttpCookie(name, value)
            {
                Domain = FormsAuthentication.CookieDomain,
                Path = FormsAuthentication.FormsCookiePath,
                HttpOnly = httpOnly,
                Secure = FormsAuthentication.RequireSSL
            };
        }

        private static string GetCookie(HttpRequestBase request, string key)
        {

            var authCookie = request.Cookies[key];
            if (authCookie == null)
                return null;

            return authCookie.Value;
        }

    }

    public static class KnownCookieName
    {
        public const string KlantPortaalCsrf = "CSRF_COOKIE";
    }
}