using System;
using Icatt.Data.Entity;

namespace Sphdhv.KlantPortaal.Data.Deelnemer.Entities
{

    //nite meer in gebruik. tabel kan tzt weg
    public class Deelnemer : IObjectWithState
    {
        public int Id { get; set; }
        public byte[] Email { get; set; }
        public byte[] Bsn { get; set; }
        public DeelnemerStatus Status { get; set; }
        public DateTime CreatedAtUtc { get; set; }
        public DateTime ModifiedAtUtc { get; set; }
        public ObjectState State { get; set; }
        public Guid VerificationId {get;set;}
        public byte[] BsnHash { get; set; }
    }


    [Flags]
    public enum DeelnemerStatus
    {
        None = 0,
        EmailOptOut = 1,
        EmailVerified = 2,
    }

}
