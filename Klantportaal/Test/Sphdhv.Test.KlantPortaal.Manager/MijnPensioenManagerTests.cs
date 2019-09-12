using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Engine.Pensioen.Interface;
using Sphdhv.KlantPortaal.Engine.Pensioen.ServiceStub;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.Test.KlantPortaal.Host;
using EnginePolis = Sphdhv.KlantPortaal.Engine.Pensioen.Contract.Polis;
using ManagerPolis = Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract.Polis;
using EngineProfiel = Sphdhv.KlantPortaal.Engine.Pensioen.Contract.DeelnemerProfiel;
using ManagerProfiel = Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract.DeelnemerProfiel;
using EnginePensioen = Sphdhv.KlantPortaal.Engine.Pensioen.Contract.ActueelPensioen;
using ManagerPensioen = Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract.ActueelPensioen;
using Moq;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;
using Sphdhv.KlantPortaal.Access.Correspondentie.Contract;
using System.Threading.Tasks;

namespace Sphdhv.Test.KlantPortaal.Manager
{
    [TestClass]
    public class MijnPensioenManagerTests
    {
        [TestMethod]
        public void MijnPensioenManager_ActueelPensioen_Poco()
        {
            Assert.Inconclusive("Need to remove Icatt.Test.Stubbing for build server");
            //Calls directly into the MijnPensioenManager service class
            //The operation under test uses all stubs for its proxies
            //Use this setup to test the operation under test in isolation with:
            //- different context classes
            //- different results from the proxies it calls into
            //- must not catch exceptions thrown by callees
            //const string dossierNr = "254254";

            //var context = new KlantPortaalContext()
            //{
            //    DossierNummer = dossierNr
            //};

            //var engineStub = new PensioenEngineStub<KlantPortaalContext>(context);

            //var engineResponse = GenerateActueelPensioen(dossierNr);

            //engineStub.StubManager.DataCollection.ActueelPensioenCollection.Add(dossierNr, engineResponse);

            //var proxystubs = new Dictionary<string, Func<object>>
            //{
            //    { nameof(IPensioenEngine), () => engineStub  }
            //};

            ////Setup pensioen engine

            //var factoryContainer = new TestKlantPortaalFactoryContainer(proxystubs);

            //var service = new Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.MijnPensioenManager<KlantPortaalContext>(context, factoryContainer);

            //var task = service.ActueelPensioenAsync();

            //var result = task.Result;

            //AssertAreEqual(engineResponse, result);

        }

        private void AssertAreEqual(EnginePensioen engineResponse, ManagerPensioen result)
        {
            AssertAreEqual(engineResponse.Polissen[0], result.Polissen[0]);
            AssertAreEqual(engineResponse.DeelnemerProfiel, result.DeelnemerProfiel);

        }

        private void AssertAreEqual(EngineProfiel engineProfiel, ManagerProfiel managerProfiel)
        {
            Assert.AreEqual(engineProfiel.Bsn, managerProfiel.Bsn);
            Assert.AreEqual(engineProfiel.Nummer, managerProfiel.Nummer);
            Assert.AreEqual(engineProfiel.AchternaamVolledig, managerProfiel.AchternaamVolledig);
            Assert.AreEqual(engineProfiel.Adressen, managerProfiel.Adressen);
            Assert.AreEqual(engineProfiel.Afdeling, managerProfiel.Afdeling);
            Assert.AreEqual(engineProfiel.Bereikbaarheden, managerProfiel.Bereikbaarheden);
            Assert.AreEqual(engineProfiel.Burgerlijkestaat, managerProfiel.Burgerlijkestaat);
            Assert.AreEqual(engineProfiel.CrmId, managerProfiel.CrmId);
            Assert.AreEqual(engineProfiel.DatumGeboorte, managerProfiel.DatumGeboorte);
            Assert.AreEqual(engineProfiel.DatumOpnameFonds, managerProfiel.DatumOpnameFonds);
            Assert.AreEqual(engineProfiel.DatumOverlijden, managerProfiel.DatumOverlijden);
            Assert.AreEqual(engineProfiel.Fonds, managerProfiel.Fonds);
            Assert.AreEqual(engineProfiel.Geboortenaam, managerProfiel.Geboortenaam);
            Assert.AreEqual(engineProfiel.Geslacht, managerProfiel.Geslacht);
            Assert.AreEqual(engineProfiel.HuidigePartner, managerProfiel.HuidigePartner);
            Assert.AreEqual(engineProfiel.Id, managerProfiel.Id);
            Assert.AreEqual(engineProfiel.IdentificatieVerzekerde, managerProfiel.IdentificatieVerzekerde);
            Assert.AreEqual(engineProfiel.IsActief, managerProfiel.IsActief);
            Assert.AreEqual(engineProfiel.Naam, managerProfiel.Naam);
            Assert.AreEqual(engineProfiel.PostSelectie, managerProfiel.PostSelectie);
            Assert.AreEqual(engineProfiel.StatusVerzekerde, managerProfiel.StatusVerzekerde);
            Assert.AreEqual(engineProfiel.Tussenvoegsels, managerProfiel.Tussenvoegsels);
            Assert.AreEqual(engineProfiel.Uitzondering, managerProfiel.Uitzondering);
            Assert.AreEqual(engineProfiel.Voorletters, managerProfiel.Voorletters);
        }

        private void AssertAreEqual(EnginePolis enginePolis, ManagerPolis managerPolis)
        {
            Assert.AreEqual(enginePolis.DossierId, managerPolis.DossierId);
            Assert.AreEqual(enginePolis.ArbeidsgegevensVariabel, managerPolis.ArbeidsgegevensVariabel);
            Assert.AreEqual(enginePolis.ArbeidsgegevensVast, managerPolis.ArbeidsgegevensVast);
            Assert.AreEqual(enginePolis.BedragFranchise, managerPolis.BedragFranchise);
            Assert.AreEqual(enginePolis.CodeBasisReglement, managerPolis.CodeBasisReglement);
            Assert.AreEqual(enginePolis.CodeDeelnameAop, managerPolis.CodeDeelnameAop);
            Assert.AreEqual(enginePolis.CodeDeelnameNbp, managerPolis.CodeDeelnameNbp);
            Assert.AreEqual(enginePolis.CodeDeelnameOp, managerPolis.CodeDeelnameOp);
            Assert.AreEqual(enginePolis.CodeDeelnameTnbp, managerPolis.CodeDeelnameTnbp);
            Assert.AreEqual(enginePolis.CodeDeelnameWzp, managerPolis.CodeDeelnameWzp);
            Assert.AreEqual(enginePolis.CodeTypePolis, managerPolis.CodeTypePolis);
            Assert.AreEqual(enginePolis.DatumAanvangPolis, managerPolis.DatumAanvangPolis);
            Assert.AreEqual(enginePolis.DatumEindeOpbouwOp, managerPolis.DatumEindeOpbouwOp);
            Assert.AreEqual(enginePolis.DatumExpiratieAop, managerPolis.DatumExpiratieAop);
            Assert.AreEqual(enginePolis.DatumExpiratieTnbp, managerPolis.DatumExpiratieTnbp);
            Assert.AreEqual(enginePolis.DatumInDienst, managerPolis.DatumInDienst);
            Assert.AreEqual(enginePolis.DatumPensioen, managerPolis.DatumPensioen);
            Assert.AreEqual(enginePolis.DatumRichtPensioenOp, managerPolis.DatumRichtPensioenOp);
            Assert.AreEqual(enginePolis.DatumToetredingWao, managerPolis.DatumToetredingWao);
            Assert.AreEqual(enginePolis.DatumUitDienst, managerPolis.DatumUitDienst);
            Assert.AreEqual(enginePolis.DeelnemerSoortNaam, managerPolis.DeelnemerSoortNaam);
            Assert.AreEqual(enginePolis.DienstjarenToekomstigOngewogen, managerPolis.DienstjarenToekomstigOngewogen);
            Assert.AreEqual(enginePolis.FactorArbeidsongeschiktheid, managerPolis.FactorArbeidsongeschiktheid);
            Assert.AreEqual(enginePolis.FactorPartimeGemiddeldBereikbaar, managerPolis.FactorPartimeGemiddeldBereikbaar);
            Assert.AreEqual(enginePolis.FactorPartimeHuidig, managerPolis.FactorPartimeHuidig);
            Assert.AreEqual(enginePolis.JaarPremie, managerPolis.JaarPremie);
            Assert.AreEqual(enginePolis.JaarwerkRegeling, managerPolis.JaarwerkRegeling);
            Assert.AreEqual(enginePolis.LeeftijdAanvangOpbouwOp, managerPolis.LeeftijdAanvangOpbouwOp);
            Assert.AreEqual(enginePolis.LeeftijdEindeOpbouwOp, managerPolis.LeeftijdEindeOpbouwOp);
            Assert.AreEqual(enginePolis.LeeftijdExpiratieOp, managerPolis.LeeftijdExpiratieOp);
            Assert.AreEqual(enginePolis.LeeftijdPensioenOp, managerPolis.LeeftijdPensioenOp);
            Assert.AreEqual(enginePolis.Nummer, managerPolis.Nummer);
            Assert.AreEqual(enginePolis.NummerRegeling, managerPolis.NummerRegeling);
            Assert.AreEqual(enginePolis.PensioenGrondslag, managerPolis.PensioenGrondslag);
            Assert.AreEqual(enginePolis.PensioenGrondslag01, managerPolis.PensioenGrondslag01);
            Assert.AreEqual(enginePolis.PerunageOpbouwOp, managerPolis.PerunageOpbouwOp);
            Assert.AreEqual(enginePolis.PremieGrondslag, managerPolis.PremieGrondslag);
            Assert.AreEqual(enginePolis.PremieGrondslagBerekening, managerPolis.PremieGrondslagBerekening);
            Assert.AreEqual(enginePolis.Reglement, managerPolis.Reglement);
            Assert.AreEqual(enginePolis.SalarisPensioen, managerPolis.SalarisPensioen);
            Assert.AreEqual(enginePolis.SalarisPensioenPeriode, managerPolis.SalarisPensioenPeriode);
            Assert.AreEqual(enginePolis.StatusPolis, managerPolis.StatusPolis);
            Assert.AreEqual(enginePolis.StatusPolisNaam, managerPolis.StatusPolisNaam);
            Assert.AreEqual(enginePolis.UrenSalaris, managerPolis.UrenSalaris);
            Assert.AreEqual(enginePolis.WerkgeverId, managerPolis.WerkgeverId);
            Assert.AreEqual(enginePolis.WerkgeverNaam, managerPolis.WerkgeverNaam);
        }

        private static EnginePensioen GenerateActueelPensioen(string dossierNr)
        {
            var engineResponse = new EnginePensioen
            {
                DeelnemerProfiel = new EngineProfiel
                {
                    Bsn = 1234987,
                    Nummer = dossierNr,
                    AchternaamVolledig = "acternaam volledig",
                    Adressen = null,
                    Afdeling = "afdeling naam",
                    Bereikbaarheden = null,
                    Burgerlijkestaat = "burgerlijke staat",
                    CrmId = "crm id",
                    DatumGeboorte = new DateTime(1963, 1, 1),
                    DatumOpnameFonds = new DateTime(2001, 4, 5),
                    DatumOverlijden = null,
                    Fonds = "fonds",
                    Geboortenaam = "geboorte naam",
                    Geslacht = "man of vrouw",
                    HuidigePartner = null,
                    Id = dossierNr,
                    IdentificatieVerzekerde = "identificatie verzekerde",
                    IsActief = true,
                    Naam = "naam",
                    PostSelectie = "post selectie",
                    StatusVerzekerde = "status verzekerde",
                    Tussenvoegsels = "tussenvoegsels",
                    Uitzondering = "uitzondering",
                    Voorletters = "vrlttrs",

                },
                Polissen = new List<EnginePolis>{
                    new EnginePolis
                    {
                        DossierId = dossierNr,
                        ArbeidsgegevensVariabel = null,
                        ArbeidsgegevensVast = null,
                        BedragFranchise = 1234,
                        CodeBasisReglement = 3,
                        CodeDeelnameAop = 4,
                        CodeDeelnameNbp = 5,
                        CodeDeelnameOp = 6,
                        CodeDeelnameTnbp = 7,
                        CodeDeelnameWzp = 8,
                        CodeTypePolis = 9,
                        DatumAanvangPolis = new DateTime(2031, 12, 2),
                        DatumEindeOpbouwOp = new DateTime(2031, 12, 3),
                        DatumExpiratieAop = new DateTime(2031, 12, 1),
                        DatumExpiratieTnbp = new DateTime(2012, 11, 5),
                        DatumInDienst = new DateTime(2014, 12, 6),
                        DatumPensioen = new DateTime(2015, 5, 4),
                        DatumRichtPensioenOp = new DateTime(2036, 1, 1),
                        DatumToetredingWao = new DateTime(2037, 1, 1),
                        DatumUitDienst = new DateTime(2037, 1, 2),
                        DeelnemerSoortNaam = "deelnemer soort naam",
                        DienstjarenToekomstigOngewogen = 234.0f,
                        FactorArbeidsongeschiktheid = 1.2f,
                        FactorPartimeGemiddeldBereikbaar = 1.4f,
                        FactorPartimeHuidig = 1.6f,
                        JaarPremie = 1093.5f,
                        JaarwerkRegeling = 213,
                        LeeftijdAanvangOpbouwOp = 54,
                        LeeftijdEindeOpbouwOp = 65,
                        LeeftijdExpiratieOp = 102,
                        LeeftijdPensioenOp = 67,
                        Nummer = int.Parse(dossierNr),
                        NummerRegeling = 12653,
                        PensioenGrondslag = 230000f,
                        PensioenGrondslag01 = 23001f,
                        PerunageOpbouwOp = 120f,
                        PremieGrondslag = 14000,
                        PremieGrondslagBerekening = 15000,
                        Reglement = "regelement",
                        SalarisPensioen = 14001f,
                        SalarisPensioenPeriode = 15002f,
                        StatusPolis = 1,
                        StatusPolisNaam = "status polis naam",
                        UrenSalaris = 40,
                        WerkgeverId = 939393,
                        WerkgeverNaam = "werkgever naam"
                    },
                }
            };
            return engineResponse;
        }

        [TestMethod]
        public void MijnPensioenManager_DeelnemerProfiel_Poco()
        {
            Assert.Inconclusive("Not fully implemented yet");
            //Calls directly into the MijnPensioenManager service class
            //The operation under test uses all stubs for any services it calls
            //Use this setup to test the operation under test in isolation with:
            //- different context classes
            //- different results from the proxies it calls into
            //- must not catch exceptions thrown by callees


        }



        [TestMethod]
        public void MijnPensioenManager_As_Poco_With_Proxies_That_User_Mocks_As_Services()
        {
            //This setup tests the proxies as generated by the HostEnvironment under test
            //Use this setup to test the authenticate/autorize/preinvoke and postinvoke handling set up by the HostEnvironment in isolation
        }


        [TestMethod]
        public void MijnPensioenManagerProxy_With_Service_Mock()
        {
            //Test any proxy class specifics not covered by ProxyBase
            //The manageger service itself is mocked in this setup

        }

        [TestMethod]
        public void MijnPensioenManagerProxy_With_All_Services()
        {
            //Test a specific service optration the proxy class with the actual service
        }

        [TestMethod]
        public void HostFactory_MijnPensioenManagerProxy_With_All_Mocks()
        {
            //Tests the proxy factory:
            // - Correct authentication/autorization/preinvoke and postinvoke configuration
            // - Service itself mocked out
            // - Must use the Host proxyfactory with a Stubbed servicefactory

        }

        [TestMethod]
        public async Task UT_MijnPensioenManager_Documentenoverzicht()
        {
            var context = new KlantPortaalContext() { DossierNummer = "123123" };
            var item = new Item { Id = "1", Type = "Pensioenopgave", Titel = "testTitel", AanmaakDatum = new DateTime(2017, 1, 2), Categorie = "Pensioenopgaven" };
            var overzicht = new CorrespondentieOverzicht { Items = new List<Item> { item } };

            var proxyMocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(ICorrespondentieAccess), (ctx) => {
                    var mock = new Mock<ICorrespondentieAccess>();
                    mock.Setup(s => s.Overzicht()).ReturnsAsync(overzicht);
                    return mock.Object;
                } }
            };

            var fc = new KlantPortaalFactoryContainer(proxyMocks, null);
            var service = new Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.MijnPensioenManager<KlantPortaalContext>(context, fc);

            var result = await service.DocumentenAsync();

            Assert.AreEqual(1, result.Items.Count);
            Assert.AreEqual(item.Id, result.Items[0].Id);
            Assert.AreEqual(item.Titel, result.Items[0].Titel);
        }

        [TestMethod]
        public async Task UT_MijnPensioenManager_Documentenoverzicht_TooOld()
        {
            var context = new KlantPortaalContext() { DossierNummer = "123123" };
            var item = new Item { Id = "1", Type = ".doc", Titel = "testTitel", AanmaakDatum = new DateTime(2017, 1, 1) };
            var overzicht = new CorrespondentieOverzicht { Items = new List<Item> { item } };

            var proxyMocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(ICorrespondentieAccess), (ctx) => {
                    var mock = new Mock<ICorrespondentieAccess>();
                    mock.Setup(s => s.Overzicht()).ReturnsAsync(overzicht);
                    return mock.Object;
                } }
            };

            var fc = new KlantPortaalFactoryContainer(proxyMocks, null);
            var service = new Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.MijnPensioenManager<KlantPortaalContext>(context, fc);

            var result = await service.DocumentenAsync();

            Assert.AreEqual(0, result.Items.Count);
        }




        [TestMethod]
        public async Task UT_MijnPensioenManager_DownloadDocument()
        {
            const string dossierNr = "254254";

            var context = new KlantPortaalContext()
            {
                DossierNummer = dossierNr
            };

            var item = new Item { Id = "1", Type = ".doc", Titel = "testTitel", AanmaakDatum = new DateTime(2017,1,2) };
            var overzicht = new CorrespondentieOverzicht { Items = new List<Item> { item } };
            var doc = new Document { Properties = item };

            var proxyMocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(ICorrespondentieAccess), (ctx) => {

                    var mock = new Mock<ICorrespondentieAccess>();

                    mock.Setup(s => s.Overzicht()).ReturnsAsync(overzicht);

                    mock.Setup(s => s.CorrespondentieItem(It.IsAny<string>())).ReturnsAsync(doc);

                    return mock.Object;
                } }

            };

            var fc = new KlantPortaalFactoryContainer(proxyMocks, null);
            var service = new Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.MijnPensioenManager<KlantPortaalContext>(context, fc);


            var result = await service.DownloadDocumentAsync(item.Id);
            Assert.AreEqual(item.Titel + ".pdf", result.Filename, "Should force extension to pdf.");


        }

        [TestMethod]
        public async Task UT_MijnPensioenManager_can_not_download_other_users_document()
        {
            const string dossierNr = "254254";

            var context = new KlantPortaalContext()
            {
                DossierNummer = dossierNr
            };


            var proxyMocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(ICorrespondentieAccess), (ctx) => {

                    var mock = new Mock<ICorrespondentieAccess>();

                    mock.Setup(s => s.Overzicht()).ReturnsAsync(null);

                    mock.Setup(s => s.CorrespondentieItem(It.IsAny<string>())).ReturnsAsync(null);

                    return mock.Object;
                } }

            };

            var fc = new KlantPortaalFactoryContainer(proxyMocks, null);
            var service = new Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.MijnPensioenManager<KlantPortaalContext>(context, fc);

            var result = await service.DownloadDocumentAsync("hjkghhjghj");

            Assert.IsNull(result);


        }


        [TestMethod]
        public async Task UT_MijnPensioenManager_DownloadDocument_With_illegal_filename()
        {
            const string dossierNr = "254254";

            var context = new KlantPortaalContext()
            {
                DossierNummer = dossierNr
            };

            var item = new Item { Id = "1", Type = "1", Titel = "m<m|m*m?m\"m/m\\m>|" };
            var overzicht = new CorrespondentieOverzicht { Items = new List<Item> { item } };
            var doc = new Document { Properties = item };

            var proxyMocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(ICorrespondentieAccess), (ctx) => {

                    var mock = new Mock<ICorrespondentieAccess>();

                    mock.Setup(s => s.Overzicht()).ReturnsAsync(overzicht);

                    mock.Setup(s => s.CorrespondentieItem(It.IsAny<string>())).ReturnsAsync(doc);

                    return mock.Object;
                } }

            };

            var fc = new KlantPortaalFactoryContainer(proxyMocks, null);
            var service = new Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.MijnPensioenManager<KlantPortaalContext>(context, fc);


            var result = await service.DownloadDocumentAsync(item.Id);
            Assert.AreEqual("mmmmmmmm.pdf", result.Filename);


        }



    }

}