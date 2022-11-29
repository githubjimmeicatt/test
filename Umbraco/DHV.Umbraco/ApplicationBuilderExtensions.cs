using System.Collections.Generic;
using System.Linq;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Rewrite;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace DHV.Umbraco
{
    public static class ApplicationBuilderExtensions
    {
        public static IApplicationBuilder UseIcattSecurity(this IApplicationBuilder app, IWebHostEnvironment env)
        {
            var portalConfig = app.ApplicationServices.GetRequiredService<IPortalConfig>();

            app.UseXXssProtection(options => options.EnabledWithBlockMode());
            app.UseXfo(options => options.SameOrigin());

            var connectSources = new List<string>
            {
                "https://cdn.umbraco.io",
                "www.google-analytics.com",
                "region1.google-analytics.com",
            };


            if (env.IsDevelopment())
            {
                connectSources.Add("ws:");
            }

            app.UseCsp(opts =>
            {
                if (!env.IsDevelopment())
                {
                    opts.UpgradeInsecureRequests();
                }

                opts
                    .DefaultSources(s => s.None())
                    .ConnectSources(s => s.Self().CustomSources(connectSources.ToArray()))
                    .StyleSources(s => s.Self().UnsafeInline())
                    .FontSources(s => s.Self().CustomSources("https://fonts.gstatic.com/"))
                    .ImageSources(s => s.Self().CustomSources(
                        "https://media.umbraco.io",
                        "www.google-analytics.com"
                    ))
                    .MediaSources(s => s.Self())
                    .ScriptSources(s => s.Self().StrictDynamic())
                    .FormActions(s => s.Self())
                    .FrameAncestors(s => s.Self())
                    .FrameSources(s=> s.Self().CustomSources("https://www.youtube.com", "https://www.youtube-nocookie.com"))
                    .ObjectSources(s => s.None())
                    .BaseUris(s => s.None())
                    .ReportUris(s =>
                    {
                        if (env.IsDevelopment())
                        {
                            s.Uris("https://icatt.report-uri.com/r/d/csp/enforce");
                        }
                    });
            });
            app.UseXContentTypeOptions();
            app.UseReferrerPolicy(opts => opts.NoReferrerWhenDowngrade());

            app.UseStatusCodePages(async context =>
            {
                context.HttpContext.Response.ContentType = "text/plain";

                await context.HttpContext.Response.WriteAsync(
                    "Status code page, status code: " +
                    context.HttpContext.Response.StatusCode);

            });
            if (env.IsStaging())
            {
                app.UseHsts(options => options.MaxAge(7 * 26).IncludeSubdomains().Preload());
            }
            if (env.IsProduction())
            {
                app.UseHsts(options => options.MaxAge(7 * 26).IncludeSubdomains().Preload());
                var wwwDomains = portalConfig.GetPortals().Where(x => x.HostName.Contains("www")).Select(x => x.HostName.Replace("www.", "")).ToArray();
                if (wwwDomains != null && wwwDomains.Any())
                {
                    var options = new RewriteOptions()
                        .AddRedirectToWwwPermanent(wwwDomains);
                    app.UseRewriter(options);
                }
            }

            return app;
        }
    }

}
