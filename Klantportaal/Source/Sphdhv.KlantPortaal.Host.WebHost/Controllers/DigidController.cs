using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class DigidController : Controller
    {
        // GET: Digid
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage Login(string relaystate)
        {
            var loginform = "";
            using (var webClient = new WebClient())
            {
                var url = $"/authentication/login?relaystate={HttpUtility.UrlEncode(relaystate)}";
                loginform = webClient.DownloadString(url);
            }
            return null;
        }
    }
}