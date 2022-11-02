using System;
using System.Net;
using System.Net.Mail;
using DHV.Umbraco.Features.Forms;
using Icatt.Heartcore.Config;
using Icatt.Heartcore.Umbraco;
using Icatt.Heartcore.Umbraco.Forms;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SpaServices.ReactDevelopmentServer;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Net.Http.Headers;
using Serilog;
using Wsg.CorporateUmbraco.Config;
using Wsg.CorporateUmbraco.Features.Forms;
using Wsg.CorporateUmbraco.Features.Renderer;

namespace Wsg.CorporateUmbraco
{
    public partial class Startup
    {
        private readonly IWebHostEnvironment _env;

        public Startup(IConfiguration configuration, IWebHostEnvironment env)
        {
            Configuration = configuration;
            _env = env;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllersWithViews();

            services.AddSwaggerGen();
            services.AddHttpContextAccessor();
            services.AddSingleton<IPortalConfig, PortalConfig>();
            services.Configure<FormsConfig>(Configuration.GetSection("FormsConfig"));

            services.AddHttpsRedirection(options =>
            {
                options.RedirectStatusCode = StatusCodes.Status307TemporaryRedirect;
            });

            services.AddHeartcore(Configuration);
            services.AddSingleton<GetAssets>();
            services.AddScoped<IFormProcessor, ContactformulierNotificationProcessor>();

            var emailConfig = ConfigurationBinder.Get<EmailConfig>(Configuration.GetSection("Email"));
            services.AddScoped((serviceProvider) => new SmtpClient
            {
                Host = emailConfig.Host,
                Port = emailConfig.Port,
                EnableSsl = emailConfig.EnableSsl,
                Credentials = new NetworkCredential(emailConfig.Username, emailConfig.Password)
            });

            services.AddReverseProxy()
                .LoadFromConfig(Configuration.GetSection("ReverseProxy"))
                .AddTransforms(b => b.AddUmbracoProxies());

            services.AddUmbracoErrorBodyLogging();

            services.AddHttpClient<IUmbracoClient, UmbracoClient>("umbraco", (s, c) =>
            {
                var heartcoreConfig = s.GetRequiredService<UmbracoHeartcoreConfig>();
                c.DefaultRequestHeaders.Add("Accept-Language", "en-US");
                c.DefaultRequestHeaders.Add("Umb-Project-Alias", heartcoreConfig.UmbProjectAlias);
                c.DefaultRequestHeaders.Add("Api-Key", heartcoreConfig.ApiKey);
                c.BaseAddress = new Uri("https://cdn.umbraco.io/content/");
            }).LogAndAbsorbTimeout();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseHttpsRedirection();

            app.UseSerilogRequestLogging(opt => opt
                .SetCancellationLogLevel(Serilog.Events.LogEventLevel.Warning)
                .EnrichWithHostName()
            );

            app.UseUmbraco404Detection();

            app.UseIcattSecurity(env);
            app.UseUmbracoPortalRedirectToWwwPermanent(env);

            app.UseRouting();


            if (env.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI(options =>
                {
                    options.SwaggerEndpoint("/swagger/v1/swagger.json", "WSG Umbraco API");

                });
                app.UseDeveloperExceptionPage();
            }

            app.UseStaticFiles(new StaticFileOptions
            {
                OnPrepareResponse = ctx =>
                {
                    if (env.IsDevelopment())
                    {
                        return;
                    }
                    const int DurationInSeconds = 60 * 60 * 24 * 100;
                    ctx.Context.Response.Headers[HeaderNames.CacheControl] =
                        "public,max-age=" + DurationInSeconds;
                }
            });

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapReverseProxy(x => x.UseUmbracoFormsProcessing());
                endpoints.MapFallbackToController("Index", "Renderer");
            });
            if (env.IsDevelopment())
            {
                app.UseSpa(spa =>
                {
                    spa.Options.SourcePath = "client-app";
                    spa.Options.DevServerPort = 33446;
                    spa.UseReactDevelopmentServer(npmScript: "dev");
                });
            }
        }
    }
}
