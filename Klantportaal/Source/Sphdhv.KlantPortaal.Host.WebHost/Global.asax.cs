using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Http;
using System.Threading.Tasks;
using System.IO;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using Newtonsoft.Json.Converters;
using System.Net.Http;
using System.Net;
using Serilog;

namespace Sphdhv.KlantPortaal.Host.WebHost
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            GlobalConfiguration
                .Configuration
                .Formatters
                .Insert(0, new JsonpFormatter());

            MvcHandler.DisableMvcResponseHeader = true;

            var logConfig = LoggingConfig.RegisterConfig();
            //breid de config hier eventueel uit
            Log.Logger = logConfig.CreateLogger();
        }

    }

    public class JsonpFormatter : JsonMediaTypeFormatter
    {

        public JsonpFormatter()
        {
            SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/json"));
            SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/javascript"));
            SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/javascript"));

            JsonpParameterName = "callback";
        }

        public JsonpFormatter(HttpRequestMessage request):this()
        {
            JsonpCallbackFunction = GetJsonCallbackFunction(request);
        }

        /// <summary>
        ///  Name of the query string parameter to look for
        ///  the jsonp function name
        /// </summary>
        public string JsonpParameterName { get; set; }

        /// <summary>
        /// Captured name of the Jsonp function that the JSON call
        /// is wrapped in. Set in GetPerRequestFormatter Instance
        /// </summary>
        private string JsonpCallbackFunction;





        /// <summary>
        /// Retrieves the Jsonp Callback function
        /// from the query string
        /// </summary>
        /// <returns></returns>
        private string GetJsonCallbackFunction(HttpRequestMessage request)
        {
            if (request.Method != HttpMethod.Get)
                return null;

            var query = HttpUtility.ParseQueryString(request.RequestUri.Query);
            var queryVal = query[JsonpParameterName];

            if (string.IsNullOrEmpty(queryVal))
                return null;

            return queryVal;
        }
    }
}