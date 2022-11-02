using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Json;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using System.Xml;
using Icatt.Heartcore.Config;

namespace Icatt.Heartcore.Umbraco.Sitemap
{ 
    public delegate Task WriteAsync(string text, CancellationToken token);

    public interface ISitemapManager
    {
        Task WriteSiteMapAsync(Uri baseUri, WriteAsync writer, CancellationToken token);
    }

    internal class SitemapManager : ISitemapManager
    {
        private const string StartXml = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemalocation=\"http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\" xmlns:image=\"http://www.google.com/schemas/sitemap-image/1.1\">";
        private const string EndXml = "\n</urlset>";

        private readonly HttpClient _client;
        private readonly IPortalConfig _portalConfig;

        public SitemapManager(HttpClient client, IPortalConfig portalConfig)
        {
            _client = client;
            _portalConfig = portalConfig;
        }

        public async Task WriteSiteMapAsync(Uri baseUri, WriteAsync writeAsync, CancellationToken token)
        {
            if (!_portalConfig.TryGetPortal(out var portal))
            {
                return;
            }

            var request = new GraphQlQueryRequest(@$"{{content(id: ""{portal.UmbracoId}""){{
    url
    updateDate
    ... on ShowInMenu {{
              excludeFromSitemap
            }}
    descendants{{
      items {{
        url
        updateDate
        ... on ShowInMenu {{
          excludeFromSitemap
        }}
      }}
    }}
  }}
}}");
            var response = await _client.PostAsJsonAsync("", request, token);
            using var stream = await response.Content.ReadAsStreamAsync(token);
            using var doc = await JsonDocument.ParseAsync(stream, cancellationToken: token);

            if (!doc.RootElement.TryGetProperty("data", out var data) ||
                !data.TryGetProperty("content", out var content) ||
                content.ValueKind != JsonValueKind.Object)
            {
                return;
            }

            await writeAsync(StartXml, token);

            foreach (var item in Map(content, baseUri, portal))
            {
                await writeAsync($@"
  <url>
    <loc>{item.Url.ToString().TrimEnd('/')}</loc>
    <lastmod>{XmlConvert.ToString(item.LastModified)}</lastmod>
  </url>",
  token);
            }

            await writeAsync(EndXml, token);

        }

        private static IEnumerable<SitemapItem> Map(JsonElement jsonElement, Uri baseUri, Portal portal)
        {
            var shouldExclude = jsonElement.TryGetProperty("excludeFromSitemap", out var ex) && ex.ValueKind == JsonValueKind.True;

            if (!shouldExclude 
                && jsonElement.TryGetProperty("url", out var url)
                && url.ValueKind == JsonValueKind.String
                && jsonElement.TryGetProperty("updateDate", out var updateDate)
                && updateDate.TryGetDateTimeOffset(out var updateDateTime))
            {
                var unprefixed = portal.RemovePrefix(url.GetString());
                var fullUri = new Uri(baseUri, unprefixed);
                yield return new SitemapItem(fullUri, updateDateTime);
            }

            if (jsonElement.TryGetProperty("descendants", out var descendants)
                && descendants.TryGetProperty("items", out var items)
                && items.ValueKind == JsonValueKind.Array)
            {
                foreach (var item in items.EnumerateArray().SelectMany(x => Map(x, baseUri, portal)))
                {
                    yield return item;
                }
            }
        }
    }

    public record SitemapItem(Uri Url, DateTimeOffset LastModified);
}
