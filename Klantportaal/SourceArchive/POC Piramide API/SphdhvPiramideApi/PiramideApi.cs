using System;
using System.Net;
using System.Net.Http;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace SphdhvPiramideApi
{
    public class PiramideApi
    {
        public async Task<T> GetRequestAsync<T>(Uri url)
        {
            var cert = GetX509Certificate();

            using (var handler = new WebRequestHandler())
            {
                handler.ClientCertificates.Add(cert);

                using (var client = new HttpClient(handler))
                {
                    var result = await client.GetAsync(url);
                    var test = await result.Content.ReadAsStringAsync();
                    var serialized = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(test);
                    return serialized;
                }
            }
        }


        public async Task<HttpStatusCode> GetFailedRequestAsync(Uri url)
        {
            var cert = GetX509Certificate();

            using (var handler = new WebRequestHandler())
            {
                handler.ClientCertificates.Add(cert);
                using (var client = new HttpClient(handler))
                {
                    var result = await client.GetAsync(url);
                    return result.StatusCode;
                }
            }
        }

        private static X509Certificate GetX509Certificate()
        {
            X509Store store = null;
            X509Certificate cert;
            try
            {
                store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                store.Open(OpenFlags.OpenExistingOnly | OpenFlags.ReadOnly);
                var find = store.Certificates.Find(X509FindType.FindBySubjectName, "DHVapi-a Authentication", false);  

                //var find = store.Certificates.Find(X509FindType.FindByThumbprint, "f3 5a 80 6f d3 08 93 24 d7 67 31 7e 94 fb 69 29 10 0c 12 f3", false);
                if (find.Count == 1)
                {
                    cert = find[0];
                }
                else
                {
                    throw new Exception("Geen certificate gevonden ");
                }

            }
            finally
            {
                store?.Close();
            }
            return cert;
        }
    }
}
