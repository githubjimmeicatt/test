using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Membership.Access.User.Contract
{
    [DataContract]
    public class User
    {
        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public string Id { get; set; }

        [DataMember]
        public string PasswordResetToken { get; set; }

        [DataMember]
        public string NewPassword { get; set; }
    }
}
