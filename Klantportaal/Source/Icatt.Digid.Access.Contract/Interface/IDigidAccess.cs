using System.Threading.Tasks;
using Icatt.OAuth.Contract;

namespace Icatt.Digid.Access.Interface
{
    public interface IDigidAccess
    {
        Task<Contract.VerifyTokenResponse> VerifyTokenAsync(string  samlArtefact);

        AuthenticationMethod AuthenticationMethod(string relayState);
    }
}

