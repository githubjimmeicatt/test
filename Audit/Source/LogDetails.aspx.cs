using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using Icatt.Logging;
using Icatt.Logging.DataAccess;
using Icatt.Logging.Entities;
using Sphdhv.Klantportaal.Audit.Properties;
using System.Text;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Service;
using Icatt.Azure.Access;

namespace Sphdhv.Klantportaal.Audit
{
    public partial class LogDetails : Page
    {
        private LoggingRepositoryFactory _factory;

        private LoggingRepositoryFactory Factory
        {
            get
            {
                return _factory ??
                       (_factory =
                           new LoggingRepositoryFactory("name=" + Settings.Default.LoggingDatabaseConnectionString));
            }
        }



        private ICryptographer _cryptoEngine;

        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = new CryptographerEngine<object>(null, null));



        protected void Page_Load(object sender, EventArgs e)
        {
            var entryId = new Guid(Request.QueryString["id"]);

            DateTime? createdAtUtc = null;
            DateTime dtValue;

            if (DateTime.TryParseExact(Request.QueryString["utc"], "yyyy-MM-dd HHmmss.fffffff", CultureInfo.InvariantCulture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal, out dtValue))
            {
                createdAtUtc = dtValue;
            }

            LogEntry entry;
            using (var rep = Factory.Create())
            {
                entry = rep.GetLogEntry(entryId, createdAtUtc);
            }


            var certificateThumbprint = Settings.Default.KeyVaultCertificateThumbprint; //thumbprint van het certificaat geupload bij de app registration
            var certificateAccess = new Engine.Certificate.CertificateAccess();
            var cert = certificateAccess.FindCertificateByThumbprint(certificateThumbprint);

            var secretOld = Settings.Default.KeyVaultAuditSecretOld; //path to the secret
            var secretNew = Settings.Default.KeyVaultAuditSecretNew; //path to the secret
            var applicationId = Settings.Default.KeyVaultApplicationId; //applicatie id van de app registration var keyVault = new KeyVault(cert, applicationId);

            var keyVault = new KeyVault(cert, applicationId);

            byte[] detailsDecrypted = Decrypt(entry, secretNew, keyVault); ;

            if (detailsDecrypted == null)
            {
                detailsDecrypted = Decrypt(entry, secretOld, keyVault);
            }

            if (entry != null)
            {
                litCreatedDate.Text = entry.CreatedAtUtc.ToLocalTime().ToString("yyyy MM dd - HH:mm:ss.fffffff") + " with timestamp " + entry.Timestamp;
                litMessage.Text = entry.Message;
                litApplicationArea.Text = entry.ApplicationArea;
                litDetails.Text = Encoding.UTF8.GetString(detailsDecrypted);

                var levelName = "Waarde komt niet voor in LogLevel enumeratie";
                if (Enum.IsDefined(typeof(LoggingLevel), entry.LogLevel))
                {
                    var level = (LoggingLevel)entry.LogLevel;
                    levelName = level.ToString();
                }

                litLogLevel.Text = entry.LogLevel + " - " + levelName;

            }
        }

        private byte[] Decrypt(LogEntry entry, string secretOld, KeyVault keyVault)
        {
            byte[] key = keyVault.GetSecret(secretOld);

            var cipherName = "Aes256With16ByteIvPrefix";


            var detailsDecrypted = CryptoEngine.Decrypt(cipherName, key, entry.DetailsEncrypted);
            return detailsDecrypted;
        }
    }
}