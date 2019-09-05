using System.Threading.Tasks;
using Icatt.Digid.Access.Contract;
using Icatt.Digid.Access.Interface;
using Icatt.OAuth.Contract;
using Icatt.ServiceModel;

namespace Icatt.Digid.Access.Proxy
{
    public class DigidAccessProxy<TContext> : ProxyBase<IDigidAccess,TContext>, IDigidAccess where TContext: class
    {
        public DigidAccessProxy(TContext context, IFactoryContainer<TContext> environment) : base(context, environment)
        {
        }

        public async Task<VerifyTokenResponse> VerifyTokenAsync(string samlArtefact)
        {
            return await InvokeAsync( samlArtefact,Service.VerifyTokenAsync);
        }

        public AuthenticationMethod AuthenticationMethod(string relayState)
        {
            return Invoke(relayState,Service.AuthenticationMethod);
        }
    }
}
