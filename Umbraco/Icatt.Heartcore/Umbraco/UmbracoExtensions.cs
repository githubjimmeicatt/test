using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Rewrite;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Umbraco.Headless.Client.Net.Management;

namespace Icatt.Heartcore.Umbraco
{
    public static class UmbracoExtensions
    {
        public static IApplicationBuilder UseUmbraco404Detection(this IApplicationBuilder app)
        {
            var log = app.ApplicationServices.GetRequiredService<ILoggerFactory>().CreateLogger(nameof(UmbracoExtensions));
            app.Use(async (HttpContext context, RequestDelegate next) =>
            {
                await next(context);
                if (context.Response.StatusCode == 404)
                {
                    if (context.Request.Path.StartsWithSegments("/umbracomedia", StringComparison.OrdinalIgnoreCase))
                    {
                        log.LogCritical("Protected media {path} not found", context.Request.Path);
                    }
                    var urlParameter = context.Request.Query["url"];
                    if (!urlParameter.Any())
                    {
                        return;
                    }
                    _ = Check404(context, urlParameter.First(), log);
                    return;
                }
            });
            return app;
        }

        public static IApplicationBuilder UseUmbracoPortalRedirectToWwwPermanent(this IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.Use(async (HttpContext context, RequestDelegate next) =>
            {
                await next(context);
                if (env.IsProduction())
                {
                    var portals = context.RequestServices.GetRequiredService<IPortalConfig>();
                    var wwwDomains = portals.GetPortals().Where(x => x.HostName.Contains("www")).Select(x => x.HostName.Replace("www.", "")).ToArray();
                    if (wwwDomains != null && wwwDomains.Any())
                    {
                        var options = new RewriteOptions()
                            .AddRedirectToWwwPermanent(wwwDomains);
                        app.UseRewriter(options);
                    }
                }
            });
            return app;
        }

        private static async Task Check404(HttpContext context, string urlParameter, ILogger log)
        {
            var service = context.RequestServices.GetRequiredService<IContentManagementService>();
            var portals = context.RequestServices.GetRequiredService<IPortalConfig>();
            var cache = context.RequestServices.GetRequiredService<IMemoryCache>();
            var env = context.RequestServices.GetRequiredService<IWebHostEnvironment>();

            var portal = new Portal();
            portals.TryGetPortal(out portal);
            var path = urlParameter.TrimStart('/').TrimEnd('/').Split('/').ToList();

            if (env != null && env.IsDevelopment())
            {
                path.RemoveAt(0);
            }
            var pageName = path.Aggregate((concat, str) => $"{concat}/{str}");

            var portalCacheKey = $"PortalPages_{portal.UmbracoId}";

            if (!cache.TryGetValue(portalCacheKey, out List<string> pages))
            {
                pages = await GetAllPagesByHomepageId(Guid.Parse(portal.UmbracoId), service);
                pages.Add("404-test"); //voor testbaarheid op accept/productie
                var cacheEntryOptions = new MemoryCacheEntryOptions()
                //https://docs.microsoft.com/en-us/aspnet/core/performance/caching/memory?view=aspnetcore-5.0#use-setsize-size-and-sizelimit-to-limit-cache-size
                .SetSlidingExpiration(TimeSpan.FromMinutes(15));
                cache.Set(portalCacheKey, pages, cacheEntryOptions);
            }

            if (pages.Any(x => x == pageName))
            {
                log.LogCritical("Heartcore unlinked 404 {unlink} detected for {@portal} in {@cachedPages}", urlParameter, portal, pages);
            }
        }

        private static async Task<List<string>> GetAllPagesByHomepageId(Guid rootId, IContentManagementService contentManagement)
        {
            var list = new List<string>();
            var pages = await contentManagement.Content.GetChildren(rootId);
            static string ToKebabNotation(string x) =>
                x.ToLower()
                 .Replace("”", "")
                 .Replace("\"", "")
                 .Replace("'", "")
                 .Replace("‘", "")
                 .Replace(",", "")
                 .Replace(".", "")
                 .Replace("&", "")
                 .Replace("?", "")
                 .Replace("’", "-")
                 .Replace(":", "-")
                 .Replace(" ", "-")
                 .Replace("--", "-")
                 .Replace("--", "-"); //umbraco gebruikt kebab notatie voor page-links

            foreach (var content in pages.Content.Items.Where(x => x?.Name?.Count > 0))
            {
                var pageNames = content.Name.Select(x => ToKebabNotation(x.Value)).ToList();
                list.AddRange(pageNames);

                if (content.HasChildren)
                {
                    var recursiveResult = await GetAllPagesByHomepageId(content.Id, contentManagement);
                    foreach (var pageName in recursiveResult)
                    {
                        list.Add($"{ToKebabNotation(content.Name.First().Value)}/{pageName}"); //concatenate child pages
                    }
                }
            }
            return list;
        }
    }
}
