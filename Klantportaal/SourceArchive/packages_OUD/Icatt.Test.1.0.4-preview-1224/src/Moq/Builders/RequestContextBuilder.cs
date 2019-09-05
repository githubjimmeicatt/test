using System.Web;
using System.Web.Routing;
using Moq;

namespace Icatt.Test.Moq.Builders
{
    public class RequestContextBuilder : Builder<RequestContext>
    {

        public RequestContextBuilder()
        {
            Constructor = () =>
            {
                return new RequestContext();
            };

        }

        public RouteDataBuilder UseRouteDataBuilder()
        {
            var routeDataBuilder = new RouteDataBuilder();
            WithModifier(m => m.RouteData = routeDataBuilder.Build());
            return routeDataBuilder;


        }



    }

}