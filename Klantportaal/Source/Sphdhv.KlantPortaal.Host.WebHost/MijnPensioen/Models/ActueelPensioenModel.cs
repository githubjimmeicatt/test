using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models
{
    [Serializable]
    [DataContract]
    public class ActueelPensioenModel
    {
        [DataMember]
        public List<PolisModel> Polissen { get; set; }
        [DataMember]
        public PensioenModel Pensioen { get; set; }
        
        [DataMember]
        public string AchternaamVolledig { get; set; }
        [DataMember]
        public string CallChain { get; set; }
        [DataMember]
        public bool IsBlocked { get; set; }
        [DataMember]
        public bool IsActief { get; set; }
    }

    [DataContract]
    public class PensioenrechtModel
    {
        [DataMember]
        public string Code { get; set; }
        [DataMember]
        public string DatumExpiratie { get; set; }
        [DataMember]
        public string DatumStart { get; set; }
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
        public string Waarde { get; set; }
    }

    [Serializable]
    [DataContract]
    public class PolisModel
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
        public string SalarisPensioen { get; set; }
        [DataMember]
        public string SalarisPensioenPeriode { get; set; }
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
        public string FactorPartimeHuidig { get; set; }
        [DataMember]
        public float? DienstjarenToekomstigOngewogen { get; set; }
        [DataMember]
        public string DatumPensioen { get; set; }
        [DataMember]
        public string DatumRichtPensioenOp { get; set; }
        [DataMember]
        public string DatumInDienst { get; set; }
        [DataMember]
        public string DatumUitDienst { get; set; }
        [DataMember]
        public string DatumExpiratieTnbp { get; set; }
        [DataMember]
        public string DatumExpiratieAop { get; set; }
        [DataMember]
        public string DatumEindeOpbouwOp { get; set; }
        [DataMember]
        public string DatumAanvangPolis { get; set; }
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
        public string BedragFranchise { get; set; }
        [DataMember]
        public int? NummerRegeling { get; set; }
        [DataMember]
        public string PensioenGrondslag { get; set; }
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
        public ArbeidVastModel[] ArbeidsgegevensVast { get; set; }
        [DataMember]
        public ArbeidVariabelModel[] ArbeidsgegevensVariabel { get; set; }
        [DataMember]
        public int? UrenSalaris { get; set; }
        [DataMember]
        public string DatumPensioenTextFormat { get; set; }
        [DataMember]
        public string AgeOnPensioen { get; set; }
        [DataMember]
        public List<PensioenrechtModel> Pensioenrechten { get; set; }
    }

    [Serializable]
    [DataContract]
    public class ArbeidVastModel
    {
        [DataMember]
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

    [Serializable]
    [DataContract]
    public class ArbeidVariabelModel
    {
        [DataMember]
        public string MutatieDatum { get; set; }
        [DataMember]
        public string Werkgever { get; set; }
        [DataMember]
        public int? VariabeleUren { get; set; }
        [DataMember]
        public float? VariabelSalaris { get; set; }
    }

    [DataContract]
    public class PensioenModel
    {
        [DataMember]
        public string PensioenDatum { get; set; }
        [DataMember]
        public string StandDatum { get; set; }
        [DataMember]
        public string ExpiratieTopDatum { get; set; }
        [DataMember]
        public string ExpiratieTop2Datum { get; set; }
        [DataMember]
        public float? OpgebouwdOp { get; set; }
        [DataMember]
        public float? BereikbaarOp { get; set; }
        [DataMember]
        public float? IngegaanOp { get; set; }
        [DataMember]
        public float? OpgebouwdNbp { get; set; }
        [DataMember]
        public float? BereikbaarNbp { get; set; }
        [DataMember]
        public float? IngegaanNbp { get; set; }
        [DataMember]
        public float? OpgebouwdWzp { get; set; }
        [DataMember]
        public float? BereikbaarWzp { get; set; }
        [DataMember]
        public float? OpgebouwdTop { get; set; }
        [DataMember]
        public float? BereikbaarTop { get; set; }
        [DataMember]
        public float? IngegaanTop { get; set; }
        [DataMember]
        public float? OpgebouwdTop2 { get; set; }
        [DataMember]
        public float? BereikbaarTop2 { get; set; }
        [DataMember]
        public float? IngegaanTop2 { get; set; }
        [DataMember]
        public float? IngegaanAow { get; set; }
    }
}
