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
            byte[] key = keyVault.GetSecret(secretOld);

            var cipherName = "Aes256With16ByteIvPrefix";


           
            using (var rep = Factory.Create())
            {
                var list = rep.GetLogEntries(new LogEntryFilter()).ToList();
                foreach (var item in list)
                {
                    var detailsDecrypted = CryptoEngine.Decrypt(cipherName, key, item.DetailsEncrypted);
                    Console.WriteLine(Encoding.UTF8.GetString(detailsDecrypted));
                }

            }
            Console.ReadLine();
        }
    }
}
