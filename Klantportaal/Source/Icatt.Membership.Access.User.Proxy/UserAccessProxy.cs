using Icatt.Membership.Access.User.Contract;
using Icatt.Membership.Access.User.Contract.Contract;
using Icatt.Membership.Data.UserStore.DbContext;
using Icatt.ServiceModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Membership.Access.User.Proxy
{
    public class UserAccessProxy<TContext> : ProxyBase<IUserAccess, TContext>, IUserAccess where TContext : class
    {
 

        public UserAccessProxy(TContext context, IFactoryContainer<TContext> environment) : base(context, environment)
        {
        }

        public ResetPasswordResult ResetPassword(Contract.User user)
        {
            return Invoke(user, Service.ResetPassword);
        }

        public void SendResetPassWordToken(string username)
        {
             Invoke(username, Service.SendResetPassWordToken);
        }

        public bool VerifyUser(string userName, string password)
        {
            return Invoke(userName, password, Service.VerifyUser);
        }

    }
}
