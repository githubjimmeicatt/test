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
    /// </summary>
    class Program
    {


        static void Main(string[] args)
        {


            Console.WriteLine("heb je dewebsite uitgezet? (j/n) ");
            var keyInfoWebsiteUit = Console.ReadKey();
            if (keyInfoWebsiteUit.KeyChar != 'j')
            {
                return;
            }
            Console.WriteLine();

            Console.WriteLine($"je gaat deze omgeving opnieuw versleutelen: {Settings.Default.Omgeving}. Ok? (j/n) ");
            var keyInfoOmgeving = Console.ReadKey();
            if (keyInfoOmgeving.KeyChar != 'j')
            {
                return;
            }
            Console.WriteLine();

            var x = new UpdateAuditDatabase();
            var cert = new Cert().FindCertificateByThumbprint(Settings.Default.KeyVaultCertificateThumbprint);

            x.Update(cert);
       

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
