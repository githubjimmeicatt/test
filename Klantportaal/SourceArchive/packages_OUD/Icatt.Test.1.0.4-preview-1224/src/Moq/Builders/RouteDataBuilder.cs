using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Web.Routing;

namespace Icatt.Test.Moq.Builders
{
    public class RouteDataBuilder : Builder<RouteData>
    {
        public RouteDataBuilder()
        {
            Constructor = () =>
            {

                return new RouteData();
            };
        }

        public RouteDataBuilder WithValues(List<RouteValue> values)
        {
            WithModifier(
                r =>
                {
                    if(null==values)
                        return;

                    foreach (var value in values)
                    {
                        r.Values.Add(value.Key,value.Value);
                    }
                }
            );
            return this;
        }

    }
}
