using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography.X509Certificates;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Icatt.Infrastructure;
using Icatt.ServiceModel;
using Icatt.Time;
using Serilog;
using Sphdhv.DeelnemerPortalApi.Contract;
using Sphdhv.DeelnemerPortalApi.Interface;

namespace Sphdhv.DeelnemerPortalApi.Client
{
    public class DeelnemerPortalApiClient<TContext> : ServiceBase<TContext>, IDeelnemerPortalApi where TContext : class, IPiramideContext
    {
        private static TContext context;

        public DeelnemerPortalApiClient(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }
        async Task<List<Polis>> IDeelnemerPortalApi.Polissen(string dossierId)
        {
            var endpoint = $"api/polissen/{dossierId}";
            var result = await GetResult<List<Polis>>(endpoint);

            return await Task.FromResult(result);
        }

        async Task<Verzekerde> IDeelnemerPortalApi.Verzekerde(string dossierId)
        {

            var endpoint = $"api/verzekerden/{dossierId}";
            var result = await GetResult<Verzekerde>(endpoint);

            return await Task.FromResult(result);
        }

        async Task<Verzekerde> IDeelnemerPortalApi.VerzekerdeByBsn(string bsn)
        {
            var endpoint = $"api/verzekerden/bsn/{bsn}";
            var result = await GetResult<Verzekerde>(endpoint);

            return await Task.FromResult(result);
        }

        async Task<List<Pensioenrecht>> IDeelnemerPortalApi.Pensioenrechten(string d)
        {
            var endpoint = $"api/pensioenrechten/{d}";
            var result = await GetResult<List<Pensioenrecht>>(endpoint);

            return await Task.FromResult(result);
        }

        async Task<Pensioen> IDeelnemerPortalApi.Pensioen(string dossierNr)
        {
            var endpoint = $"api/pensioenen/{dossierNr}";
            var result = await GetResult<Pensioen>(endpoint);

            return await Task.FromResult(result);
        }

        async Task<Document> IDeelnemerPortalApi.Document(string documentId, string dossierGuid)
        {
            var endpoint = $"api/documenten?query.documentId={documentId}&query.dossierGuid={dossierGuid}";
            var result = await GetResult<Document>(endpoint);

            return await Task.FromResult(result);
        }

        async Task<List<DocumentInfo>> IDeelnemerPortalApi.DocumentInfo(string dossierGuid, string documentId = null)
        {
            var endpoint = $"api/documenten/info?query.dossierGuid={dossierGuid}";
            if (documentId != null)
            {
                endpoint += $"&query.documentId={documentId}";
            }
            var result = await GetResult<List<DocumentInfo>>(endpoint);

            return await Task.FromResult(result);
        }

        private async Task<T> GetResult<T>(string endpoint)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            var baseUrlTestData = Properties.Settings.Default.baseUrl;  //https://dhvwebapi.bgstest.piramide.nl/
            var baseUrlProdData = Properties.Settings.Default.BaseUrlPiramideAccept;  //https://dhvapi-a.iv-hosting.nl/ alleen toegangelijk vanaf cheetah
            var baseUrl = Context.ImpersonateMode ? baseUrlProdData : baseUrlTestData;

            var url = new Uri($"{baseUrl}{endpoint}");
            var time = FactoryContainer.ProxyFactory.CreateProxy<ITimeMachine>(Context);
            var cert = GetX509Certificate(time);
            var contextFactory = FactoryContainer.ProxyFactory.CreateProxy<IContextFactory>(context);
            return await GetRequestAsync<T>(url, cert, contextFactory);

        }


        private static async Task<T> GetRequestAsync<T>(Uri url, X509Certificate cert, IContextFactory context)
        {
            var logger = new Icatt.Log4Net.Log4NetLogger<ApplicationArea, LogMessage>(context);
            using (var handler = new WebRequestHandler())
            {
                handler.ClientCertificates.Add(cert);
                using (var client = new HttpClient(handler))
                {
                    var result = await client.GetAsync(url);
                    Log.Information("{0} | Status: {1}", Regex.Replace(url.AbsoluteUri, @"\d(?!\d{0,2}$)", "X"), result.StatusCode); //loggen via global static
                    //logger.Log(ApplicationArea.DeelnemerportalApiClient, Icatt.Logging.LoggingLevel.All, LogMessage.Any, "{0} | Status: {1}", Regex.Replace(url.AbsoluteUri, @"\d(?!\d{0,2}$)", "X"), result.StatusCode);


                    var data = await result.Content.ReadAsStringAsync();

                    T serialized = default(T);
                    try
                    {
                        if (result.IsSuccessStatusCode)
                        {
                            serialized = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(data);

                            if (url.AbsoluteUri.Contains("api/documenten"))
                            {
                                Log.Information("Response length: {0}", data.Length); //loggen via global static

                                //logger.Log(ApplicationArea.DeelnemerportalApiClient, Icatt.Logging.LoggingLevel.All, LogMessage.Any, "Reponse lengte: {0}", data.Length);

                            }
                        }
                        else
                        {
                            var error = Newtonsoft.Json.JsonConvert.DeserializeObject<ErrorData>(data);
                            Log.Error("{Error}", error);
                            throw new HttpRequestException(string.Format("Er is een fout opgetreden. Probeer het opnieuw of neem contact op met de klantenservice."));
                        }
                    }
                    catch (Exception e)
                    {
                        Log.Error(e,"{0} | Status: {1}", Regex.Replace(url.AbsoluteUri, @"\d(?!\d{ 0,2}$)", "X"), result.StatusCode);
                        logger.LogException(ApplicationArea.DeelnemerportalApiClient, e);
                        if (e is HttpRequestException)
                        {
                            throw;
                        }
                    }

                    return serialized;
                }
            }
        }


        private X509Certificate GetX509Certificate(ITimeMachine time)
        {

            string certificateSubjectTestData = Properties.Settings.Default.CertificateSubject;
            string certificateSubjectProdData = Properties.Settings.Default.CertificateSubjectPiramideAccept;

            string certificateSubject = Context.ImpersonateMode ? certificateSubjectProdData : certificateSubjectTestData;

            X509Store store = null;
            X509Certificate cert;
            try
            {
                store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                store.Open(OpenFlags.OpenExistingOnly | OpenFlags.ReadOnly);

                var find = store.Certificates.Find(X509FindType.FindBySubjectName, certificateSubject, Properties.Settings.Default.CertificateMustBeValid); //CBA Client Authentication
                cert = find.OfType<X509Certificate2>()
                    .Where(c => c.NotBefore <= time.UtcNow && c.NotAfter >= time.UtcNow)
                    .OrderByDescending(c => c.NotBefore) //Meest recent geldig geworden
                    .FirstOrDefault();
            }
            finally
            {
                store?.Close();
            }
            return cert;
        }


    }
    public enum ApplicationArea
    {
        DeelnemerportalApiClient
    }
    public enum LogMessage
    {
        Any
    }
}
