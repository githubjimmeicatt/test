using Icatt.Azure.Access;
using Sphdhv.Klantportaal.Audit.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Icatt.Logging;
using Icatt.Logging.DataAccess;
using Icatt.Logging.Entities;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Service;

namespace Sphdhv.Klantportaal.Audit.Engines.Crypto
{
    public class DecryptionEngine
    {

        private ICryptographer _cryptoEngine;

        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = new CryptographerEngine<object>(null, null));


        public string Decrypt(byte[] data)
        {
            var certificateThumbprint = Settings.Default.KeyVaultCertificateThumbprint; //thumbprint van het certificaat geupload bij de app registration
            var certificateAccess = new Engine.Certificate.CertificateAccess();
            var cert = certificateAccess.FindCertificateByThumbprint(certificateThumbprint);

            var secretOld = Settings.Default.KeyVaultAuditSecretOld; //path to the secret
            var secretNew = Settings.Default.KeyVaultAuditSecretNew; //path to the secret
            var applicationId = Settings.Default.KeyVaultApplicationId; //applicatie id van de app registration var keyVault = new KeyVault(cert, applicationId);

            var keyVault = new KeyVault(cert, applicationId);

            byte[] detailsDecrypted = Decrypt(data, secretNew, keyVault);

            if (detailsDecrypted == null && !string.IsNullOrWhiteSpace(secretOld))
            {
                detailsDecrypted = Decrypt(data, secretOld, keyVault);
            }

            if (detailsDecrypted == null) { return string.Empty; }

            return Encoding.UTF8.GetString(detailsDecrypted);
        }

        private byte[] Decrypt(byte[] entry, string secret, KeyVault keyVault)
        {
            byte[] key = keyVault.GetSecret(secret);

            var cipherName = "Aes256With16ByteIvPrefix";


            var detailsDecrypted = CryptoEngine.Decrypt(cipherName, key, entry);
            return detailsDecrypted;
        }

    }
}