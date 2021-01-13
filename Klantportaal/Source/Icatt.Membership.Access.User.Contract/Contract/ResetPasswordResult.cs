using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Icatt.Membership.Access.User.Contract.Contract
{
    [DataContract]
    public class ResetPasswordResult
    {
        [DataMember]
        public bool Succes { get; set; }

        [DataMember]
        public IEnumerable<string> Errors { get; set; }

    }
}
