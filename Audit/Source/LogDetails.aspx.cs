using System;
using System.Globalization;
using System.Web.UI;
using Icatt.Logging;
using Icatt.Logging.DataAccess;
using Icatt.Logging.Entities;
using Sphdhv.Klantportaal.Audit.Properties;
using Sphdhv.Klantportaal.Audit.Engines.Crypto;

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

        private DecryptionEngine _decryptionEngine;

        public DecryptionEngine DecryptionEngine
        {
            get
            {
                return _decryptionEngine ?? (_decryptionEngine = new DecryptionEngine());
            }
        }



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

            if (entry != null)
            {                               
                litCreatedDate.Text = entry.CreatedAtUtc.ToLocalTime().ToString("yyyy MM dd - HH:mm:ss.fffffff") + " with timestamp " + entry.Timestamp;
                litMessage.Text = entry.Message;
                litApplicationArea.Text = entry.ApplicationArea;
                litDetails.Text = DecryptionEngine.Decrypt(entry.DetailsEncrypted); 

                var levelName = "Waarde komt niet voor in LogLevel enumeratie";
                if (Enum.IsDefined(typeof(LoggingLevel), entry.LogLevel))
                {
                    var level = (LoggingLevel)entry.LogLevel;
                    levelName = level.ToString();
                }

                litLogLevel.Text = entry.LogLevel + " - " + levelName;

            }
        }

  

      
    }
}