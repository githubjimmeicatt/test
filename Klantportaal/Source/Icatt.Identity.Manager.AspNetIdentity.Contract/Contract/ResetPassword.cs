using System.Runtime.Serialization;

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
