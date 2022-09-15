using System.Web.Mvc;
using System.Web.Routing;

namespace Sphdhv.KlantPortaal.Host.WebHost
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //assertionConsumerServiceEndpointAcceptMijnDhv
            routes.MapRoute(
               name: "digidVerifyToken",
               url: "DesktopModules/Sphdhv/KlantPortaal/api/digid/VerifyToken",
               defaults: new { controller = "Authentication", action = "VerifyToken" }
           );


            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Authentication", action = "Login", id = UrlParameter.Optional }
            );
        }
    }
}
