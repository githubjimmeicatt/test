using System;
using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
    public class Pensioenrecht
    {
        [DataMember]
        public string Code { get; set; }
[DataMember]
        public DateTime? DatumExpiratie { get; set; }
[DataMember]
        public DateTime? DatumStart { get; set; }
[DataMember]
        public int? NummerPartner { get; set; }
[DataMember]
        public int? NummerKind { get; set; }
[DataMember]
        public int? NummerPolis { get; set; }
[DataMember]
        public string Soort { get; set; }
[DataMember]
        public int? StatusPolis { get; set; }
[DataMember]
        public string StatusPolisOmschrijving { get; set; }
[DataMember]
        public int? StatusRecht { get; set; }
[DataMember]
        public string StatusRechtOmschrijving { get; set; }
[DataMember]
        public float? Waarde { get; set; }
 
    }
}