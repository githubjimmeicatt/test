using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Security;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection.WebApi;
using Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi;
using System;
using Sphdhv.Klantportaal.Manager.Deelnemer.Interface;



namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class DeelnemerController : ApiController
    {

        [HttpGet]
        [CsrfProtected]
        [AuthenticationExceptionFilter]
        [GeneralExceptionFilter]
        public ResponseModel<bool> VraagAanvulling()
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            (context as IAuthenticationTicket).AuthenticationTicket = GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            var proxy = factoryContainer.ProxyFactory.CreateProxy<IDeelnemerManager>(context);
            
            return new ResponseModel<bool>(proxy.VraagAanvulling());
        }


        [HttpGet]
        [CsrfProtected]
        [AuthenticationExceptionFilter]
        [GeneralExceptionFilter]
        public ResponseModel<bool> VerifyEmail(Guid guid)
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();
            
            (context as IAuthenticationTicket).AuthenticationTicket = GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            var proxy = factoryContainer.ProxyFactory.CreateProxy<IDeelnemerManager>(context);
            return new ResponseModel<bool>(proxy.VerifyEmail(guid));
        }


        [HttpGet]
        [CsrfProtected]
        [AuthenticationExceptionFilter]
        [GeneralExceptionFilter]
        public ResponseModel<bool> OpslaanAanvulling(string email)
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext(RequestContext.Url.Request.RequestUri);

            (context as IAuthenticationTicket).AuthenticationTicket = GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            var proxy = factoryContainer.ProxyFactory.CreateProxy<IDeelnemerManager>(context);

            proxy.OpslaanAanvulling(email);

            return new ResponseModel<bool>(true);
        }


       

        private static string GetCookie(HttpRequestMessage request, string key)
        {

            var authCookie = request.Headers.GetCookies(key).FirstOrDefault();
            if (authCookie == null)
                return null;

            return authCookie[key].Value;
        }


    }
}
