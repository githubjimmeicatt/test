using System;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Access.Deelnemer.Contract
{
    [DataContract]
    public class Deelnemer
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public string Bsn { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public DeelnemerStatus Status { get; set; }
        [DataMember]
        public DateTime CreatedAtUtc { get; set; }
        [DataMember]
        public DateTime ModifiedAtUtc { get; set; }
        [DataMember]
        public Guid VerificationId { get; set; }
    }


    [DataContract]
    public class DeelnemerUpdate
    {
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public DeelnemerStatus Status { get; set; }
        [DataMember]
        public Guid VerificationId { get; set; }
    }


    [Flags]
    public enum DeelnemerStatus
    {
        None = 0,
        EmailOptOut = 1,
        EmailVerified = 2,
    }

}
