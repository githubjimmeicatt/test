using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract;
using Sphdhv.KlantPortaal.Common;
using Icatt.OAuth.Contract;
using Icatt.Identity.Manager.AspNetIdentity.Contract.Contract;

namespace Sphdhv.KlantPortaal.Manager.AspNetIdentity.Proxy
{

    public class AspNetIdentityManagerProxy<TContext> : ProxyBase<IAspNetIdentityManager, TContext>, IAspNetIdentityManager where TContext : class, IApplicationEnvironmentContext
    {
        public AspNetIdentityManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {

        }

        public Claim[] ExchangeToken(string authToken, string relayState)
        {
            return Invoke(authToken, relayState, Service.ExchangeToken);
        }

        public Task<LoginResult> Login(string username, string password)
        {
            return Invoke(username, password, Service.Login);
        }
         

        public ResetPasswordResult ResetPassword(ResetPassword resetPassword)
        {
            return Invoke(resetPassword, Service.ResetPassword);
        }

        public void SendPasswordResetToken(string username)
        {
            Invoke(username, Service.SendPasswordResetToken);
        }
    }

}
