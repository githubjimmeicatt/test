using System;
using System.Collections.Generic;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Host.WebHost;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Sphdhv.Test.KlantPortaal.Host
{
    public class TestKlantPortaalFactoryContainer : FactoryContainer<KlantPortaalContext>
    {
        public TestKlantPortaalFactoryContainer(Dictionary<string, Func<object>> proxystubs = null, 
            Dictionary<string,Func<object>> servicestubs =null)
        {
            KlantPortaalFactoryContainer defaultEnvironment = new KlantPortaalFactoryContainer();
            ProxyFactory = new ProxyStubFactory(defaultEnvironment, proxystubs);
            ServiceFactory = new ServiceStubFactory(defaultEnvironment, servicestubs);
            defaultEnvironment.ProxyFactory = ProxyFactory;
            defaultEnvironment.ServiceFactory = ServiceFactory;
        }
    }
}
