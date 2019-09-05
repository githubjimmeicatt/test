using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Security;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection.WebApi;
using Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi;
using System;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class MijnPensioenController : ApiController
    {

        [HttpGet]
        [CsrfProtected]
        [AuthenticationExceptionFilter]
        public async Task<ResponseModel<ActueelPensioenModel>> ActueelPensioen(string dossierNr = null)
        {

            return new ResponseModel<ActueelPensioenModel>(null);


            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            (context as IAuthenticationTicket).AuthenticationTicket = GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            //call proxy
            var proxy = factoryContainer.ProxyFactory.CreateProxy<IMijnPensioenManager>(context);

            var actueelPensioen = await proxy.ActueelPensioenAsync();

            //map result
            var model = MapToViewModel(actueelPensioen, context);

            return new ResponseModel<ActueelPensioenModel>(model);

        }

        [HttpGet]
        [CsrfProtected]
        [AuthenticationExceptionFilter]
        public async Task<ResponseModel<ProfielModel>> Profiel(string dossierNr = null)
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            (context as IAuthenticationTicket).AuthenticationTicket = GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            //call proxy
            var proxy = factoryContainer.ProxyFactory.CreateProxy<IMijnPensioenManager>(context);

            //map result
            var profiel = await proxy.DeelnemerProfielAsync();

            var model = MapToViewModel(profiel);

            return new ResponseModel<ProfielModel>(model);

        }

        internal static ActueelPensioenModel MapToViewModel(ActueelPensioen actueelPensioen, KlantPortaalContext context)
        {
            //TODO unittest mapping. But not before a production-ready mapping has been provided
            //TODO use Automapper
            var model = new ActueelPensioenModel { Polissen = new List<PolisModel>() };
            model.IsBlocked = actueelPensioen.IsBlocked;

            foreach (var polis in actueelPensioen.Polissen)
            {
                var arbeidsgegevensVast = new ArbeidVastModel[polis.ArbeidsgegevensVast.Count];
                var aarbeidVariabel = new ArbeidVariabelModel[polis.ArbeidsgegevensVariabel.Count];

                var i = 0;
                foreach (var arbeidvast in polis.ArbeidsgegevensVast)
                {
                    var vast = new ArbeidVastModel()
                    {
                        Werkgever = arbeidvast.Werkgever,
                        MaandSalaris = arbeidvast.MaandSalaris,
                        SalarisUren = arbeidvast.SalarisUren,
                        MutatieDatum = arbeidvast.MutatieDatum,
                        AoGraad = arbeidvast.AoGraad
                    };
                    arbeidsgegevensVast[i] = vast;
                    i++;
                }

                var j = 0;
                foreach (var aarbeidVar in polis.ArbeidsgegevensVariabel)
                {
                    var variable = new ArbeidVariabelModel()
                    {
                        Werkgever = aarbeidVar.Werkgever,
                        VariabelSalaris = aarbeidVar.VariabelSalaris,
                        VariabeleUren = aarbeidVar.VariabeleUren,
                        MutatieDatum = aarbeidVar.MutatieDatum
                    };
                    aarbeidVariabel[j] = variable;
                    j++;
                }

                //Get the agen on pensioen
                var dob = actueelPensioen.DeelnemerProfiel.DatumGeboorte;
                var dop = polis.DatumPensioen;

                string textAge = string.Empty;
                if (dop.HasValue)
                    textAge = CalculateYourAge(dob, dop.Value);

                var polisModel = new PolisModel()
                {
                    Nummer = polis.Nummer,
                    CodeBasisReglement = polis.CodeBasisReglement,
                    DossierId = polis.DossierId.TrimStart(new Char[] { '0' }),
                    StatusPolis = polis.StatusPolis,
                    StatusPolisNaam = polis.StatusPolisNaam,
                    SalarisPensioen = polis.SalarisPensioen?.ToString("N", CultureInfo.GetCultureInfo("nl-NL")),
                    SalarisPensioenPeriode = polis.SalarisPensioenPeriode?.ToString("N", CultureInfo.GetCultureInfo("nl-NL")),
                    PremieGrondslag = polis.PremieGrondslag,
                    PremieGrondslagBerekening = polis.PremieGrondslagBerekening,
                    PensioenGrondslag01 = polis.PensioenGrondslag01,
                    LeeftijdPensioenOp = polis.LeeftijdPensioenOp,
                    LeeftijdExpiratieOp = polis.LeeftijdExpiratieOp,
                    LeeftijdEindeOpbouwOp = polis.LeeftijdEindeOpbouwOp,
                    LeeftijdAanvangOpbouwOp = polis.LeeftijdAanvangOpbouwOp,
                    JaarwerkRegeling = polis.JaarwerkRegeling,
                    FactorPartimeGemiddeldBereikbaar = polis.FactorPartimeGemiddeldBereikbaar,
                    FactorPartimeHuidig = polis.FactorPartimeHuidig?.ToString("#,##0.##", CultureInfo.GetCultureInfo("nl-NL")),
                    DienstjarenToekomstigOngewogen = polis.DienstjarenToekomstigOngewogen,
                    DatumPensioen = polis.DatumPensioen?.ToString("dd-MM-yyyy"),
                    DatumRichtPensioenOp = polis.DatumRichtPensioenOp?.ToString("dd-MM-yyyy"),
                    DatumInDienst = polis.DatumInDienst?.ToString("dd-MM-yyyy"),
                    DatumUitDienst = polis.DatumUitDienst?.ToString("dd-MM-yyyy"),
                    DatumExpiratieTnbp = polis.DatumExpiratieTnbp?.ToString("dd-MM-yyyy"),
                    DatumExpiratieAop = polis.DatumExpiratieAop?.ToString("dd-MM-yyyy"),
                    DatumEindeOpbouwOp = polis.DatumEindeOpbouwOp?.ToString("dd-MM-yyyy"),
                    DatumAanvangPolis = polis.DatumAanvangPolis?.ToString("dd-MM-yyyy"),
                    WerkgeverId = polis.WerkgeverId,
                    WerkgeverNaam = polis.WerkgeverNaam,
                    CodeTypePolis = polis.CodeTypePolis,
                    CodeDeelnameTnbp = polis.CodeDeelnameTnbp,
                    CodeDeelnameWzp = polis.CodeDeelnameWzp,
                    CodeDeelnameOp = polis.CodeDeelnameOp,
                    CodeDeelnameNbp = polis.CodeDeelnameNbp,
                    CodeDeelnameAop = polis.CodeDeelnameAop,
                    PerunageOpbouwOp = polis.PerunageOpbouwOp,
                    BedragFranchise = polis.BedragFranchise?.ToString("N", CultureInfo.GetCultureInfo("nl-NL")),
                    NummerRegeling = polis.NummerRegeling,
                    PensioenGrondslag = polis.PensioenGrondslag?.ToString("N", CultureInfo.GetCultureInfo("nl-NL")),
                    JaarPremie = polis.JaarPremie,
                    Reglement = polis.Reglement,
                    FactorArbeidsongeschiktheid = polis.FactorArbeidsongeschiktheid,
                    DatumToetredingWao = polis.DatumToetredingWao,
                    DeelnemerSoortNaam = polis.DeelnemerSoortNaam,
                    UrenSalaris = polis.UrenSalaris,
                    ArbeidsgegevensVast = arbeidsgegevensVast,
                    ArbeidsgegevensVariabel = aarbeidVariabel,
                    DatumPensioenTextFormat = polis.DatumPensioen?.ToString("dd MMMM yyyy", new CultureInfo("nl-NL")),
                    AgeOnPensioen = textAge,
                    Pensioenrechten = new List<PensioenrechtModel>()
                };
                model.Polissen.Add(polisModel);

            }
            //map to model

            //DossierId = actueelPensioen.DossierId,
            model.AchternaamVolledig = actueelPensioen.DeelnemerProfiel.AchternaamVolledig;

            model.Pensioen = (null == actueelPensioen.Pensioen) ? new PensioenModel() : new PensioenModel
            {
                BereikbaarNbp = actueelPensioen.Pensioen.BereikbaarNbp,
                BereikbaarOp = actueelPensioen.Pensioen.BereikbaarOp,
                BereikbaarTop = actueelPensioen.Pensioen.BereikbaarTop,
                BereikbaarTop2 = actueelPensioen.Pensioen.BereikbaarTop2,
                BereikbaarWzp = actueelPensioen.Pensioen.BereikbaarWzp,
                ExpiratieTop2Datum = actueelPensioen.Pensioen.ExpiratieTop2Datum?.ToString("dd-MM-yyyy"),
                ExpiratieTopDatum = actueelPensioen.Pensioen.ExpiratieTopDatum?.ToString("dd-MM-yyyy"),
                IngegaanAow = actueelPensioen.Pensioen.IngegaanAow,
                IngegaanNbp = actueelPensioen.Pensioen.IngegaanNbp,
                IngegaanOp = actueelPensioen.Pensioen.IngegaanOp,
                IngegaanTop = actueelPensioen.Pensioen.IngegaanTop,
                IngegaanTop2 = actueelPensioen.Pensioen.IngegaanTop2,
                OpgebouwdNbp = actueelPensioen.Pensioen.OpgebouwdNbp,
                OpgebouwdOp = actueelPensioen.Pensioen.OpgebouwdOp,
                OpgebouwdTop = actueelPensioen.Pensioen.OpgebouwdTop,
                OpgebouwdTop2 = actueelPensioen.Pensioen.OpgebouwdTop2,
                OpgebouwdWzp = actueelPensioen.Pensioen.OpgebouwdWzp,
                PensioenDatum = actueelPensioen.Pensioen.PensioenDatum?.ToString("dd-MM-yyyy"),
                StandDatum = actueelPensioen.Pensioen.StandDatum?.ToString("dd-MM-yyyy"),
                
            };
            model.CallChain = context.CallChain;

            actueelPensioen.Polissen.ForEach(po => po.Pensioenrechten.ForEach(p => model.Polissen.SingleOrDefault(x => x.Nummer == po.Nummer)?.Pensioenrechten?.Add(new PensioenrechtModel
            {
                DatumStart = p.DatumStart?.ToString("dd-MM-yyyy"),
                StatusPolis = p.StatusPolis,
                NummerKind = p.NummerKind,
                Waarde = p.Waarde?.ToString("N", CultureInfo.GetCultureInfo("nl-NL")),
                NummerPolis = p.NummerPolis,
                NummerPartner = p.NummerPartner,
                StatusRecht = p.StatusRecht,
                DatumExpiratie = p.DatumExpiratie?.ToString("dd-MM-yyyy"),
                Soort = p.Soort,
                Code = p.Code,
                StatusPolisOmschrijving = p.StatusPolisOmschrijving,
                StatusRechtOmschrijving = p.StatusRechtOmschrijving
            })));
            return model;

        }

        private static ProfielModel MapToViewModel(DeelnemerProfiel profiel)
        {
            var bereikbaarheden = new List<BereikbaarheidModel>();
            var adressen = new List<AdresModel>();

            foreach (var item in profiel.Bereikbaarheden)
            {
                var bereikbaarheid = new BereikbaarheidModel()
                {
                    Type = item.Type,
                    Waarde = item.Waarde
                };
                bereikbaarheden.Add(bereikbaarheid);
            }

            foreach (var item in profiel.Adressen)
            {
                var adres = new AdresModel()
                {
                    HuisnummerSamengesteld = item.HuisnummerSamengesteld,
                    Huisnummer = item.Huisnummer,
                    HuisnummerToevoeging = item.HuisnummerToevoeging,
                };
                adressen.Add(adres);
            }
            var huidigePartner = new HuidigepartnerModel();
            if (profiel.HuidigePartner != null)
            {
                huidigePartner.Nummer = profiel.HuidigePartner.Nummer;
                huidigePartner.NaamVolledig = profiel.HuidigePartner.NaamVolledig;
                huidigePartner.Geslacht = profiel.HuidigePartner.Geslacht;
                huidigePartner.DatumGeboorte = profiel.HuidigePartner.DatumGeboorte.ToString("dd-MM-yyyy");
                huidigePartner.DatumHuwelijk = profiel.HuidigePartner.DatumHuwelijk?.ToString("dd-MM-yyyy");
                huidigePartner.DatumPartnerschap = profiel.HuidigePartner.DatumPartnerschap?.ToString("dd-MM-yyyy");
                huidigePartner.DatumSamenwonen = profiel.HuidigePartner.DatumSamenwonen?.ToString("dd-MM-yyyy");
                huidigePartner.Status = profiel.HuidigePartner.Status;
                huidigePartner.StatusOmschrijving = profiel.HuidigePartner.StatusOmschrijving;
            }

            var viewModel = new ProfielModel
            {
                AchternaamVolledig = profiel.AchternaamVolledig,
                Afdeling = profiel.Afdeling,
                Bsn = profiel.Bsn,
                Burgerlijkestaat = profiel.Burgerlijkestaat,
                CrmId = profiel.CrmId,
                DatumGeboorte = profiel.DatumGeboorte.ToString("dd-MM-yyyy"),
                DatumOpnameFonds = profiel.DatumOpnameFonds?.ToString("dd-MM-yyyy"),
                DatumOverlijden = profiel.DatumOverlijden?.ToString("dd-MM-yyyy"),
                Fonds = profiel.Fonds,
                Geboortenaam = profiel.Geboortenaam,
                Geslacht = profiel.Geslacht,
                Id = profiel.Id,
                IdentificatieVerzekerde = profiel.IdentificatieVerzekerde,
                IsActief = profiel.IsActief,
                Naam = profiel.Naam,
                Nummer = profiel.Nummer,
                PostSelectie = profiel.PostSelectie,
                StatusVerzekerde = profiel.StatusVerzekerde,
                Tussenvoegsels = profiel.Tussenvoegsels,
                Uitzondering = profiel.Uitzondering,
                Voorletters = profiel.Voorletters,
                Bereikbaarheden = bereikbaarheden,
                Adressen = adressen,
                HuidigePartner = huidigePartner
            };
            return viewModel;
        }

        private static string GetCookie(HttpRequestMessage request, string key)
        {

            var authCookie = request.Headers.GetCookies(key).FirstOrDefault();
            if (authCookie == null)
                return null;

            return authCookie[key].Value;
        }

        /// <summary>  
        /// For calculating age  
        /// </summary>  
        /// <param name="Dob">Enter Date of Birth to Calculate the age</param>  
        /// <returns> years, months,days, hours...</returns>  
        public static string CalculateYourAge(DateTime Dob, DateTime DoP)
        {
            DateTime Now = DateTime.Now;
            int Years = new DateTime(DoP.Subtract(Dob).Ticks).Year - 1;
            DateTime PastYearDate = Dob.AddYears(Years);
            int Months = 0;
            for (int i = 1; i <= 12; i++)
            {
                if (PastYearDate.AddMonths(i) == DoP)
                {
                    Months = i;
                    break;
                }
                else if (PastYearDate.AddMonths(i) >= DoP)
                {
                    Months = i - 1;
                    break;
                }
            }
            int Days = DoP.Subtract(PastYearDate.AddMonths(Months)).Days;
            if(Days > 0)
                return String.Format("{0} jaar en {1} maanden", Years, Months);

            return String.Format("{0} jaar", Years);
        }
    }
}
