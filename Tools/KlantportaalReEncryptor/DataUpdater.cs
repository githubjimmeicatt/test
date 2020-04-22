using Icatt.Azure.Access;
using Icatt.Data.Entity;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Service;
using KlantportaalReEncryptor.Properties;
using Sphdhv.KlantPortaal.Data.Deelnemer.DbContext;
using Sphdhv.KlantPortaal.Data.Deelnemer.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Cryptography.X509Certificates;

namespace KlantportaalReEncryptor
{
    internal class DataUpdater
    {
        private string connectionstring;
        private X509Certificate2 certificate;

        private ICryptographer _cryptoEngine;

        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = new CryptographerEngine<object>(null, null));


        public DataUpdater(string connectionstring, X509Certificate2 cert)
        {
            this.connectionstring = connectionstring;
            this.certificate = cert;
        }

        public void Update()
        {

            var secretOld = Settings.Default.KeyVaultSecrectOld;
            var secretNew = Settings.Default.KeyVaultSecrectNew;
            var applicationId = Settings.Default.KeyVaultApplicationId; //applicatie id van de app registration

            var keyVault = new KeyVault(certificate, applicationId);
            byte[] keyOld = keyVault.GetSecret(secretOld);
            byte[] keyNew = keyVault.GetSecret(secretNew);

            var cipherName = "Aes256With16ByteIvPrefix";

            Console.WriteLine("even geduld");

            var bijgewerkteDeeelnemers = new List<Deelnemer>();

            using (var context = new DeelnemerDbContext(connectionstring))
            {
                var deelnemers = context.Deelnemers;

                foreach (var item in deelnemers)
                {
                    var decryptedEmail = CryptoEngine.DecryptString(cipherName, keyOld, item.Email);
                    var decryptedBsn = CryptoEngine.DecryptString(cipherName, keyOld, item.Bsn);

                    // mocht het niet in een keer goed gaan en de tool wordt opnieuw gedraait 
                    // dan laat hij records die al correct geupdate zijn met rust
                    if (decryptedBsn != null)
                    {
                        item.Bsn = CryptoEngine.EncryptString(cipherName, keyNew, decryptedBsn);
                    }

                    if (decryptedEmail != null)
                    {
                        item.Email = CryptoEngine.EncryptString(cipherName, keyNew, decryptedEmail);

                    }

                    if (decryptedBsn != null || decryptedEmail != null)
                    {
                        bijgewerkteDeeelnemers.Add(item);
                    }

                   

                }
            }

            foreach (var item in bijgewerkteDeeelnemers)
            {
                item.State = ObjectState.Modified;
                using (var context = new DeelnemerDbContext(connectionstring))
                {

                    context.ChangeTracker.DetectChanges();

                    context.Deelnemers.Attach(item);
                    //DIT WERKT WEL
                    try
                    {
                        var result = context.Save();
                        Console.WriteLine($"klaar. {result} records bijgewerkt.");
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine($"fout bij opslaan id {item.Id}");
                        Console.Write(e);
                    }
                }
            }

        }
    }
}