using Icatt.Identity.Manager.AspNetIdentity.Contract.Contract;
using Icatt.OAuth.Contract;
using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
