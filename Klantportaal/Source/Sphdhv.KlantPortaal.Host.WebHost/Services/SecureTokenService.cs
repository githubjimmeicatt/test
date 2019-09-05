using System.Threading.Tasks;
using Icatt.OAuth.Contract;
using Sphdhv.KlantPortaal.Manager.Authentication.Interface;
using System.ServiceModel;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using System.Linq;
using Sphdhv.KlantPortaal.Host.WebHost.Security;

namespace Sphdhv.KlantPortaal.Host.WebHost.Services
{
    public class SecureTokenService : ISecureTokenService
    {

        /// <summary>
        /// Haalt de claims op bij de AuthenticationManager
        /// </summary>
        /// <param name="token"></param>
        /// <param name="relayState"></param>
        /// <returns></returns>
        public async Task<Claim[]> VerifyToken(string token, string relayState)
        {

            var container = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext(OperationContext.Current.ServiceSecurityContext.PrimaryIdentity);
            var proxy = container.ProxyFactory.CreateProxy<IAuthenticationManager>(context);
            var response = await proxy.ExchangeTokenAsync(token, relayState);
            if (response?.Status == Manager.Authentication.Contract.StatusCode.Success)
                return response.Claims;

            return null;


        }
    }
}