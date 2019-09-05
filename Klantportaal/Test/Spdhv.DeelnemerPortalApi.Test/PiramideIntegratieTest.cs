using System;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.DeelnemerPortalApi.Interface;
using Sphdhv.DeelnemerPortalApi.Proxy;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Sphdhv.Test.DeelnemerPortalApi.Proxy
{
    [TestClass]
    public class PiramideIntegratieTest
    {
        [TestMethod]
        public async Task IT_verzekerde_ophalen_obv_dossienr_succes()
        {
            const string dossierNummer = "0000307943";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);
            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi)proxy).Verzekerde(dossierNummer);

            Assert.AreEqual("FjpERROq", result.AchternaamVolledig);
            Assert.AreEqual(null, result.Afdeling);
            Assert.AreEqual("0000307943", result.Id);
            Assert.AreEqual(null, result.IdentificatieVerzekerde);
            Assert.AreEqual(true, result.IsActief);
            Assert.AreEqual("QKMMifNrVE fjpERROq", result.Naam);
            Assert.AreEqual(237648829, result.Bsn);
            Assert.AreEqual("0000307943", result.Nummer);
            Assert.AreEqual("DL0000307943", result.CrmId);
            Assert.AreEqual(new DateTime(1981, 5, 15), result.DatumGeboorte);
            Assert.AreEqual(null, result.DatumOpnameFonds);
            Assert.AreEqual(null, result.DatumOverlijden);
            Assert.AreEqual(null, result.PostSelectie);
            Assert.AreEqual("Actief", result.StatusVerzekerde);
            Assert.AreEqual("", result.Tussenvoegsels);
            Assert.AreEqual("Man", result.Geslacht);
            Assert.AreEqual(null, result.Uitzondering);
            Assert.AreEqual("QKMMifNrVE", result.Voorletters);
            Assert.AreEqual(0, result.Bereikbaarheden.Length);
            Assert.AreEqual(0, result.Bereikbaarheden.Length);
            Assert.AreEqual(null, result.HuidigePartner);

        }



        [TestMethod]
        public async Task IT_verzekerde_ophalen_obv_bsn_succes()
        {
            const string bsn = "237648829";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);
            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi)proxy).VerzekerdeByBsn(bsn);

            Assert.AreEqual("FjpERROq", result.AchternaamVolledig);
            Assert.AreEqual(null, result.Afdeling);
            Assert.AreEqual("0000307943", result.Id);
            Assert.AreEqual(null, result.IdentificatieVerzekerde);
            Assert.AreEqual(true, result.IsActief);
            Assert.AreEqual("QKMMifNrVE fjpERROq", result.Naam);
            Assert.AreEqual(237648829, result.Bsn);
            Assert.AreEqual("0000307943", result.Nummer);
            Assert.AreEqual("DL0000307943", result.CrmId);
            Assert.AreEqual(new DateTime(1981, 5, 15), result.DatumGeboorte);
            Assert.AreEqual(null, result.DatumOpnameFonds);
            Assert.AreEqual(null, result.DatumOverlijden);
            Assert.AreEqual(null, result.PostSelectie);
            Assert.AreEqual("Actief", result.StatusVerzekerde);
            Assert.AreEqual("", result.Tussenvoegsels);
            Assert.AreEqual("Man", result.Geslacht);
            Assert.AreEqual(null, result.Uitzondering);
            Assert.AreEqual("QKMMifNrVE", result.Voorletters);
            Assert.AreEqual(0, result.Bereikbaarheden.Length);
            Assert.AreEqual(0, result.Bereikbaarheden.Length);
            Assert.AreEqual(null, result.HuidigePartner);

        }


        [TestMethod]
        public async Task IT_polis_ophalen_obv_bsn_succes()
        {
            const string dossierNummer = "0000307943";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);
            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi) proxy).Polissen(dossierNummer);

            Assert.AreEqual(0, result[0].ArbeidsgegevensVariabel.Count);
            Assert.AreEqual(0, result[0].ArbeidsgegevensVast.Count);
            Assert.AreEqual(13449, result[0].BedragFranchise);
            Assert.AreEqual(470028, result[0].CodeBasisReglement);
            Assert.AreEqual(null, result[0].CodeDeelnameAop);
            Assert.AreEqual(1, result[0].CodeDeelnameNbp);
            Assert.AreEqual(1, result[0].CodeDeelnameOp);
            Assert.AreEqual(1, result[0].CodeDeelnameTnbp);
            Assert.AreEqual(1, result[0].CodeDeelnameWzp);
            Assert.AreEqual(0, result[0].CodeTypePolis);
            Assert.AreEqual(new DateTime(2015, 1, 1), result[0].DatumAanvangPolis);
            Assert.AreEqual(null, result[0].DatumEindeOpbouwOp);
            Assert.AreEqual(null, result[0].DatumExpiratieAop);
            Assert.AreEqual(null, result[0].DatumExpiratieTnbp);
            Assert.AreEqual(new DateTime(2015, 1, 1),  result[0].DatumInDienst);
            Assert.AreEqual(new DateTime(2048, 5, 15) , result[0].DatumPensioen);
            Assert.AreEqual(null, result[0].DatumRichtPensioenOp);
            Assert.AreEqual(null, result[0].DatumToetredingWao);
            Assert.AreEqual(null  ,result[0].DatumUitDienst);
            Assert.AreEqual(null, result[0].DeelnemerSoortNaam);
            Assert.AreEqual(0, result[0].DienstjarenToekomstigOngewogen);
            Assert.AreEqual("0000307943", result[0].DossierId);
            Assert.AreEqual(null, result[0].FactorArbeidsongeschiktheid);
            Assert.AreEqual(0, result[0].FactorPartimeGemiddeldBereikbaar);
            Assert.AreEqual(0, result[0].FactorPartimeHuidig);
            Assert.AreEqual(null, result[0].JaarPremie);
            Assert.AreEqual(0, result[0].JaarwerkRegeling);
            Assert.AreEqual(null, result[0].LeeftijdAanvangOpbouwOp);
            Assert.AreEqual(null, result[0].LeeftijdEindeOpbouwOp);
            Assert.AreEqual(null, result[0].LeeftijdExpiratieOp);
            Assert.AreEqual(null, result[0].LeeftijdPensioenOp);
            Assert.AreEqual(2, result[0].Nummer);
            Assert.AreEqual(1, result[0].NummerRegeling);
            Assert.AreEqual(null, result[0].PensioenGrondslag);
            Assert.AreEqual(null, result[0].PensioenGrondslag01);
            Assert.AreEqual(null, result[0].PerunageOpbouwOp);
            Assert.AreEqual(null, result[0].PremieGrondslag);
            Assert.AreEqual(null, result[0].PremieGrondslagBerekening);
            Assert.AreEqual("DHV 2015 - PlsRgl", result[0].Reglement);
            Assert.AreEqual(12960, result[0].SalarisPensioen);
            Assert.AreEqual(1000, result[0].SalarisPensioenPeriode);
            Assert.AreEqual(1, result[0].StatusPolis);
            Assert.AreEqual("Aktief", result[0].StatusPolisNaam);
            Assert.AreEqual(null, result[0].UrenSalaris);
            Assert.AreEqual(33, result[0].WerkgeverId);
            Assert.AreEqual("HaskoningDHV Nederland B.V. (RH)", result[0].WerkgeverNaam);
            
        }

        [TestMethod]
        public async Task IT_documenten_ophalen_obv_dossiernr_succes()
        {
            const string dossierNummer = "0000307943";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();
            context.DossierNummer = dossierNummer;

            //var proxy = new DeelnemerPortalApiStub<KlantPortaalContext>(context, factoryContainer);
            //proxy.StubManager.DataCollection.AddDocument(dossierNummer);
            //proxy.StubManager.DataCollection.AddDocumentInfo(dossierNummer);
            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);

            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi)proxy).DocumentInfo(dossierNummer);

            foreach (var docInfo in result)
            {
                Assert.IsNotNull(docInfo.DocumentNaam);
                Assert.IsNotNull(docInfo.DossierGuid);
                Assert.IsNotNull(docInfo.DocumentId);

                var result2 = await ((IDeelnemerPortalApi)proxy).Document(docInfo.DocumentId, docInfo.DossierGuid);

                Assert.IsNotNull(result2.Data);
            }

        }
    }

}
