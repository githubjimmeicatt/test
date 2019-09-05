namespace Icatt.ServiceModel
{
    public interface IServiceFactory<TContext> where TContext : class
    {
       IService CreateService<IService>(TContext context) where IService: class ;

       IFactoryContainer<TContext> FactoryContainer { get; set; }
    }
}