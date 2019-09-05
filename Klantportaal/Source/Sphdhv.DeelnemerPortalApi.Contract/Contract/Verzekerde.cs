using System;
using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
    public class Verzekerde
    {
        [DataMember]
        public string AchternaamVolledig { get; set; }
        [DataMember]
        public string Afdeling { get; set; }
        [DataMember]
        public int Bsn { get; set; }
        [DataMember]
        public string Burgerlijkestaat { get; set; }
        [DataMember]
        public string CrmId { get; set; }
        [DataMember]
        public DateTime DatumGeboorte { get; set; }
        [DataMember]
        public DateTime? DatumOpnameFonds { get; set; }
        [DataMember]
        public DateTime? DatumOverlijden { get; set; }
        [DataMember]
        public string Fonds { get; set; }
        [DataMember]
        public string Geboortenaam { get; set; }
        [DataMember]
        public string Geslacht { get; set; }
        [DataMember]
        public string Id { get; set; }
        public string IdentificatieVerzekerde { get; set; }
        [DataMember]
        public bool IsActief { get; set; }
        [DataMember]
        public string Naam { get; set; }
        [DataMember]
        public string Nummer { get; set; }
        [DataMember]
        public string PostSelectie { get; set; }
        [DataMember]
        public string StatusVerzekerde { get; set; }
        [DataMember]
        public string Tussenvoegsels { get; set; }
        [DataMember]
        public string Uitzondering { get; set; }
        [DataMember]
        public string Voorletters { get; set; }
        [DataMember]
        public Bereikbaarheden[] Bereikbaarheden { get; set; }
        [DataMember]
        public Adressen[] Adressen { get; set; }
        [DataMember]
        public Huidigepartner HuidigePartner { get; set; }
    }
}