using System.Threading.Tasks;
using Icatt.Heartcore.Umbraco;
using Microsoft.AspNetCore.Mvc;

namespace DHV.Umbraco.Features.Search
{
    [ApiController]
    [Route("content/search")]
    public class SearchController : ControllerBase
    {
        private readonly IPortalSearchManager _portalSearchManager;

        public SearchController(IPortalSearchManager portalSearchManager)
        {
            _portalSearchManager = portalSearchManager;
        }

        [HttpGet]
        public async Task<IActionResult> SearchAsync([FromQuery] SearchQuery searchQuery)
        {
            var result = await _portalSearchManager.SearchAsync(searchQuery);
            return Ok(result);
        }
    }
}
