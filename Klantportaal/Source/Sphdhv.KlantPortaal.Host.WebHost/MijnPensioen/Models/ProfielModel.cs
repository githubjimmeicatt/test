using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models
{
    [DataContract]
    public class ProfielModel
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
        public string DatumGeboorte { get; set; }
        [DataMember]
        public string DatumOpnameFonds { get; set; }
        [DataMember]
        public string DatumOverlijden { get; set; }
        [DataMember]
        public string Fonds { get; set; }
        [DataMember]
        public string Geboortenaam { get; set; }
        [DataMember]
        public string Geslacht { get; set; }
        [DataMember]
        public string Id { get; set; }
        [DataMember]
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
        public List<BereikbaarheidModel> Bereikbaarheden { get; set; }
        [DataMember]
        public List<AdresModel> Adressen { get; set; }
        [DataMember]
        public HuidigepartnerModel HuidigePartner { get; set; }
    }

    [DataContract]
    public class BereikbaarheidModel
    {
        [DataMember]
        public string CrmId { get; set; }
        [DataMember]
        public string Type { get; set; }
        [DataMember]
        public string Waarde { get; set; }
    }

    [DataContract]
    public class AdresModel
    {
        [DataMember]
        public string CrmId { get; set; }
        [DataMember]
        public int Huisnummer { get; set; }
        [DataMember]
        public string HuisnummerToevoeging { get; set; }
        [DataMember]
        public string HuisnummerSamengesteld { get; set; }
        [DataMember]
        public string Land { get; set; }
        [DataMember]
        public string Land2 { get; set; }
        [DataMember]
        public string Plaats { get; set; }
        [DataMember]
        public string Postcode { get; set; }
        [DataMember]
        public string Straat { get; set; }
        [DataMember]
        public string Straat2 { get; set; }
        [DataMember]
        public string TypeAdres { get; set; }
    }

    [DataContract]
    public class HuidigepartnerModel
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
        public string DatumGeboorte { get; set; }
        [DataMember]
        public string DatumHuwelijk { get; set; }
        [DataMember]
        public string DatumPartnerschap { get; set; }
        [DataMember]
        public string DatumSamenwonen { get; set; }
        [DataMember]
        public string Status { get; set; }
        [DataMember]
        public string StatusOmschrijving { get; set; }
    }
}
