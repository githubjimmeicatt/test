namespace Icatt.ServiceModel
{
    public abstract class ProxyFactoryBase<TContext> : IProxyFactory<TContext> where TContext : class
    {
        public IFactoryContainer<TContext> FactoryContainer { get; set; }

        protected ProxyFactoryBase()
        {
        }

        protected ProxyFactoryBase(IFactoryContainer<TContext> factoryContainer)
        {
            FactoryContainer = factoryContainer;
        }

        public abstract IService CreateProxy<IService>(TContext context) where IService : class;
    }
}