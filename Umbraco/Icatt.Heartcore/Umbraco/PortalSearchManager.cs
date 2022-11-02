using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Umbraco.Headless.Client.Net.Delivery;
using Umbraco.Headless.Client.Net.Delivery.Models;

namespace Icatt.Heartcore.Umbraco
{
    public interface IPortalSearchManager
    {
        Task<PagedContent> SearchAsync(SearchQuery searchQuery);
    }

    public class PortalSearchManager : IPortalSearchManager
    {
        private readonly IContentDeliveryService _contentDelivery;

        private readonly IWebHostEnvironment _env;
        private readonly IPortalConfig _portalConfig;

        public PortalSearchManager(IContentDeliveryService contentDelivery, IPortalConfig portalConfig, IWebHostEnvironment env)
        {
            _contentDelivery = contentDelivery;
            _portalConfig = portalConfig;
            _env = env;
        }

        public async Task<PagedContent> SearchAsync(SearchQuery searchQuery)
        {
            var rootUrls = _portalConfig.GetRootUrls();

            var result = await _contentDelivery.Content.Search(searchQuery.Term, null, searchQuery.Page, searchQuery.PageSize);
            if (result?.Content?.Items != null && !_env.IsDevelopment()) //op dev alle resultaten omdat url altijd localhost is en er geen zoekpagina per portal is
            {
                result.Content.Items = result.Content.Items.Where(x => rootUrls.Any(r => x.Url.StartsWith(r))).ToList();
            }

            return result;
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
