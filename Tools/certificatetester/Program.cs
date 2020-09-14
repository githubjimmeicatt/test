using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace certificatetester
{
    class Program
    {
        static void Main(string[] args)
        {

            var clientCert = GetX509Certificate(StoreName.My, StoreLocation.LocalMachine, "d0b0f307eef13df6b4e91b4f140c8608d9654522", DateTime.UtcNow);

            System.Console.WriteLine(clientCert.FriendlyName);
            System.Console.ReadLine();


        }


        private static X509Certificate2 GetX509Certificate(StoreName storeName, StoreLocation storeLocation, string thumbprint  , DateTime time)
        {

            X509Certificate2 cert;

            using (var store = new X509Store(storeName, storeLocation))
            {
                store.Open(OpenFlags.OpenExistingOnly | OpenFlags.ReadOnly);

                var find = store.Certificates.Find(X509FindType.FindByThumbprint, thumbprint, true);

                var certEnum = find.OfType<X509Certificate2>();

                //Kies het langst geldige certificaat dat nu geldig is.
                cert = certEnum
                    .Where(c => c.NotBefore < time && c.NotAfter > time)
                    .OrderByDescending(c => c.NotAfter)
                    .FirstOrDefault();

                store.Close();

            }

            return cert;
        }

    }
}
