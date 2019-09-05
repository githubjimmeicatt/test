using System;
using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
    public class Huidigepartner
    {
        [DataMember]
        public string DossierId { get; set; }
        [DataMember]
        public int Nummer { get; set; }
        [DataMember]
        public string NaamVolledig { get; set; }
        [DataMember]
        public string Geslacht { get; set; }
        [DataMember]
        public DateTime DatumGeboorte { get; set; }
        [DataMember]
        public DateTime? DatumHuwelijk { get; set; }
        [DataMember]
        public DateTime? DatumPartnerschap { get; set; }
        [DataMember]
        public DateTime? DatumSamenwonen { get; set; }
        [DataMember]
        public string Status { get; set; }
        [DataMember]
        public string StatusOmschrijving { get; set; }
    }
}