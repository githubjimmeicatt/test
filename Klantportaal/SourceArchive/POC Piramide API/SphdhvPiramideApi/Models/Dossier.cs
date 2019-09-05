using System;

namespace SphdhvPiramideApi.Models
{
    public class Dossier
    {
        public string DossierId { get; set; }
        public int Nummer { get; set; }
        public int CodeBasisReglement { get; set; }
        public int StatusPolis { get; set; }
        public string StatusPolisNaam { get; set; }
        public float? SalarisPensioen { get; set; }
        public float? SalarisPensioenPeriode { get; set; }
        public object PremieGrondslag { get; set; }
        public object PremieGrondslagBerekening { get; set; }
        public float? PensioenGrondslag01 { get; set; }
        public object LeeftijdPensioenOp { get; set; }
        public object LeeftijdExpiratieOp { get; set; }
        public object LeeftijdEindeOpbouwOp { get; set; }
        public object LeeftijdAanvangOpbouwOp { get; set; }
        public int JaarwerkRegeling { get; set; }
        public float? FactorPartimeGemiddeldBereikbaar { get; set; }
        public float? FactorPartimeHuidig { get; set; }
        public float? DienstjarenToekomstigOngewogen { get; set; }
        public DateTime DatumPensioen { get; set; }
        public object DatumRichtPensioenOp { get; set; }
        public DateTime DatumInDienst { get; set; }
        public DateTime? DatumUitDienst { get; set; }
        public object DatumExpiratieTnbp { get; set; }
        public object DatumExpiratieAop { get; set; }
        public DateTime? DatumEindeOpbouwOp { get; set; }
        public DateTime DatumAanvangPolis { get; set; }
        public int WerkgeverId { get; set; }
        public string WerkgeverNaam { get; set; }
        public int CodeTypePolis { get; set; }
        public object CodeDeelnameTnbp { get; set; }
        public int CodeDeelnameWzp { get; set; }
        public int CodeDeelnameOp { get; set; }
        public int CodeDeelnameNbp { get; set; }
        public object CodeDeelnameAop { get; set; }
        public float? PerunageOpbouwOp { get; set; }
        public float? BedragFranchise { get; set; }
        public int NummerRegeling { get; set; }
        public float? PensioenGrondslag { get; set; }
        public float? JaarPremie { get; set; }
        public string Reglement { get; set; }
        public float? FactorArbeidsongeschiktheid { get; set; }
        public object DatumToetredingWao { get; set; }
        public object DeelnemerSoortNaam { get; set; }
        public object[] ArbeidsgegevensVast { get; set; }
        public object[] ArbeidsgegevensVariabel { get; set; }
    }
}