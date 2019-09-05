using Icatt.Membership.Access.User.Contract.Contract;
using System.ServiceModel;

namespace Icatt.Membership.Access.User.Contract
{
    [ServiceContract]
    public interface IUserAccess
    {
        [OperationContract]
        bool VerifyUser(string userName, string password);

        [OperationContract]
        void SendResetPassWordToken(string username);

        [OperationContract]
        ResetPasswordResult ResetPassword(User user);

    }
}
