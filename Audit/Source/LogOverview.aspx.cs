using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Icatt.Logging.DataAccess;
using Sphdhv.Klantportaal.Audit.Properties;
using Icatt.Logging;

using Icatt.Security.Engine.Cryptographer.Interface;

using Icatt.Security.Engine.Cryptographer.Service;
using System.Text;
using Icatt.Logging.Entities;
using Icatt.Azure.Access;

namespace Sphdhv.Klantportaal.Audit
{
    public partial class LogOverview : Page
    {





        protected void Page_Load(object sender, EventArgs e)
        {
            gvwLog.PagerSettings.Mode = PagerButtons.NumericFirstLast;
            gvwLog.PagerSettings.Visible = true;
            gvwLog.PagerSettings.PreviousPageText = "<";
            gvwLog.PagerSettings.Position = PagerPosition.TopAndBottom;
            gvwLog.PagerSettings.PageButtonCount = 5;
            gvwLog.PagerSettings.NextPageText = ">";
            gvwLog.PagerSettings.LastPageText = ">>";
            gvwLog.PagerSettings.FirstPageText = "<<";
            gvwLog.AllowPaging = true;
            gvwLog.AllowSorting = true;
            gvwLog.PageSize = 50;

            if (txtNa.Text == "") txtNa.Text = DateTime.Now.AddDays(-1).ToString("dd-MM-yyyy HH:mm:ss.fffffff");
            if (txtVoor.Text == "") txtVoor.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss.fffffff");


        }


        protected void BtnSearchClick(object sender, EventArgs e)
        {
            gvwLog.PageIndex = 0;
            LogEntries.Application = ddlAppName.SelectedValue;
            LogEntries.MessageNumber = null;
            LogEntries.Bericht = txtBericht.Text.Trim();
            LogEntries.EndTime = txtVoor.Text.Trim();
            LogEntries.StartTime = txtNa.Text.Trim();
            LogEntries.Level = ddlLevel.SelectedValue;
            LogEntries.Area = string.IsNullOrWhiteSpace(null) ? txtArea.Text.Trim() : null;
            LogEntries.Details = txtDetails.Text.Trim();
            LogEntries.SessionId = txtSession.Text.Trim();
            LogEntries.RequestId = txtRequest.Text.Trim();
            gvwLog.DataBind();

            txtVoor.Text = LogEntries.EndTime;
            txtNa.Text = LogEntries.StartTime;
        }


    }



    public class LogEntries
    {
        private LoggingRepositoryFactory _factory;


        private ICryptographer _cryptoEngine;



        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = new CryptographerEngine<object>(null, null));



        public LogEntries()
        {

        }

        public static string EndTime { get; set; }
        public static string Bericht { get; set; }
        public static string Level { get; set; }
        public static string Area { get; set; }
        public static string Details { get; set; }
        public static string SessionId { get; set; }
        public static string RequestId { get; set; }

        public static DateTime EndTimeLocal
        {
            get
            {
                DateTime date;
                var culture = CultureInfo.CreateSpecificCulture("nl-NL");
                var styles = DateTimeStyles.AssumeLocal | DateTimeStyles.AllowInnerWhite | DateTimeStyles.AllowLeadingWhite | DateTimeStyles.AllowTrailingWhite;
                if (!DateTime.TryParse(EndTime, culture, styles, out date))
                {
                    //Default to now
                    date = DateTime.Now;
                }

                EndTime = date.ToString("dd-MM-yyyy HH:mm:ss.fffffff");

                return date;
            }
        }

        public static DateTime StartTimeLocal
        {
            get
            {
                DateTime date;
                var culture = CultureInfo.CreateSpecificCulture("nl-NL");
                var styles = DateTimeStyles.AssumeLocal | DateTimeStyles.AllowInnerWhite | DateTimeStyles.AllowLeadingWhite | DateTimeStyles.AllowTrailingWhite;
                if (!DateTime.TryParse(StartTime, culture, styles, out date))
                {
                    //Default to 30 minutes befor endtime
                    date = EndTimeLocal.AddMinutes(-30);
                }

                StartTime = date.ToString("dd-MM-yyyy HH:mm:ss.fffffff");

                return date;
            }
        }

        private LoggingRepositoryFactory Factory
        {
            get
            {
                return _factory ??
                       (_factory =
                           new LoggingRepositoryFactory("name=" + Settings.Default.LoggingDatabaseConnectionString));
            }
        }

        public static string Application { get; set; }
        public static string MessageNumber { get; set; }
        public static string StartTime { get; set; }


        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public IList<LogEntryViewModel> GetLogItemsPaged(int startRowIndex, int maximumRows)
        {

            var containedInMessage = string.IsNullOrWhiteSpace(Bericht) ? null : Bericht;
            var containedInDetail = string.IsNullOrWhiteSpace(Details) ? null : Details;
            var areaNamePart = string.IsNullOrWhiteSpace(Area) ? null : Area;
            var appNamePart = string.IsNullOrWhiteSpace(Application) ? null : Application;
            var msgNr = string.IsNullOrWhiteSpace(MessageNumber) ? null : MessageNumber;
            var sessionId = string.IsNullOrWhiteSpace(SessionId) ? null : SessionId;
            var requestId = string.IsNullOrWhiteSpace(RequestId) ? null : RequestId;

            LoggingLevel? minLevel = LoggingLevel.Debug;
            LoggingLevel levelEnum;
            if (Enum.TryParse(Level, true, out levelEnum))
            {
                minLevel = levelEnum;
            }


            int? messagerNr = null;
            int intValue;
            if (int.TryParse(msgNr, out intValue))
            {
                messagerNr = intValue;
            }

            Guid guidValue;

            Guid? sessionGuid = null;
            if (Guid.TryParse(sessionId, out guidValue))
            {
                sessionGuid = guidValue;
            }

            Guid? requestGuid = null;
            if (Guid.TryParse(requestId, out guidValue))
            {
                requestGuid = guidValue;
            }

            using (var rep = Factory.Create())
            {
                var list = rep.GetLogEntries(
                    new LogEntryFilter(appNamePart: appNamePart,
                        areaNamePart: areaNamePart,
                        minLoggingLevel: (int?)minLevel,
                        messageNr: messagerNr,
                        sessionId: sessionGuid,
                        requestId: requestGuid,
                        //  containedInDetail: containedInDetail, als er gezocht wordt op details dan pas nadat de data opgehaald is decrypten en zoeken..
                        containedInMessage: containedInMessage,
                        starttime: StartTimeLocal.ToUniversalTime(),
                        endtime: EndTimeLocal.ToUniversalTime()),
                    skip: startRowIndex,
                    take: maximumRows).ToList();
                //  .Select(entry => new LogEntryViewModel(entry)).ToList();


                IEnumerable<LogEntry> itemsContainingDetailSearch = null;

                if (!string.IsNullOrWhiteSpace(containedInDetail))
                {



                    var certificateThumbprint = Settings.Default.KeyVaultCertificateThumbprint; //thumbprint van het certificaat geupload bij de app registration
                    var certificateAccess = new Engine.Certificate.CertificateAccess();
                    var cert = certificateAccess.FindCertificateByThumbprint(certificateThumbprint);

                    var secret = Settings.Default.KeyVaultAuditSecretOld; //path to the secret
                    var applicationId = Settings.Default.KeyVaultApplicationId; //applicatie id van de app registration

                    var keyVault = new KeyVault(cert, applicationId);

                    var cipherName = "Aes256With16ByteIvPrefix";
                    
                    itemsContainingDetailSearch = list.Where(l =>
                    {
                        byte[] key = keyVault.GetSecret(secret);
                        var decrypted = Encoding.UTF8.GetString(CryptoEngine.Decrypt(cipherName, key, l.DetailsEncrypted));
                        return (decrypted.Contains(containedInDetail));        
                    });


                }

                var result = itemsContainingDetailSearch ?? list;

                return result.Select(entry => new LogEntryViewModel(entry)).ToList();

            }


        }


        [Obsolete]
        public int TotalNumberOfProducts()
        {

            using (var rep = Factory.Create())
            {
                return rep.CountLogEntries(null);
            }


            //using (var context = new ErrorLogEntities())
            //{
            //    var logs = context.LogEntries.AsQueryable();
            //    logs = LogQuery(logs);
            //    return logs.Count();
            //}
        }



    }

}