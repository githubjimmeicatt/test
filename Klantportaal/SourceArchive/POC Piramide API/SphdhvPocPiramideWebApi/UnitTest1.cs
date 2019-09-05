using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SphdhvPiramideApi;
using SphdhvPiramideApi.Models;

namespace SphdhvPocPiramideWebApi
{
    [TestClass]
    public class IT_Piramide
    {
        private readonly List<string> _dossierNummers = new List<string>()
            {
                "0000307943","0000307944","0000307949","0000307950",
                "0000307957","0000307952","0000307959","0000307954",
                "0000307974","0000308054","0000308218","0000308204",
                "0000308219","0000308220","0000308221","0000308222"
            };

        [TestMethod]
        public async Task IT_Ping()
        {
            const string endpoint = "/api/Ping";
            var result = await GetResult<PingResponse>(endpoint);
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public async Task IT_VerzekerdeDossier()
        {
            

            foreach (var dossierNummer in _dossierNummers)
            {
                var endpoint = $"/api/verzekerden/{dossierNummer}";
                var result = await GetResult<Verzekerde>(endpoint);

                endpoint = $"/api/verzekerden/bsn/{result.Bsn}";
                result = await GetResult<Verzekerde>(endpoint);
                Assert.IsNotNull(result);
            }
        }

        [TestMethod]
        public async Task IT_PolisDossier()
        {


            foreach (var dossierNummer in _dossierNummers)
            {
                var endpoint = $"/api/polissen/{dossierNummer}";
                var result = await GetResult<DossierResponse>(endpoint);
                Assert.IsNotNull(result);
            }
        }

        [TestMethod]
        public async Task IT_PolisDossier404()
        {
            var endpoint = $"/api/polissen/geenNummer";
            var result = await GetErrorResult(endpoint);
            Assert.AreEqual(HttpStatusCode.NotFound, result);
        }

        [TestMethod]
        public async Task IT_PolisVerzekerdeDossier404()
        {
            var endpoint = $"/api/verzekerden/foutDossierNummer";
            var result = await GetErrorResult(endpoint);
            Assert.AreEqual(HttpStatusCode.NotFound, result);
        }

        [TestMethod]
        public async Task IT_PolisVerzekerdeBsn404()
        {
            var endpoint = $"/api/verzekerden/bsn/foutBsnNummer";
            var result = await GetErrorResult(endpoint);
            Assert.AreEqual(HttpStatusCode.NotFound, result);
        }

        private static async Task<T> GetResult<T>(string endpoint)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            var request = new PiramideApi();
            var url = new Uri($"https://dhvwebapi.bgstest.piramide.nl/{endpoint}");
            return await request.GetRequestAsync<T>(url);
        }

        private static async Task<HttpStatusCode> GetErrorResult(string endpoint)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            var request = new PiramideApi();
            var url = new Uri($"https://dhvwebapi.bgstest.piramide.nl/{endpoint}");
            return await request.GetFailedRequestAsync(url);
        }
    }
}
