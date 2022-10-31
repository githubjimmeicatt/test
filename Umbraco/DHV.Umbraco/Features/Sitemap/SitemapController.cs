using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Umbraco.Sitemap;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Wsg.CorporateUmbraco.Features.Sitemap
{
    public class SitemapController : Controller
    {
        private const string SitemapUrl = "sitemap.xml";

        private readonly ISitemapManager _manager;

        public SitemapController(ISitemapManager manager)
        {
            _manager = manager;
        }

        [HttpGet(SitemapUrl)]
        public async Task Sitemap(CancellationToken token)
        {
            var baseUri = GetBaseUri();

            Response.ContentType = "text/xml";
            Response.StatusCode = 200;
            await _manager.WriteSiteMapAsync(baseUri, Response.WriteAsync, token);
        }

        [HttpGet("robots.txt")]
        public IActionResult Robots()
        {
            var uri = new Uri(GetBaseUri(), SitemapUrl);
            return Content($"User-agent: *\nSitemap: {uri}", "text/plain");
        }

        private Uri GetBaseUri() => new($"{Request.Scheme}://{Request.Host}{Request.PathBase}");
    }
}
