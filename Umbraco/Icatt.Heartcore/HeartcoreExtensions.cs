using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Icatt.Heartcore.Umbraco;
using Icatt.Heartcore.Umbraco.LikesComments;
using Icatt.Heartcore.Umbraco.Menu;
using Icatt.Heartcore.Umbraco.Sitemap;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Umbraco.Headless.Client.Net.Delivery;
using Umbraco.Headless.Client.Net.Management;
using Yarp.ReverseProxy.Transforms;
using Yarp.ReverseProxy.Transforms.Builder;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class HeartcoreExtensions
    {
        public static IApplicationBuilder UseSecureStaticFiles(this IApplicationBuilder app, IWebHostEnvironment environment, string requestPath = "/umbracomedia")
        {
            app.UseStaticFiles(new StaticFileOptions
            {
                OnPrepareResponse = ctx =>
                {
                    ctx.Context.Response.Headers.Add("Cache-Control", "no-store");

                    if (!ctx.Context.User.Identity.IsAuthenticated)
                    {
                        ctx.Context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                        ctx.Context.Response.ContentLength = 0;
                        ctx.Context.Response.Body = Stream.Null;
                    }
                },
                FileProvider = app.ApplicationServices.GetRequiredService<IUmbracoSecureFileProvider>(),
                RequestPath = requestPath
            });
            return app;
        }

        public static TransformBuilderContext AddUmbracoProxies(this TransformBuilderContext b, string umbracoContentClusterName = "UmbracoContent")
        {
            var portalConfig = b.Services.GetRequiredService<IPortalConfig>();
            var heartcoreConfig = b.Services.GetRequiredService<UmbracoHeartcoreConfig>();
            var environment = b.Services.GetRequiredService<IWebHostEnvironment>();

            b.AddRequestTransform(transformContext =>
            {
                transformContext.ProxyRequest.Headers.Add("Api-Key", heartcoreConfig.ApiKey);
                transformContext.ProxyRequest.Headers.Add("Umb-Project-Alias", heartcoreConfig.UmbProjectAlias);

                if (environment.IsStaging()) //do not use helicon ape authorization header on reverse proxy requests
                {
                    transformContext.ProxyRequest.Headers.Authorization = null;
                }
                return new ValueTask();
            });

            if (b.Cluster.ClusterId.Equals(umbracoContentClusterName, StringComparison.OrdinalIgnoreCase))
            {
                b.AddRequestTransform(transformContext =>
                {
                    if (transformContext.Query.Collection.TryGetValue("url", out var urlQuery))
                    {
                        var url = urlQuery[0].TrimEnd('/');
                        if (portalConfig.TryGetPortal(out var portal) && !string.IsNullOrWhiteSpace(portal.Prefix))
                        {
                            url = portal.Prefix + url;
                        }
                        transformContext.Query.Collection["url"] = url;
                    }
                    return new ValueTask();
                });
            }
            return b;
        }

        public static IServiceCollection AddHeartcore(this IServiceCollection services, IConfiguration configuration, string heartcoreConfigSection = "UmbracoHeartcoreConfig")
        {
            var heartcoreConfig = new UmbracoHeartcoreConfig();
            configuration
                .GetSection(heartcoreConfigSection)
                .Bind(heartcoreConfig);

            heartcoreConfig.BackofficeUrl ??= $"https://{heartcoreConfig.UmbProjectAlias}.euwest01.umbraco.io";

            services.AddSingleton(heartcoreConfig);

            services.AddMemoryCache();

            services.AddScoped<IContentDeliveryService>((serviceProvider) => new ContentDeliveryService(heartcoreConfig.UmbProjectAlias, heartcoreConfig.ApiKey));
            services.AddScoped<IContentManagementService>((serviceProvider) => new ContentManagementService(heartcoreConfig.UmbProjectAlias, heartcoreConfig.ApiKey));
            services.AddScoped<IHeartcoreMediaManager, HeartcoreMediaManager>();
            services.AddScoped<ILikesCommentsManager, LikesCommentsManager>();
            services.AddScoped<IUmbracoWebhookAuthorizer, UmbracoWebhookAuthorizer>();

            services.AddHttpClient<IPortalSearchManager, PortalSearchManager>(nameof(PortalSearchManager), (c) =>
            {
                SetupHeaders(c, heartcoreConfig);
                c.BaseAddress = new Uri(heartcoreConfig.BackofficeUrl);
            });

            services.AddHttpClient<IMenuManager, MenuManager>(nameof(MenuManager), SetupGraphQl).LogAndAbsorbTimeout();
            services.AddHttpClient<IFooterManager, FooterManager>(nameof(FooterManager), SetupGraphQl).LogAndAbsorbTimeout();
            services.AddHttpClient<ISitemapManager, SitemapManager>(nameof(SitemapManager), SetupGraphQl).LogAndAbsorbTimeout();

            services.AddSingleton<IUmbracoSecureFileProvider, UmbracoSecureFileProvider>();

            return services;
        }

        private static void SetupHeaders(HttpClient c, UmbracoHeartcoreConfig heartcoreConfig)
        {
            c.DefaultRequestHeaders.Add("Accept-Language", "en-US");
            c.DefaultRequestHeaders.Add("Umb-Project-Alias", heartcoreConfig.UmbProjectAlias);
            c.DefaultRequestHeaders.Add("Api-Key", heartcoreConfig.ApiKey);
        }

        private static void SetupGraphQl(IServiceProvider s, HttpClient c)
        {
            var heartcoreConfig = s.GetRequiredService<UmbracoHeartcoreConfig>();
            SetupHeaders(c, heartcoreConfig);
            c.BaseAddress = new Uri("https://graphql.umbraco.io");
        }
    }
}
