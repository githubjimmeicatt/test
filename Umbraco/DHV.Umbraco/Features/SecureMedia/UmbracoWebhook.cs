using System.Threading.Tasks;
using Icatt.Heartcore.Umbraco;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace DHV.Umbraco.Features.SecureMedia
{
    [Route("api/[controller]")]
    [AllowAnonymous]
    [ApiController]
    public class UmbracoWebhookController : ControllerBase
    {
        private readonly ILogger<UmbracoWebhookController> _log;
        private readonly IHeartcoreMediaManager _mediaManager;
        private readonly IUmbracoWebhookAuthorizer _authorizer;

        public UmbracoWebhookController(ILogger<UmbracoWebhookController> log, IHeartcoreMediaManager mediaManager, IUmbracoWebhookAuthorizer authorizer)
        {
            _log = log;
            _mediaManager = mediaManager;
            _authorizer = authorizer;
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Post(UmbracoMedia model)
        {
            _log.LogInformation("Incoming webhook request for creating {@Model}", model);

            if (!_authorizer.IsAuthorized())
            {
                return Unauthorized();
            }

            var result = await _mediaManager.SaveMedia(model);
            return Ok(result);
        }

        [HttpPost("delete")]
        [AllowAnonymous]
        public async Task<IActionResult> Delete(UmbracoMedia model)
        {
            _log.LogInformation("Incoming webhook request for deleting {@Model}", model);

            if (!_authorizer.IsAuthorized())
            {
                return Unauthorized();
            }

            var result = await _mediaManager.DeleteMedia(model);
            return Ok(result);
        }
    }
}
