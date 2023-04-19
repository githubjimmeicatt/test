using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.Extensions.Hosting;
using Umbraco.Headless.Client.Net.Delivery;
using Umbraco.Headless.Client.Net.Delivery.Models;

namespace Icatt.Heartcore.Umbraco
{
    public interface IPortalSearchManager
    {
        Task<PagedContent> SearchAsync(SearchQuery searchQuery, CancellationToken token = default);
    }

    public class PortalSearchManager : IPortalSearchManager
    {
        private readonly IContentDeliveryService _contentDelivery;

        private readonly IWebHostEnvironment _env;
        private readonly IPortalConfig _portalConfig;
        private readonly HttpClient _httpClient;

        public PortalSearchManager(IContentDeliveryService contentDelivery, IPortalConfig portalConfig, IWebHostEnvironment env, HttpClient httpClient)
        {
            _contentDelivery = contentDelivery;
            _portalConfig = portalConfig;
            _env = env;
            _httpClient = httpClient;
        }

        public async Task<PagedContent> SearchAsync(SearchQuery searchQuery, CancellationToken token = default)
        {
            var rootUrls = _portalConfig.GetRootUrls();
            var query = new QueryBuilder
            {
                { "pageIndex", (searchQuery.Page - 1).ToString() },
                { "query", searchQuery.Term },
                { "searcherName", "ExternalIndex" },
            };
            var url = $"/umbraco/backoffice/UmbracoApi/ExamineManagement/GetSearchResults?{query.ToQueryString()}";

            var searchResultString = await _httpClient.GetStringAsync(url, cancellationToken: token);

            // HACK!! Umbraco geeft als response twee regels tekst mee, waarvan de tweede valide json bevat en de eerste niet...
            var lastLine = searchResultString?.Split('\n')?.LastOrDefault();

            if (string.IsNullOrWhiteSpace(lastLine))
            {
                return new PagedContent();
            }

            using var searchResultJson = JsonDocument.Parse(lastLine);

            if (!searchResultJson.RootElement.TryGetProperty("totalRecords", out var totalRecordsProp) || !totalRecordsProp.TryGetInt32(out var totalRecords) || totalRecords < 1 ||
                !searchResultJson.RootElement.TryGetProperty("results", out var resultsProp) || resultsProp.ValueKind != JsonValueKind.Array
                )
            {
                return new PagedContent();
            }

            var ids = resultsProp.EnumerateArray().SelectMany(GetIds).ToList();

            if (!ids.Any())
            {
                return new PagedContent();
            }

            var tasks = ids.Select(x=> _contentDelivery.Content.GetById(x));
            var contentItems = await Task.WhenAll(tasks);

            var result = new PagedContent
            {
                Content = new ContentCollection<Content>
                {
                    Items = contentItems,
                },
                TotalItems = totalRecords,
                PageSize = searchQuery.PageSize,
                Page = searchQuery.Page,
                TotalPages = (int)Math.Floor((decimal)totalRecords / searchQuery.PageSize),
            };

            if (result?.Content?.Items != null && !_env.IsDevelopment()) //op dev alle resultaten omdat url altijd localhost is en er geen zoekpagina per portal is
            {
                result.Content.Items = result.Content.Items.Where(x => rootUrls.Any(r => x.Url.StartsWith(r))).ToList();
            }

            return result;
        }

        private static IEnumerable<Guid> GetIds(JsonElement element)
        {
            if (element.ValueKind != JsonValueKind.Object || 
                !element.TryGetProperty("values", out var valuesProp) || valuesProp.ValueKind != JsonValueKind.Object || 
                !valuesProp.TryGetProperty("__Key", out var keyProp) || keyProp.ValueKind != JsonValueKind.Array)
            {
                yield break;
            }

            foreach (var item in keyProp.EnumerateArray())
            {
                if (item.TryGetGuid(out var id))
                {
                    yield return id;
                }
            }
        }
    }

    public class SearchQuery
    {
        [Required]
        public string Term { get; set; }
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 10;
    }
}
