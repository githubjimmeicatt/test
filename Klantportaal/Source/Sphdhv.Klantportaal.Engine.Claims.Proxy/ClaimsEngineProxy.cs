using System.Threading.Tasks;
using Icatt.OAuth.Contract;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Engine.Claims.Interface;
using Sphdhv.KlantPortaal.Engine.Claims.Contract;

namespace Sphdhv.KlantPortaal.Engine.Claims.Proxy
{
    public class ClaimsEngineProxy<TContext> : ProxyBase<IClaimsEngine,TContext>, IClaimsEngine where TContext : class
    {
        public ClaimsEngineProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }


        Claim[] IClaimsEngine.ExchangeToken(string appId, string envId, string authToken)
        {
            return Invoke(appId,envId,authToken, Service.ExchangeToken);
        }

        async Task<ExchangeTokenResponse> IClaimsEngine.ExchangeTokenAsync(string appId, string envId, string authToken, string relayState)
        {
            return await InvokeAsync(appId, envId, authToken, relayState, Service.ExchangeTokenAsync);
        }
    }
}
