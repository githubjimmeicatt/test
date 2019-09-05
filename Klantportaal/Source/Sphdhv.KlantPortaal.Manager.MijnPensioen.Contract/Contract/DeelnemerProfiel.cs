using System;
using System.Collections.Generic;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract
{

    public class DeelnemerProfiel
    {
        public string AchternaamVolledig { get; set; }
        public string Afdeling { get; set; }
        public int Bsn { get; set; }
        public string Burgerlijkestaat { get; set; }
        public string CrmId { get; set; }
        public DateTime DatumGeboorte { get; set; }
        public DateTime? DatumOpnameFonds { get; set; }
        public DateTime? DatumOverlijden { get; set; }
        public string Fonds { get; set; }
        public string Geboortenaam { get; set; }
        public string Geslacht { get; set; }
        public string Id { get; set; }
        public string IdentificatieVerzekerde { get; set; }
        public bool IsActief { get; set; }
        public string Naam { get; set; }
        public string Nummer { get; set; }
        public string PostSelectie { get; set; }
        public string StatusVerzekerde { get; set; }
        public string Tussenvoegsels { get; set; }
        public string Uitzondering { get; set; }
        public string Voorletters { get; set; }
        public List<Bereikbaarheid> Bereikbaarheden { get; set; }
        public List<Adres>  Adressen { get; set; }
        public Huidigepartner HuidigePartner { get; set; }

    }
}
