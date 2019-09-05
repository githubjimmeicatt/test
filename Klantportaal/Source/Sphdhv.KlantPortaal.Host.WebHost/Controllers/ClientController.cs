using Sphdhv.KlantPortaal.Host.WebHost.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Script.Serialization;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class ClientController : ApiController
    {
        // GET: Client
        [HttpGet]
        public string Controller(string id)
        {
            var mappedPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
            return System.IO.File.ReadAllText($@"{mappedPath}\StaticFiles\Client\Controller\{id}.js");
        }

        // GET: Client
        [HttpGet]
        public string View(string id)
        {
            var mappedPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
            return System.IO.File.ReadAllText($@"{mappedPath}\StaticFiles\Client\View\{id}view.html");
        }
    }
}