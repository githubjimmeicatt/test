using Icatt.ServiceModel;
using Sphdhv.DeelnemerPortalApi.Interface;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.Authentication;
using Sphdhv.Security.Manager.Authentication.Interface;

namespace Sphdhv.Security.Environment
{
    public class AuthenticationFactoryContainer<TContext> : FactoryContainer<TContext>
        where TContext : class, IAuthenticationTicket, IUserContext, ISessionMarkerContext, IPiramideContext
    {
        public AuthenticationFactoryContainer() : this(null,null)
        {
        }

        public AuthenticationFactoryContainer(IProxyFactory<TContext> proxyFactory = null, IServiceFactory<TContext> serviceFactory = null) : base(proxyFactory, serviceFactory)
        {
            ProxyFactory = proxyFactory ?? new AuthenticationProxyFactory<TContext>();
            ServiceFactory = serviceFactory ?? new AuthenticationServiceFactory<TContext>();
        }
    }
}