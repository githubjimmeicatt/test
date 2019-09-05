namespace Icatt.ServiceModel
{
    public interface IFactoryContainer<TContext>  where TContext : class
    {
        IProxyFactory<TContext> ProxyFactory { get; set; }
        IServiceFactory<TContext> ServiceFactory { get; set; }


    }
}