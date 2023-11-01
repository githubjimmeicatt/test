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
            const string dossierNummer = "0000307944";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);
            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi)proxy).Verzekerde(dossierNummer);
                     
            //test data is niet stabiel. daarom niet testen op de inhud van de velden
            Assert.IsNotNull(result.Id);
            Assert.IsNotNull(result.Nummer);
            Assert.IsNotNull(result.Bsn);
           
        }



        [TestMethod]
        public async Task IT_verzekerde_ophalen_obv_bsn_succes()
        {
            const string bsn = "178424912";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);
            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi)proxy).VerzekerdeByBsn(bsn);

            //test data is niet stabiel. daarom niet testen op de inhud van de velden
            Assert.IsNotNull(result.Id);
            Assert.IsNotNull(result.Nummer);
            Assert.IsNotNull(result.Bsn);

        }


        [TestMethod]
        public async Task IT_polis_ophalen_obv_bsn_succes()
        {
            const string dossierNummer = "0000307944";

            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);
            proxy.OnAuthenticate += (portaalContext, input) => true;
            proxy.OnAuthorize += (portaalContext, input) => true;

            var result = await ((IDeelnemerPortalApi)proxy).Polissen(dossierNummer);

            //test data is niet stabiel. daarom niet testen op de inhud van de velden
            Assert.IsNotNull( result[0]);
            

        }

        [TestMethod]
        public async Task IT_documenten_ophalen_obv_dossiernr_succes()
        {
            const string dossierNummer = "0000307944";

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

        //[TestMethod]
        //[ExpectedException(typeof(FaultException), "Leeg dossiernr moet fout gaan")]
        //public async Task IT_documenten_ophalen_obv_dossiernr_fail()
        //{
        //    const string dossierNummer = "";

        //    var factoryContainer = new KlantPortaalFactoryContainer();
        //    var context = new KlantPortaalContext();
        //    context.DossierNummer = dossierNummer;

        //    var proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, factoryContainer);

        //    proxy.OnAuthenticate += (portaalContext, input) => true;
        //    proxy.OnAuthorize += (portaalContext, input) => true;

        //    await ((IDeelnemerPortalApi)proxy).DocumentInfo(dossierNummer);
        //}
    }

}
