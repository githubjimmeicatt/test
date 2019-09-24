using Serilog;
using Serilog.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Sphdhv.KlantPortaal.Host.WebHost
{
    public class LoggingConfig
    {
        public static LoggerConfiguration RegisterConfig()
        {
            return new LoggerConfiguration()
                .ReadFrom.AppSettings()
                .MinimumLevel.Debug()
                .Enrich.FromLogContext()
                .Enrich.WithMachineName()
                .Enrich.WithHttpRequestId()
                .Enrich.WithHttpRequestUrl()
                .Enrich.WithHttpRequestType()
                .Enrich.WithExceptionDetails()
                .Enrich.WithHttpSessionId();
        }
    }
}
