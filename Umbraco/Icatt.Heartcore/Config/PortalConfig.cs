using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;

namespace Icatt.Heartcore.Config
{
    public class PortalConfig : IPortalConfig
    {
        private readonly Dictionary<string, Portal> _config = new();
        private readonly IHttpContextAccessor _httpContextAccessor;

        public PortalConfig(IConfiguration config, IHttpContextAccessor httpContextAccessor)
        {
            config.GetSection("Portals").Bind(_config);
            _httpContextAccessor = httpContextAccessor;
        }

        public IReadOnlyCollection<string> GetRootUrls() => GetPortalsForHost().Select(x => "/" + x.Key).ToList();

        public bool LoginIsRequired() => GetPortalsForHost().Any(x => x.Value.SSO);

        public List<Portal> GetPortals()
        {
            return _config.Select(x=>x.Value).ToList();
        }

        public bool TryGetPortal(out Portal portal)
        {
            portal = null;

            var portals = GetPortalsForHost().ToList();

            if (!portals.Any())
            {
                return false;
            }

            if (TryGetPortalFromPrefix(portals, out portal))
            {
                return true;
            }

            var keyValue = portals.First();
            keyValue.Value.Prefix = !string.IsNullOrWhiteSpace(keyValue.Key)
                ? "/" + keyValue.Key.TrimStart('/')
                : string.Empty;
            portal = keyValue.Value;
            return true;
        }

        public List<Guid> ProtectedMediaFolderIds() => _config
                .Select(x => x.Value)
                .Where(x => x.ProtectedMediaRootFolderId.HasValue)
                .Select(x => x.ProtectedMediaRootFolderId.Value)
                .ToList();

        private IEnumerable<KeyValuePair<string, Portal>> GetPortalsForHost()
        {
            var host = _httpContextAccessor.HttpContext.Request.Host.Host;
            return _config.Where(x => x.Value.HostName.Equals(host, StringComparison.OrdinalIgnoreCase));
        }

        private bool TryGetPortalFromPrefix(IReadOnlyCollection<KeyValuePair<string, Portal>> portals, out Portal portal)
        {
            portal = null;

            var request = _httpContextAccessor?.HttpContext?.Request;

            if (request == null)
            {
                return false;
            }

            string url = request.Query.TryGetValue("url", out var urlQuery) && !string.IsNullOrWhiteSpace(urlQuery)
                ? urlQuery
                : request.Path;

            var firstPartOfUrl = url.TrimStart('/').Split('/').FirstOrDefault();

            if (string.IsNullOrWhiteSpace(firstPartOfUrl))
            {
                return false;
            }

            var matchOnPrefix = portals.Where(p => firstPartOfUrl.Equals(p.Key.TrimStart('/').TrimEnd('/'), StringComparison.OrdinalIgnoreCase)).Select(x => x.Value).FirstOrDefault();

            if (matchOnPrefix == null)
            {
                return false;
            }

            matchOnPrefix.Prefix = string.Empty;
            portal = matchOnPrefix;
            return true;
        }

        public string GetRealm() => GetPortalsForHost().Where(x => !string.IsNullOrWhiteSpace(x.Value.Wtrealm)).Select(x=> x.Value.Wtrealm).FirstOrDefault();
    }

    public class Portal
    {
        public string Prefix { get; set; }
        public string HostName { get; set; }
        public string UmbracoId { get; set; }
        public string Theme { get; set; }
        public string Layout { get; set; }
        public string Logo { get; set; }
        public string GtmId { get; set; }
        public string FooterName { get; set; }
        public bool IsSecure { get; set; }
        public bool SSO { get; set; }
        public Guid? ProtectedMediaRootFolderId { get; set; }
        public string Wtrealm { get; set; }

        public string RemovePrefix(string url)
        {
            if (string.IsNullOrWhiteSpace(url) || string.IsNullOrWhiteSpace(Prefix)) return url;
            var trimmedPrefix = Prefix.AsSpan().Trim('/');
            var trimmedUrl = url.AsSpan().Trim('/');
            var i = trimmedUrl.IndexOf(trimmedPrefix);
            
            // er is geen match, of deze is niet precies vanaf het begin
            if (i != 0) return $"/{trimmedUrl}";

            // url is precies hetzelfde als de prefix, dus het gaat om de root van de portal
            if (trimmedPrefix.Length == trimmedUrl.Length) return "/";

            // url begint met de prefix, maar bevat daarna andere karakters ipv /. Raar maar theoretisch mogelijk. de prefix in dit geval niet weglaten
            if (trimmedUrl[trimmedPrefix.Length] != '/') return $"/{trimmedUrl}";

            return trimmedUrl[trimmedPrefix.Length..].ToString();

        }
    }
}
