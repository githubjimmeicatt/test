using Icatt.Membership.Access.User.Contract.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Membership.Access.User.Contract.Contract
{
    public class MembershipAccessContext : IMembershipAccessContext
    {
        private string _applicationId;

        public string ApplicationId { get { return _applicationId; } set { _applicationId = value; }  }
    }
}
