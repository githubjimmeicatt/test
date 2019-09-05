using System.ServiceModel;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Host.WebHost.Services
{
    [ServiceContract]
    public interface ISecureTokenService
    {
        [OperationContract]
        Task<Icatt.OAuth.Contract.Claim[]> VerifyToken(string token, string relayState);
    }
}