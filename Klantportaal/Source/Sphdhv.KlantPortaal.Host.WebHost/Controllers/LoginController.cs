using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.KlantPortaal.Host.WebHost.Models;
using Sphdhv.KlantPortaal.Host.WebHost.Properties;
using System.Web.Http;
using System.Web.Mvc;
using AllowAnonymousAttribute = System.Web.Mvc.AllowAnonymousAttribute;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class LoginController : Controller
    {
        // Post
        [AllowAnonymous]
        [System.Web.Http.HttpPost]
        public async System.Threading.Tasks.Task<ActionResult> Login(ImpersonateLoginModel loginModel)
        {
            var container = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext
            {
                ApplicationId = Settings.Default.ApplicationId,
                EnvironmentId = Settings.Default.EnvironmentId,
                DossierNummer = loginModel.DossierNr
            };

            var errorUrl = $"{Settings.Default.DnnMijnOmgevingUrl}{Settings.Default.DnnInloggenAlsPage}?loginalsinvalid=";

            var proxy = container.ProxyFactory.CreateProxy<IAspNetIdentityManager>(context);

            var loginResult  = await    proxy.Login(loginModel.Username, loginModel.Password);

            if(loginResult.Token == null)
            {
                return new RedirectResult(errorUrl +"usernamepassword");
            }

            if (!loginResult.DossierNrValid)
            {
                return new RedirectResult(errorUrl + "dossiernr");
            }

            var encodedToken = Server.UrlEncode(loginResult.Token.ToString());

            var redirectUrl = $"{Settings.Default.KlantPortaalBaseUrl}{ Settings.Default.VerifyTokenPath}?SAMLart={encodedToken}&RelayState={loginModel.DossierNr}|acceptImpersonate"; //serialized object in relaystate stoppen?
            if (Url.IsLocalUrl(redirectUrl))
            {
                return new RedirectResult(redirectUrl);
            }
            return new RedirectResult(errorUrl + "noLocalUrl");
        }



        [System.Web.Http.HttpPost]
        [AllowAnonymous]
        public ActionResult ResetPasswordToken(RequestPasswordResetTokenModel model)
        {
            var container = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext
            {
                ApplicationId = Settings.Default.ApplicationId,
                EnvironmentId = Settings.Default.EnvironmentId
            };

            var proxy = container.ProxyFactory.CreateProxy<IAspNetIdentityManager>(context);

            proxy.SendPasswordResetToken(model.User);

            return new RedirectResult($"{Settings.Default.DnnMijnOmgevingUrl}{Settings.Default.DnnPasswordResetConfirmationPage}");

        }


        [System.Web.Http.HttpGet]
        [AllowAnonymous]
        public ActionResult ResetPassword([FromUri(Name = "token")]string token = null, [FromUri(Name = "userid")]string userid = null, [FromUri(Name = "newpassword")]string newPassword = null, [FromUri(Name = "newpassword")]string newPasswordConfirm = null)
        {
            var container = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext
            {
                ApplicationId = Settings.Default.ApplicationId,
                EnvironmentId = Settings.Default.EnvironmentId
            };

            var proxy = container.ProxyFactory.CreateProxy<IAspNetIdentityManager>(context);

            var result = proxy.ResetPassword(new ResetPassword() { Token = token, UserId = userid, NewPassword = newPassword, NewPasswordConfirm = newPasswordConfirm });

            var resultParams = "";
            if (!result.Succes)
            {
                resultParams = "?passwordResetResult=" + string.Join(", ", result.Errors) + "&token=" + token + "&userid=" + userid;
            }
#pragma warning disable SCS0027 // Open redirect: possibly unvalidated input in {1} argument passed to '{0}' //False Positive
            return new RedirectResult($"{Settings.Default.DnnMijnOmgevingUrl}{Settings.Default.DnnInloggenAlsPage}{resultParams}");
#pragma warning restore SCS0027 // Open redirect: possibly unvalidated input in {1} argument passed to '{0}' //False Positive


        }



    }
}