namespace Icatt.ServiceModel
{
    public abstract class ServiceFactoryBase<TContext> : IServiceFactory<TContext> where TContext:class
    {
        public IFactoryContainer<TContext> FactoryContainer { get; set; }

        protected ServiceFactoryBase()
        {
        }

        protected ServiceFactoryBase(IFactoryContainer<TContext> environment)
        {
            FactoryContainer = environment;
        }

        public abstract IService CreateService<IService>(TContext context) where IService : class;
    }
}