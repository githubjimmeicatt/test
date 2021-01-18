using System;
using System.Collections.Generic;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Contract
{

    public class Polis
    {
        public List<Pensioenrecht> Pensioenrechten { get; set; }
        public string DossierId { get; set; }
        public int? Nummer { get; set; }
        public int? CodeBasisReglement { get; set; }
        public int? StatusPolis { get; set; }
        public string StatusPolisNaam { get; set; }
        public float? SalarisPensioen { get; set; }
        public float? SalarisPensioenPeriode { get; set; }
        public int? PremieGrondslag { get; set; }
        public int? PremieGrondslagBerekening { get; set; }
        public float? PensioenGrondslag01 { get; set; }
        public int? LeeftijdPensioenOp { get; set; }
        public int? LeeftijdExpiratieOp { get; set; }
        public int? LeeftijdEindeOpbouwOp { get; set; }
        public int? LeeftijdAanvangOpbouwOp { get; set; }
        public int? JaarwerkRegeling { get; set; }
        public float? FactorPartimeGemiddeldBereikbaar { get; set; }
        public float? FactorPartimeHuidig { get; set; }
        public float? DienstjarenToekomstigOngewogen { get; set; }
        public DateTime? DatumPensioen { get; set; }
        public DateTime? DatumRichtPensioenOp { get; set; }
        public DateTime? DatumInDienst { get; set; }
        public DateTime? DatumUitDienst { get; set; }
        public DateTime? DatumExpiratieTnbp { get; set; }
        public DateTime? DatumExpiratieAop { get; set; }
        public DateTime? DatumEindeOpbouwOp { get; set; }
        public DateTime? DatumAanvangPolis { get; set; }
        public int? WerkgeverId { get; set; }
        public string WerkgeverNaam { get; set; }
        public int? CodeTypePolis { get; set; }
        public int? CodeDeelnameTnbp { get; set; }
        public int? CodeDeelnameWzp { get; set; }
        public int? CodeDeelnameOp { get; set; }
        public int? CodeDeelnameNbp { get; set; }
        public int? CodeDeelnameAop { get; set; }
        public float? PerunageOpbouwOp { get; set; }
        public float? BedragFranchise { get; set; }
        public int? NummerRegeling { get; set; }
        public float? PensioenGrondslag { get; set; }
        public float? JaarPremie { get; set; }
        public string Reglement { get; set; }
        public float? FactorArbeidsongeschiktheid { get; set; }
        public DateTime? DatumToetredingWao { get; set; }
        public string DeelnemerSoortNaam { get; set; }
        public List<ArbeidVast> ArbeidsgegevensVast { get; set; }
        public List<ArbeidVariabel> ArbeidsgegevensVariabel { get; set; }
        public int? UrenSalaris { get; set; }
    }
}
