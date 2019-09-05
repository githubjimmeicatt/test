using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
