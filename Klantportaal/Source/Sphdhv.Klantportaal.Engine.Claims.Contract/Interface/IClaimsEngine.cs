using Icatt.OAuth.Contract;
using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Engine.Claims.Contract;

namespace Sphdhv.KlantPortaal.Engine.Claims.Interface
{
    public interface IClaimsEngine
    {
        Claim[] ExchangeToken(string appId, string envId, string authToken);
        Task<ExchangeTokenResponse> ExchangeTokenAsync(string appId, string envId, string authToken, string relayState);
    }
}
