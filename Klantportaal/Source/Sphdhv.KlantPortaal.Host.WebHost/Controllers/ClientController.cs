using System;
using System.Web.Http;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class ClientController : ApiController
    {
        // GET: Client
        [HttpGet]
        public string Controller(string id)
        {
            if (id.Contains("~") || id.Contains("./"))
            {
                throw new UnauthorizedAccessException("Not allowed to traverse parents");
            }
            var mappedPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
            return System.IO.File.ReadAllText($@"{mappedPath}\StaticFiles\Client\Controller\{id}.js");
        }

        // GET: Client
        [HttpGet]
        public string View(string id)
        {
            if (id.Contains("~") || id.Contains("./"))
            {
                throw new UnauthorizedAccessException("Not allowed to traverse parents");
            }
            var mappedPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
#pragma warning disable SCS0018 // Path traversal: injection possible in {1} argument passed to '{0}'
            return System.IO.File.ReadAllText($@"{mappedPath}\StaticFiles\Client\View\{id}view.html");
#pragma warning restore SCS0018 // Path traversal: injection possible in {1} argument passed to '{0}'
        }
    }
}