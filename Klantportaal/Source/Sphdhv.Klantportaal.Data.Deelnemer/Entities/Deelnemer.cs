using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Data.Entity;

namespace Sphdhv.KlantPortaal.Data.Deelnemer.Entities
{
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
