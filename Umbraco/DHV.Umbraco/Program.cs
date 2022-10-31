using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Serilog;
using Wsg.CorporateUmbraco;

var builder = WebApplication.CreateBuilder(args);

Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .CreateBootstrapLogger();

Log.Information("Starting up");

try
{
    var startup = new Startup(builder.Configuration, builder.Environment);
    
    builder.Host.UseSerilog((HostBuilderContext ctx, IServiceProvider services, LoggerConfiguration lc) => lc
        .ReadFrom.Configuration(builder.Configuration)
        .IgnoreRequestCancellation(services));

    startup.ConfigureServices(builder.Services);
    var app = builder.Build();
    startup.Configure(app, builder.Environment);
    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Application start-up failed");
}
finally
{
    Log.CloseAndFlush();
}
