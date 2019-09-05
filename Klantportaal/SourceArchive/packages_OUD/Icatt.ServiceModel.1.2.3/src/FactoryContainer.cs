namespace Icatt.ServiceModel
{
    public class FactoryContainer<TContext> :IFactoryContainer<TContext> where TContext: class
    {
        private IProxyFactory<TContext> _proxyFactory;
        private IServiceFactory<TContext> _serviceFactory;

        public IProxyFactory<TContext> ProxyFactory
        {
            get { return _proxyFactory; }
            set
            {
                _proxyFactory = value;
                if (_proxyFactory == null) return;
                _proxyFactory.FactoryContainer = this;

            }
        }

        public IServiceFactory<TContext> ServiceFactory
        {
            get { return _serviceFactory; }
            set
            {
                _serviceFactory = value;
                if (_serviceFactory == null) return;
                _serviceFactory.FactoryContainer = this;
            }
        }


        public FactoryContainer(IProxyFactory<TContext> proxyFactory = null, IServiceFactory<TContext> serviceFactory = null)
        {
            ProxyFactory = proxyFactory;
            ServiceFactory = serviceFactory;
        }

    }
}
