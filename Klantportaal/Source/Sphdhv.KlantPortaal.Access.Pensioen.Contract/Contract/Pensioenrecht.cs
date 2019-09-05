using System;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Contract
{
    public class Pensioenrecht
    {
        public string Code { get; set; }
        public DateTime? DatumExpiratie { get; set; }
        public DateTime? DatumStart { get; set; }
        public int? NummerPartner { get; set; }
        public int? NummerKind { get; set; }
        public int? NummerPolis { get; set; }
        public string Soort { get; set; }
        public int? StatusPolis { get; set; }
        public string StatusPolisOmschrijving { get; set; }
        public int? StatusRecht { get; set; }
        public string StatusRechtOmschrijving { get; set; }
        public float? Waarde { get; set; }
    }
}