using System.ServiceModel;
using System.Threading.Tasks;

namespace Sphdhv.DnnWebApi.Controllers
{
    [ServiceContract]
    public interface ISecureTokenService
    {
        [OperationContract]
        Task<Icatt.OAuth.Contract.Claim[]> VerifyTokenAsync(string token, string relayState);
    }
}