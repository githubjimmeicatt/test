using System.Linq;
using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.DeelnemerPortalApi.Interface;
using Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using Sphdhv.KlantPortaal.Common;
using System.Collections.Generic;
using ArbeidVariabel = Sphdhv.KlantPortaal.Access.Pensioen.Contract.ArbeidVariabel;
using ArbeidVast = Sphdhv.KlantPortaal.Access.Pensioen.Contract.ArbeidVast;
using Huidigepartner = Sphdhv.KlantPortaal.Access.Pensioen.Contract.Huidigepartner;
using Pensioenrecht = Sphdhv.KlantPortaal.Access.Pensioen.Contract.Pensioenrecht;
using Polis = Sphdhv.KlantPortaal.Access.Pensioen.Contract.Polis;
using Sphdhv.KlantPortaal.Data.Pensioen.DbContext;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Service
{
    public class PensioenAccess<TContext> : ServiceBase<TContext>, Interface.IPensioenAccess
        where TContext : class, IUserContext
    {
        private string _connectionStringOrName;

        public PensioenAccess(TContext context, IFactoryContainer<TContext> factoryContainer) : this(context, null, factoryContainer)
        {
        }

        public PensioenAccess(TContext context, string connectionStringOrName, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
            _connectionStringOrName = connectionStringOrName;
        }

        public async Task<ActueelPensioen> ActueelPensioenAsync()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerPortalApi>(Context);
            var tVerzekerde = proxy.Verzekerde(Context.DossierNummer);
            var tPolis = proxy.Polissen(Context.DossierNummer);
            var tPensioenrechten = proxy.Pensioenrechten(Context.DossierNummer);
            var tPensioenen = proxy.Pensioen(Context.DossierNummer);

            await Task.WhenAll(tVerzekerde, tPolis, tPensioenrechten, tPensioenen).ConfigureAwait(false);
            
            var verzekerde = tVerzekerde.Result;
            var polissen = tPolis.Result;
            var pensioenrechten = tPensioenrechten.Result;
            var pensioen = tPensioenen.Result;
            var dossierNummer = (Context as IUserContext).DossierNummer;

            //todo map polis en verzkerde to result
            var result = new ActueelPensioen();
            result.IsBlocked = IsBlocked(dossierNummer);
            result.Polissen = new List<Polis>();

            if (polissen != null && polissen.Count > 0)
            {
                foreach (var polis in polissen)
                {
                    var item = new Polis()
                    {
                        DossierId = polis.DossierId,
                        Nummer = polis.Nummer,
                        CodeBasisReglement = polis.CodeBasisReglement,
                        StatusPolis = polis.StatusPolis,
                        StatusPolisNaam = polis.StatusPolisNaam,
                        SalarisPensioen = polis.SalarisPensioen,
                        SalarisPensioenPeriode = polis.SalarisPensioenPeriode,
                        PremieGrondslag = polis.PremieGrondslag,
                        PremieGrondslagBerekening = polis.PremieGrondslagBerekening,
                        PensioenGrondslag01 = polis.PensioenGrondslag01,
                        LeeftijdPensioenOp = polis.LeeftijdPensioenOp,
                        LeeftijdExpiratieOp = polis.LeeftijdExpiratieOp,
                        LeeftijdEindeOpbouwOp = polis.LeeftijdEindeOpbouwOp,
                        LeeftijdAanvangOpbouwOp = polis.LeeftijdAanvangOpbouwOp,
                        JaarwerkRegeling = polis.JaarwerkRegeling,
                        FactorPartimeGemiddeldBereikbaar = polis.FactorPartimeGemiddeldBereikbaar,
                        FactorPartimeHuidig = polis.FactorPartimeHuidig,
                        DienstjarenToekomstigOngewogen = polis.DienstjarenToekomstigOngewogen,
                        DatumPensioen = polis.DatumPensioen,
                        DatumRichtPensioenOp = polis.DatumRichtPensioenOp,
                        DatumInDienst = polis.DatumInDienst,
                        DatumUitDienst = polis.DatumUitDienst,
                        DatumExpiratieTnbp = polis.DatumExpiratieTnbp,
                        DatumExpiratieAop = polis.DatumExpiratieAop,
                        DatumEindeOpbouwOp = polis.DatumEindeOpbouwOp,
                        DatumAanvangPolis = polis.DatumAanvangPolis,
                        WerkgeverId = polis.WerkgeverId,
                        WerkgeverNaam = polis.WerkgeverNaam,
                        CodeTypePolis = polis.CodeTypePolis,
                        CodeDeelnameTnbp = polis.CodeDeelnameTnbp,
                        CodeDeelnameWzp = polis.CodeDeelnameWzp,
                        CodeDeelnameOp = polis.CodeDeelnameOp,
                        CodeDeelnameNbp = polis.CodeDeelnameNbp,
                        CodeDeelnameAop = polis.CodeDeelnameAop,
                        PerunageOpbouwOp = polis.PerunageOpbouwOp,
                        BedragFranchise = polis.BedragFranchise,
                        NummerRegeling = polis.NummerRegeling,
                        PensioenGrondslag = polis.PensioenGrondslag,
                        JaarPremie = polis.JaarPremie,
                        Reglement = polis.Reglement,
                        FactorArbeidsongeschiktheid = polis.FactorArbeidsongeschiktheid,
                        DatumToetredingWao = polis.DatumToetredingWao,
                        DeelnemerSoortNaam = polis.DeelnemerSoortNaam,
                        UrenSalaris = polis.UrenSalaris,
                        Pensioenrechten = new List<Pensioenrecht>()
                    };
                    if (polis.ArbeidsgegevensVast != null)
                    {
                        item.ArbeidsgegevensVast = new List<ArbeidVast>();
                        polis.ArbeidsgegevensVast.ToList().ForEach(p => item.ArbeidsgegevensVast.Add(new ArbeidVast()
                        {
                            AoGraad = p.AoGraad,
                            MaandSalaris = p.MaandSalaris,
                            MutatieDatum = p.MutatieDatum,
                            SalarisUren = p.SalarisUren,
                            Werkgever = p.Werkgever
                        }));
                    }

                    if (polis.ArbeidsgegevensVariabel != null)
                    {
                        item.ArbeidsgegevensVariabel = new List<ArbeidVariabel>();
                        polis.ArbeidsgegevensVariabel.ToList().ForEach(p => item.ArbeidsgegevensVariabel.Add(new ArbeidVariabel()
                        {
                            MutatieDatum = p.MutatieDatum,
                            VariabeleUren = p.VariabeleUren,
                            VariabelSalaris = p.VariabelSalaris,
                            Werkgever = p.Werkgever
                        }));
                    }

                    result.Polissen.Add(item);
                }
            }

            if (verzekerde != null)
            {
                result.DeelnemerProfiel = new DeelnemerProfiel()
                {
                    AchternaamVolledig = verzekerde.AchternaamVolledig,
                    Afdeling = verzekerde.Afdeling,
                    Bsn = verzekerde.Bsn,
                    Burgerlijkestaat = verzekerde.Burgerlijkestaat,
                    CrmId = verzekerde.CrmId,
                    DatumGeboorte = verzekerde.DatumGeboorte,
                    DatumOpnameFonds = verzekerde.DatumOpnameFonds,
                    DatumOverlijden = verzekerde.DatumOverlijden,
                    Fonds = verzekerde.Fonds,
                    Geboortenaam = verzekerde.Geboortenaam,
                    Geslacht = verzekerde.Geslacht,
                    Id = verzekerde.Id,
                    IdentificatieVerzekerde = verzekerde.IdentificatieVerzekerde,
                    IsActief = verzekerde.IsActief,
                    Naam = verzekerde.Naam,
                    Nummer = verzekerde.Nummer,
                    PostSelectie = verzekerde.PostSelectie,
                    StatusVerzekerde = verzekerde.StatusVerzekerde,
                    Tussenvoegsels = verzekerde.Tussenvoegsels,
                    Uitzondering = verzekerde.Uitzondering,
                    Voorletters = verzekerde.Voorletters
                };

                if (verzekerde.Bereikbaarheden != null)
                {
                    result.DeelnemerProfiel.Bereikbaarheden = new List<Bereikbaarheid>();
                    verzekerde.Bereikbaarheden.ToList().ForEach(v => result.DeelnemerProfiel.Bereikbaarheden.Add(
                        new Bereikbaarheid()
                        {
                            CrmId = v.CrmId,
                            Type = v.Type,
                            Waarde = v.Waarde
                        }));
                }

                if (verzekerde.Adressen != null)
                {
                    result.DeelnemerProfiel.Adressen = new List<Adres>();
                    verzekerde.Adressen.ToList().ForEach(a => result.DeelnemerProfiel.Adressen.Add(
                        new Adres()
                        {
                            CrmId = a.CrmId,
                            Huisnummer = a.Huisnummer,
                            HuisnummerToevoeging = a.HuisnummerToevoeging,
                            HuisnummerSamengesteld = a.HuisnummerSamengesteld,
                            Land = a.Land,
                            Land2 = a.Land2,
                            Plaats = a.Plaats,
                            Postcode = a.Postcode,
                            Straat = a.Straat,
                            Straat2 = a.Straat2,
                            TypeAdres = a.TypeAdres
                        }));
                }

                if (verzekerde.HuidigePartner != null)
                {
                    result.DeelnemerProfiel.HuidigePartner = new Huidigepartner()
                    {
                        DossierId = verzekerde.HuidigePartner.DossierId,
                        Nummer = verzekerde.HuidigePartner.Nummer,
                        NaamVolledig = verzekerde.HuidigePartner.NaamVolledig,
                        Geslacht = verzekerde.HuidigePartner.Geslacht,
                        DatumGeboorte = verzekerde.HuidigePartner.DatumGeboorte,
                        DatumHuwelijk = verzekerde.HuidigePartner.DatumHuwelijk,
                        DatumPartnerschap = verzekerde.HuidigePartner.DatumPartnerschap,
                        DatumSamenwonen = verzekerde.HuidigePartner.DatumSamenwonen,
                        Status = verzekerde.HuidigePartner.Status,
                        StatusOmschrijving = verzekerde.HuidigePartner.StatusOmschrijving

                    };
                }
            }
            if (pensioen != null)
            {
                result.Pensioen = new Contract.Pensioen
                {
                    BereikbaarTop = pensioen.BereikbaarTop,
                    OpgebouwdNbp = pensioen.OpgebouwdNbp,
                    IngegaanOp = pensioen.IngegaanOp,
                    IngegaanAow = pensioen.IngegaanAow,
                    IngegaanTop = pensioen.IngegaanTop,
                    OpgebouwdTop = pensioen.OpgebouwdTop,
                    OpgebouwdWzp = pensioen.OpgebouwdWzp,
                    IngegaanNbp = pensioen.IngegaanNbp,
                    OpgebouwdOp = pensioen.OpgebouwdOp,
                    BereikbaarNbp = pensioen.BereikbaarNbp,
                    BereikbaarOp = pensioen.BereikbaarOp,
                    BereikbaarWzp = pensioen.BereikbaarWzp,
                    IngegaanTop2 = pensioen.IngegaanTop2,
                    OpgebouwdTop2 = pensioen.OpgebouwdTop,
                    ExpiratieTop2Datum = pensioen.ExpiratieTop2Datum,
                    ExpiratieTopDatum = pensioen.ExpiratieTopDatum,
                    PensioenDatum = pensioen.PensioenDatum,
                    BereikbaarTop2 = pensioen.BereikbaarTop,
                    StandDatum = pensioen.StandDatum
                };
            }

            if (pensioenrechten != null)
            {
                pensioenrechten.ForEach(p => result.Polissen.SingleOrDefault(x => x.Nummer == p.NummerPolis)?.Pensioenrechten?.Add(new Pensioenrecht
                {
                    StatusPolis = p.StatusPolis,
                    Code = p.Code,
                    DatumExpiratie = p.DatumExpiratie,
                    DatumStart = p.DatumStart,
                    NummerKind = p.NummerKind,
                    NummerPartner = p.NummerPartner,
                    NummerPolis = p.NummerPolis,
                    Soort = p.Soort,
                    StatusPolisOmschrijving = p.StatusPolisOmschrijving,
                    StatusRecht = p.StatusRecht,
                    StatusRechtOmschrijving = p.StatusRechtOmschrijving,
                    Waarde = p.Waarde
                }));
            }
            //result.Pensioen = new Contract.Pensioen();

            return result;

        }

        public async Task<DeelnemerProfiel> DeelnemerProfiel()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerPortalApi>(Context);

            var t = string.IsNullOrEmpty(Context.DossierNummer) ? proxy.VerzekerdeByBsn(Context.Bsn) : proxy.Verzekerde(Context.DossierNummer);

            var result = new DeelnemerProfiel();

            var verzekerde = await t;

            if (verzekerde == null)
                return null;

            result.AchternaamVolledig = verzekerde.AchternaamVolledig;
            result.Afdeling = verzekerde.Afdeling;
            result.Bsn = verzekerde.Bsn;
            result.Burgerlijkestaat = verzekerde.Burgerlijkestaat;
            result.CrmId = verzekerde.CrmId;
            result.DatumGeboorte = verzekerde.DatumGeboorte;
            result.DatumOpnameFonds = verzekerde.DatumOpnameFonds;
            result.DatumOverlijden = verzekerde.DatumOverlijden;
            result.Fonds = verzekerde.Fonds;
            result.Geboortenaam = verzekerde.Geboortenaam;
            result.Geslacht = verzekerde.Geslacht;
            result.Id = verzekerde.Id;
            result.IdentificatieVerzekerde = verzekerde.IdentificatieVerzekerde;
            result.IsActief = verzekerde.IsActief;
            result.Naam = verzekerde.Naam;
            result.Nummer = verzekerde.Nummer;
            result.PostSelectie = verzekerde.PostSelectie;
            result.StatusVerzekerde = verzekerde.StatusVerzekerde;
            result.Tussenvoegsels = verzekerde.Tussenvoegsels;
            result.Uitzondering = verzekerde.Uitzondering;
            result.Voorletters = verzekerde.Voorletters;

            if (verzekerde.Bereikbaarheden != null)
            {
                result.Bereikbaarheden = new List<Bereikbaarheid>();
                verzekerde.Bereikbaarheden.ToList().ForEach(v => result.Bereikbaarheden.Add(
                    new Bereikbaarheid()
                    {
                        CrmId = v.CrmId,
                        Type = v.Type,
                        Waarde = v.Waarde
                    }));
            }

            if (verzekerde.Adressen != null)
            {
                result.Adressen = new List<Adres>();
                verzekerde.Adressen.ToList().ForEach(a => result.Adressen.Add(
                    new Adres()
                    {
                        CrmId = a.CrmId,
                        Huisnummer = a.Huisnummer,
                        HuisnummerToevoeging = a.HuisnummerToevoeging,
                        HuisnummerSamengesteld = a.HuisnummerSamengesteld,
                        Land = a.Land,
                        Land2 = a.Land2,
                        Plaats = a.Plaats,
                        Postcode = a.Postcode,
                        Straat = a.Straat,
                        Straat2 = a.Straat2,
                        TypeAdres = a.TypeAdres
                    }));
            }

            if (verzekerde.HuidigePartner != null)
            {
                result.HuidigePartner = new Huidigepartner()
                {
                    DossierId = verzekerde.HuidigePartner.DossierId,
                    Nummer = verzekerde.HuidigePartner.Nummer,
                    NaamVolledig = verzekerde.HuidigePartner.NaamVolledig,
                    Geslacht = verzekerde.HuidigePartner.Geslacht,
                    DatumGeboorte = verzekerde.HuidigePartner.DatumGeboorte,
                    DatumHuwelijk = verzekerde.HuidigePartner.DatumHuwelijk,
                    DatumPartnerschap = verzekerde.HuidigePartner.DatumPartnerschap,
                    DatumSamenwonen = verzekerde.HuidigePartner.DatumSamenwonen,
                    Status = verzekerde.HuidigePartner.Status,
                    StatusOmschrijving = verzekerde.HuidigePartner.StatusOmschrijving

                };
            }


            return result;
        }


        public async Task<bool> VerifyDossierNr()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerPortalApi>(Context);

            var verzekerde = await proxy.Verzekerde(Context.DossierNummer);

            return verzekerde != null;
        }

        private bool IsBlocked(string dossierNummer)
        {
            using (var context = new PensioenDbContext(_connectionStringOrName))
            {
                var dossier = context.Dossiers.FirstOrDefault(d => d.Nummer == dossierNummer);
                return (null != dossier) ? dossier.Blocked : false;
            }
        }
    }
}
