using DotNetNuke.Web.Api;
using Icatt.OAuth.Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace Sphdhv.DnnWebApi.Controllers
{
    public class DigidController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage Login(string relaystate)
        {
            var loginform = "";
            using (var webClient = new WebClient()) {
                var url = $"{Properties.Settings.Default.KlantPortaalEndpoint}authentication/login?relaystate={HttpUtility.UrlEncode(relaystate)}";
                loginform = webClient.DownloadString(url);
            }
            return this.ControllerContext.Request.CreateResponse<string>(loginform);
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage VerifyToken([FromUri(Name = "SAMLart")]string SAMLart = null, [FromUri(Name = "RelayState")]string RelayState = null) {
            HttpResponseMessage response;

            var url = $"{Properties.Settings.Default.KlantPortaalEndpoint}authentication/verifytoken?SAMLart={HttpUtility.UrlEncode(SAMLart)}&relaystate={HttpUtility.UrlEncode(RelayState)}";

            response = Request.CreateResponse(HttpStatusCode.Moved);
            response.Headers.Location = new Uri(url);

            return response;
        }
    }
}
