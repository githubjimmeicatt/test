using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Json;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Umbraco.Shared;

namespace Icatt.Heartcore.Umbraco.Menu
{
    public interface IFooterManager
    {
        Task<IReadOnlyList<FooterItem>> GetFooterAsync(string portalId, int menuDepth, CancellationToken token);
    }

    internal class FooterManager : IFooterManager
    {
        private readonly HttpClient _httpClient;

        public FooterManager(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<IReadOnlyList<FooterItem>> GetFooterAsync(string portalId, int menuDepth, CancellationToken token)
        {
            var query = @$"{{
  content(id: ""{portalId}"") {{{BuildChildrenQuery(menuDepth)}}}
}}";
            var graphQlQueryRequest = new GraphQlQueryRequest(query);

            var response = await _httpClient.PostAsJsonAsync("", graphQlQueryRequest, token);
            using var stream = await response.Content.ReadAsStreamAsync(token);
            using var doc = await JsonDocument.ParseAsync(stream, cancellationToken: token);

            if (doc.RootElement.TryGetProperty("data", out var data)
                && data.TryGetProperty("content", out var content)
                && content.TryGetProperty("children", out var children)
                && children.TryGetProperty("items", out var items)
                && items.ValueKind == JsonValueKind.Array
                )
            {
                return items.EnumerateArray().Select(Map).Where(x=> x != null).ToList();
            }

            return Array.Empty<FooterItem>();
        }



        private static string BuildChildrenQuery(int max, int current = 1)
        {
            var inner = current >= max ? "" : BuildChildrenQuery(max, current + 1);
            return $@"children {{
      items {{
        id
        name
        url
        ... on ShowInMenu {{
          excludeFromFooter
        }}
        {inner}
      }}
    }}";
        }

        private static FooterItem Map(JsonElement jsonElement)
        {
            var excludeFromFooter = jsonElement.TryGetProperty("excludeFromFooter", out var excludeFromFooterProp) && excludeFromFooterProp.ValueKind == JsonValueKind.True;
            if (excludeFromFooter)
            {
                return null;
            }
            var id = jsonElement.GetProperty("id").GetGuid();
            var title = jsonElement.GetProperty("name").GetString();
            var href = jsonElement.GetProperty("url").GetString();
            var showInMenu = jsonElement.TryGetProperty("showInMenu", out var showInMenuProp) && showInMenuProp.ValueKind == JsonValueKind.True;

            var children = jsonElement.TryGetProperty("children", out var childProp)
                && childProp.TryGetProperty("items", out var itemsProp)
                && itemsProp.ValueKind == JsonValueKind.Array
                  ? itemsProp.EnumerateArray().Select(Map).ToArray()
                  : Array.Empty<FooterItem>();

            return new FooterItem(id, href, title, children);
        }
    }
}
