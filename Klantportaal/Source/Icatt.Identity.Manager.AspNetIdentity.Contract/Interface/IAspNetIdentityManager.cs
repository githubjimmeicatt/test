using Icatt.Identity.Manager.AspNetIdentity.Contract.Contract;
using Icatt.OAuth.Contract;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract
{
    public interface IAspNetIdentityManager 
    {
        Task<LoginResult>  Login(string username, string password);

        Claim[] ExchangeToken(string authToken,string relayState);
        void SendPasswordResetToken(string username);
        ResetPasswordResult ResetPassword(ResetPassword resetPassword);
    }
}
