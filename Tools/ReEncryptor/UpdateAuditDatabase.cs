using Icatt.Azure.Access;
using Icatt.Logging.DataAccess;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Service;
using ReEncryptor.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReEncryptor
{




    public class UpdateAuditDatabase
    {

        private LoggingRepositoryFactory _factory;

        private LoggingRepositoryFactory Factory
        {
            get
            {
                return _factory ??
                       (_factory =
                           new LoggingRepositoryFactory("name=" + Settings.Default.Database));
            }
        }

        private ICryptographer _cryptoEngine;

        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = new CryptographerEngine<object>(null, null));



        public void Update(System.Security.Cryptography.X509Certificates.X509Certificate2 cert)
        {
            var secretOld = Settings.Default.KeyVaultAuditSecrectOld; 
            var secretNew = Settings.Default.KeyVaultAuditSecrectNew; 
            var applicationId = Settings.Default.KeyVaultApplicationId; //applicatie id van de app registration

            var keyVault = new KeyVault(cert, applicationId);
            byte[] keyOld = keyVault.GetSecret(secretOld);
            byte[] keyNew = keyVault.GetSecret(secretNew);

            var cipherName = "Aes256With16ByteIvPrefix";

            Console.WriteLine("even geduld");

            using (var rep = Factory.Create())
            {
                var list = rep.GetLogEntries(new LogEntryFilter());
                foreach (var item in list)
                {
                    var decryptedBytes = CryptoEngine.Decrypt(cipherName, keyOld, item.DetailsEncrypted);

                    // mocht het niet in een keer goed gaan en de tool wordt opnieuw gedraait 
                    // dan laat hij records die al correct geupdate zijn met rust
                    if (decryptedBytes != null)
                    {
                        item.DetailsEncrypted = CryptoEngine.Encrypt(cipherName, keyNew, decryptedBytes);                        
                        try
                        {
                            var result = rep.SaveLogEntry(item);                          
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine($"fout bij opslaan id {item.Id}");
                            Console.Write(e);
                        }

                    }
                }
               

            }
            Console.WriteLine("klaar");
            Console.ReadKey();
        }
    }
}
