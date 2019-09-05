using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
    public class Polis
    {
        [DataMember]
        public string DossierId { get; set; }
        [DataMember]
        public int? Nummer { get; set; }
        [DataMember]
        public int? CodeBasisReglement { get; set; }
        [DataMember]
        public int? StatusPolis { get; set; }
        [DataMember]
        public string StatusPolisNaam { get; set; }
        [DataMember]
        public float? SalarisPensioen { get; set; }
        [DataMember]
        public float? SalarisPensioenPeriode { get; set; }
        [DataMember]
        public int? PremieGrondslag { get; set; }
        [DataMember]
        public int? PremieGrondslagBerekening { get; set; }
        [DataMember]
        public float? PensioenGrondslag01 { get; set; }
        [DataMember]
        public int? LeeftijdPensioenOp { get; set; }
        [DataMember]
        public int? LeeftijdExpiratieOp { get; set; }
        [DataMember]
        public int? LeeftijdEindeOpbouwOp { get; set; }
        [DataMember]
        public int? LeeftijdAanvangOpbouwOp { get; set; }
        [DataMember]
        public int? JaarwerkRegeling { get; set; }
        [DataMember]
        public float? FactorPartimeGemiddeldBereikbaar { get; set; }
        [DataMember]
        public float? FactorPartimeHuidig { get; set; }
        [DataMember]
        public float? DienstjarenToekomstigOngewogen { get; set; }
        [DataMember]
        public DateTime? DatumPensioen { get; set; }
        [DataMember]
        public DateTime? DatumRichtPensioenOp { get; set; }
        [DataMember]
        public DateTime? DatumInDienst { get; set; }
        [DataMember]
        public DateTime? DatumUitDienst { get; set; }
        [DataMember]
        public DateTime? DatumExpiratieTnbp { get; set; }
        [DataMember]
        public DateTime? DatumExpiratieAop { get; set; }
        [DataMember]
        public DateTime? DatumEindeOpbouwOp { get; set; }
        [DataMember]
        public DateTime? DatumAanvangPolis { get; set; }
        [DataMember]
        public int? WerkgeverId { get; set; }
        [DataMember]
        public string WerkgeverNaam { get; set; }
        [DataMember]
        public int? CodeTypePolis { get; set; }
        [DataMember]
        public int? CodeDeelnameTnbp { get; set; }
        [DataMember]
        public int? CodeDeelnameWzp { get; set; }
        [DataMember]
        public int? CodeDeelnameOp { get; set; }
        [DataMember]
        public int? CodeDeelnameNbp { get; set; }
        [DataMember]
        public int? CodeDeelnameAop { get; set; }
        [DataMember]
        public float? PerunageOpbouwOp { get; set; }
        [DataMember]
        public float? BedragFranchise { get; set; }
        [DataMember]
        public int? NummerRegeling { get; set; }
        [DataMember]
        public float? PensioenGrondslag { get; set; }
        [DataMember]
        public float? JaarPremie { get; set; }
        [DataMember]
        public string Reglement { get; set; }
        [DataMember]
        public float? FactorArbeidsongeschiktheid { get; set; }
        [DataMember]
        public DateTime? DatumToetredingWao { get; set; }
        [DataMember]
        public string DeelnemerSoortNaam { get; set; }
        [DataMember]
        public List<ArbeidVast> ArbeidsgegevensVast { get; set; }
        [DataMember]
        public List<ArbeidVariabel> ArbeidsgegevensVariabel { get; set; }
        [DataMember]
        public int? UrenSalaris { get; set; }

    }

    [DataContract]
    public class ArbeidVast
    {
        public string MutatieDatum { get; set; }
        [DataMember]
        public string Werkgever { get; set; }
        [DataMember]
        public int? SalarisUren { get; set; }
        [DataMember]
        public float? MaandSalaris { get; set; }
        [DataMember]
        public float? AoGraad { get; set; }

    }

    [DataContract]
    public class ArbeidVariabel
    {
        public string MutatieDatum { get; set; }
        [DataMember]
        public string Werkgever { get; set; }
        [DataMember]
        public int? VariabeleUren { get; set; }
        [DataMember]
        public float? VariabelSalaris { get; set; }

    }
}
