namespace Icatt.ServiceModel
{
    public abstract class ServiceBase<TContext> where TContext : class
    {
        protected ServiceBase(TContext context,  IFactoryContainer<TContext> factoryContainer )
        {
            Context = context;
            FactoryContainer = factoryContainer;
        }

        protected TContext Context { get; }

        public IFactoryContainer<TContext> FactoryContainer { get; }
    }
}