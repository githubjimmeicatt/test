using System;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Contract
{
    public class Huidigepartner
    {
        public string DossierId { get; set; }
        public int Nummer { get; set; }
        public string NaamVolledig { get; set; }
        public string Geslacht { get; set; }
        public DateTime DatumGeboorte { get; set; }
        public DateTime? DatumHuwelijk { get; set; }
        public DateTime? DatumPartnerschap { get; set; }
        public DateTime? DatumSamenwonen { get; set; }
        public string Status { get; set; }
        public string StatusOmschrijving { get; set; }
    }
}