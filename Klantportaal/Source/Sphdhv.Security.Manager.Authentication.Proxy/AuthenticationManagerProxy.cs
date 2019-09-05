using Icatt.ServiceModel;
using Sphdhv.Security.Manager.Authentication.Interface;

namespace Sphdhv.Security.Manager.Authentication.Proxy
{
    public class AuthenticationManagerProxy<TContext> : ProxyBase<Interface.IAuthenticationManager, TContext>, Interface.IAuthenticationManager
        where TContext :class, IAuthenticationTicket
    {
        public AuthenticationManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        bool Interface.IAuthenticationManager.AuthenticateUser()
        {
            return Invoke(Service.AuthenticateUser);
        }
    }
}
