using System.Threading.Tasks;
using Icatt.OAuth.Contract;
using Sphdhv.KlantPortaal.Manager.Authentication.Contract;

namespace Sphdhv.KlantPortaal.Manager.Authentication.Interface
{
    public interface IAuthenticationManager
    {

        Task<ExchangeTokenResponse> ExchangeTokenAsync(string authToken, string relayState);

        AuthenticationMethod AuthenticationMethod(string cientAppId, string clientAppEnvironment,string clientAppEndpoint, string relayState);
    }
}
