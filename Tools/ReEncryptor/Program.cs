using Icatt.Logging.DataAccess;
using ReEncryptor.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace ReEncryptor
{


    /// <summary>
    /// fetches all encrypted records
    /// decrypts with old key
    /// encrypts with new key
    /// stores values back in database
    /// start de applicatie en volg de instructies op het scherm
    /// voorwaarden:
    /// - het certificaat voor toegang tot de juiste store moet op de machine waarop dit uitgevoerd wordt aanwezig zijn
    /// - je moet de connectionstring van de database bij de hand hebben
    /// </summary>
    class Program
    {


        static void Main(string[] args)
        {
            string certificateThumb = null;

            //dev: Data Source=OTA-DB.ICATT.LOCAL;Initial Catalog=SPHDHV.KlantPortaal.DEV.Audit;User ID=SPHDHV.KlantPortaal.DEV.Audit;Password=sgf345^%$bF4*#gH)9!fcF$#gvgvf67uy3
            Console.WriteLine($" voer de connectiestring in van de database die je opnieuw wil versleutelen");

            string connectionstring = Console.ReadLine();

            // dev: 430E933F3A11CA44EDA086849C4781240A916FB0
            Console.WriteLine($" voer de omgeving in die je wil versleutelen (o,a,p) ");

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

                var x = new AuditDatabaseUpdater(connectionstring, cert);
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
