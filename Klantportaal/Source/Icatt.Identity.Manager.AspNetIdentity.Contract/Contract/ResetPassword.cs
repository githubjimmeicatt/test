using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract
{
    [DataContract]
    public class ResetPassword
    {
        [DataMember]
        public string Token { get; set; }

        [DataMember]
        public string UserId { get; set; }

        [DataMember]
        public string NewPassword { get; set; }

        [DataMember]
        public string NewPasswordConfirm { get; set; }
    }
}
