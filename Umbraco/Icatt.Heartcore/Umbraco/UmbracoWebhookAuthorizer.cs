using System;
using System.Linq;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Http;

namespace Icatt.Heartcore.Umbraco
{
    public interface IUmbracoWebhookAuthorizer
    {
        bool IsAuthorized();
    }

    public class UmbracoWebhookAuthorizer : IUmbracoWebhookAuthorizer
    {
        private readonly UmbracoHeartcoreConfig _umbracoHeartcoreConfig;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UmbracoWebhookAuthorizer(UmbracoHeartcoreConfig umbracoHeartcoreConfig, IHttpContextAccessor httpContextAccessor)
        {
            _umbracoHeartcoreConfig = umbracoHeartcoreConfig;
            _httpContextAccessor = httpContextAccessor;
        }

        public bool IsAuthorized() => _umbracoHeartcoreConfig.IpWhitelist.Contains(GetIp());

        private string GetIp() => _httpContextAccessor.HttpContext.Request.Headers.TryGetValue("X-Forwarded-For", out var forwardedIp)
            ? forwardedIp
            : _httpContextAccessor.HttpContext.Connection.RemoteIpAddress?.MapToIPv4()?.ToString();
    }
}
