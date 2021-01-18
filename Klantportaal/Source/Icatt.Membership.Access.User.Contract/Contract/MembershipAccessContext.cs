using Icatt.Membership.Access.User.Contract.Interface;

namespace Icatt.Membership.Access.User.Contract.Contract
{
    public class MembershipAccessContext : IMembershipAccessContext
    {
        private string _applicationId;

        public string ApplicationId { get { return _applicationId; } set { _applicationId = value; }  }
    }
}
