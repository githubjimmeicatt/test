using System;
using System.Collections.Generic;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Sphdhv.Test.KlantPortaal.Host
{
    internal class ServiceStubFactory : IServiceFactory<KlantPortaalContext>
    {
        private readonly Dictionary<string, Func<object>> _stubs;
        private readonly IServiceFactory<KlantPortaalContext> _defaultServiceFactory;

        public ServiceStubFactory(IFactoryContainer<KlantPortaalContext> defaultFactoryContainer, Dictionary<string, Func<object>> servicestubs )
        {
            _stubs = servicestubs ?? new Dictionary<string, Func<object>>();
            _defaultServiceFactory = defaultFactoryContainer.ServiceFactory;
            
        }

        public IService CreateService<IService>(KlantPortaalContext context) where IService : class {

            var name = typeof(IService).Name;

            if (_stubs.ContainsKey(name))
            {
                return _stubs[name]() as IService;
            }

            return _defaultServiceFactory.CreateService<IService>(context);
        }

        public IFactoryContainer<KlantPortaalContext> FactoryContainer { get; set; }
    }
}