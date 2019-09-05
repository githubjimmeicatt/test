using System.Threading.Tasks;
using Icatt.OAuth.Contract;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Manager.Authentication.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Manager.Authentication.Contract;

namespace Sphdhv.KlantPortaal.Manager.Authentication.Proxy
{
    public class AuthorizationManagerProxy<TContext> : ProxyBase<IAuthenticationManager, TContext>, IAuthenticationManager where TContext : class, IApplicationEnvironmentContext
    {
        public AuthorizationManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public Task<ExchangeTokenResponse> ExchangeTokenAsync(string authToken, string relayState)
        {
            return InvokeAsync(authToken, relayState, Service.ExchangeTokenAsync);
        }

        AuthenticationMethod IAuthenticationManager.AuthenticationMethod(string clientAppId, string clientAppEnvironment, string clientAppEndpoint, string relayState)
        {
           return Invoke(clientAppId, clientAppEnvironment, clientAppEndpoint, relayState, Service.AuthenticationMethod);
        }

    }
}
