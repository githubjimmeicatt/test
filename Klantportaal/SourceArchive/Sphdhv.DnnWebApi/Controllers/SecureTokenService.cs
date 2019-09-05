using System.Threading.Tasks;
using Icatt.OAuth.Contract;

namespace Sphdhv.DnnWebApi.Controllers
{
    public class SecureTokenService : System.ServiceModel.ClientBase<ISecureTokenService>, ISecureTokenService
    {
        public async Task<Claim[]> VerifyTokenAsync(string token, string relayState)
        {
            return await Channel.VerifyTokenAsync(token, relayState);
        }
    }
}