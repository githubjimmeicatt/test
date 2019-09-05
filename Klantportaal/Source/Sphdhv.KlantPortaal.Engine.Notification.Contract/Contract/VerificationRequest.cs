using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Engine.Notification.Contract
{
    [DataContract]
    public class VerificationRequest
    {
        [DataMember]
        public string To { get; set; }

        [DataMember]
        public string VerificationLink { get; set; }
    }
}
