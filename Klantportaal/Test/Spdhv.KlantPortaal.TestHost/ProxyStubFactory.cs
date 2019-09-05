using System;
using System.Collections.Generic;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Sphdhv.Test.KlantPortaal.Host
{
    public class ProxyStubFactory : IProxyFactory<KlantPortaalContext>
    {
        private readonly Dictionary<string, Func<object>> _stubs;
        private readonly IProxyFactory<KlantPortaalContext> _defaultFactory;

        public ProxyStubFactory(IFactoryContainer<KlantPortaalContext> defaultContainer, Dictionary<string, Func<object>> stubs)
        {
            _defaultFactory = defaultContainer.ProxyFactory;
            _stubs = stubs;
        }

        public IFactoryContainer<KlantPortaalContext> FactoryContainer { get; set; }

        public IService CreateProxy<IService>(KlantPortaalContext context) where IService : class
        {
            var name = typeof(IService).Name;

            if (_stubs.ContainsKey(name))
            {
                return _stubs[name]() as IService;
            }

            return _defaultFactory.CreateProxy<IService>(context);

        }
    }
}