namespace Icatt.ServiceModel
{
    public abstract class ClientBase<TContext> where TContext : class
    {
        protected ClientBase(TContext context,  IFactoryContainer<TContext> factoryContainer )
        {
            Context = context;
            FactoryContainer = factoryContainer;
        }

        protected TContext Context { get; }

        public IFactoryContainer<TContext> FactoryContainer { get; }
    }
}