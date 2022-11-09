using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;

namespace DHV.Umbraco.Features.Renderer
{
    [Route("")]
    public class RendererController : Controller
    {
        private readonly GetAssets _getAssets;
        private readonly IUmbracoClient _umbracoClient;
        private readonly IWebHostEnvironment _env;

        public RendererController(GetAssets getAssets, IUmbracoClient umbracoClient, IWebHostEnvironment env)
        {
            _getAssets = getAssets;
            _umbracoClient = umbracoClient;
            _env = env;
        }

        [HttpGet]
        public async Task<ActionResult> Index(CancellationToken token)
        {
            var baseUri = $"{Request.Scheme}://{Request.Host}{Request.PathBase}";
            var head = await _umbracoClient.GetHeadAsync(baseUri, Request.Path, token);

            if (head == null)
            {
                Response.StatusCode = StatusCodes.Status404NotFound;
                head = _umbracoClient.GetHead404();
            }

            if (!string.IsNullOrWhiteSpace(head.Redirect))
            {
                return Redirect(head.Redirect);
            }

            var assets = await _getAssets.Get(token);

            return View("/Features/Renderer/View.cshtml", new PageResponse
            {
                Assets = assets,
                Head = head
            });
        }
    }

    public class PageResponse
    {
        public IReadOnlyCollection<IAsset> Assets { get; set; }
        public Head Head { get; internal set; }
    }
}
