using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract
{
    [DataContract]
    public class ActueelPensioen
    {
        public List<Polis> Polissen { get; set; }
        public Pensioen Pensioen { get; set; }
        public DeelnemerProfiel DeelnemerProfiel { get; set; }
        public bool IsBlocked { get; set; }

        //public string DossierId { get; set; }
        //public string AchternaamVolledig { get; set; }
    }
}
