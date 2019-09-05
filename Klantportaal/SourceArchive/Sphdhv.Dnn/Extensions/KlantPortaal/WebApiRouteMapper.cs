using System.Web.Http;
using DotNetNuke.Web.Api;

namespace Sphdhv.Dnn.Extensions.KlantPortaal
{
    public class WebApiRouteMapper
    {
        public class RouteMapper : IServiceRouteMapper
        {
            public void RegisterRoutes(IMapRoute mapRouteManager)
            {
                //               DesktopModules/Sphdhv/KlantPortaal/API/{controller}/{action}
                mapRouteManager.MapHttpRoute("Sphdhv/KlantPortaal", "DnnWebApi", "{controller}/{action}", new {action="Default" }, new[]{"Sphdhv.DnnWebApi.Controllers",});
            }
        }
    }

}
