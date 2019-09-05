using Icatt.ServiceModel;
using System.Collections.Generic;
using Sphdhv.KlantPortaal.Common;
using System;

namespace Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal
{
    public class KlantPortaalFactoryContainer : FactoryContainer<KlantPortaalContext>
    {
        public KlantPortaalFactoryContainer(
            IProxyFactory<KlantPortaalContext> proxyFactory = null, 
            IServiceFactory<KlantPortaalContext> serviceFactory = null) 
        {
            ProxyFactory = proxyFactory ?? new KlantPortaalProxyFactory();
            ServiceFactory = serviceFactory ?? new KlantPortaalServiceFactory<KlantPortaalContext>();
        }


        public KlantPortaalFactoryContainer(Dictionary<Type,Func<KlantPortaalContext,object>> proxyMockFactory ,Dictionary<Type, Func<KlantPortaalContext, object>> serviceMockFact ) 
            : this(new KlantPortaalProxyFactory(proxyMockFactory), new KlantPortaalServiceFactory<KlantPortaalContext>(serviceMockFact))
        {
        }
    }
}