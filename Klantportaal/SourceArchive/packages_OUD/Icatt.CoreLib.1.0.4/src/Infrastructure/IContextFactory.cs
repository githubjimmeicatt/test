namespace Icatt.Infrastructure
{

    /// <summary>
    /// Interface defining the contract for context factories. Context factories can provide the services that in turn provide the proper session ID and request ID for the current context
    /// </summary>
    /// <remarks>
    ///     Contcrete implementations are Icatt.Web.Infrastructure.WebContextFactory and Icatt.Infrastructure.RunContextFactory
    /// </remarks>
    public interface IContextFactory 
    {
        IRequestIdService CreateRequestIdService();
        ISessionIdService CreateSessionIdService();


    }
}