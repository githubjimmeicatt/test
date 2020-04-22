using KlantportaalReEncryptor.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace KlantportaalReEncryptor
{
    class Program
    {
        static void Main(string[] args)
        {

            string certificateThumb = null;

            //dev: Data Source=OTA-DB.ICATT.LOCAL;Initial Catalog=HaskoningDHV.Klantportaal.DEV.AspNetMembership;User ID=HaskoningDHV.Klantportaal.DEV.AspNetMembership;Password=dsg*9hsdKJH785w3))123GbdfgdfgbnHSHDHSDFHJ345dfg345;MultipleActiveResultSets=True
            Console.WriteLine($"voer de connectiestring in van de database die je opnieuw wil versleutelen");

            string connectionstring = Console.ReadLine();

            Console.WriteLine($"zorg dat het key vault certificaat voor de omgeving die je wilt verslutelen op deze machine geinstalleerd is");
            Console.WriteLine($"welk certificaat wil je versleutelen? (o,a,p) ");

            string omgeving = Console.ReadLine();


            switch (omgeving)
            {
                case "o":
                    certificateThumb = Settings.Default.KeyVaultCertificateThumbprintOntwikkel;
                    break;
                case "a":
                    certificateThumb = Settings.Default.KeyVaultCertificateThumbprintAccept;
                    break;
                case "p":
                    certificateThumb = Settings.Default.KeyVaultCertificateThumbprintProductie;
                    break;
            }

            if (!string.IsNullOrWhiteSpace(connectionstring) && !string.IsNullOrWhiteSpace(certificateThumb))
            {
                Console.WriteLine($"weet je zeker dat je de database nu opnieuw wilt versleutelen? (j/n) ");

                var keyInfoOmgeving = Console.ReadKey();
                if (keyInfoOmgeving.KeyChar != 'j')
                {
                    return;
                }
                Console.WriteLine();


                var cert = new Cert().FindCertificateByThumbprint(certificateThumb);

                var x = new DataUpdater(connectionstring, cert);
                x.Update();

            }

        }
    }


    public class Cert
    {
        public X509Certificate2 FindCertificateByThumbprint(string findValue)
        {
            X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
            try
            {
                store.Open(OpenFlags.ReadOnly);
                X509Certificate2Collection col = store.Certificates.Find(X509FindType.FindByThumbprint, findValue, false);
                if (col == null || col.Count == 0)
                    return null;
                return col[0];
            }
            finally
            {
                store.Close();
            }
        }
    }

}
