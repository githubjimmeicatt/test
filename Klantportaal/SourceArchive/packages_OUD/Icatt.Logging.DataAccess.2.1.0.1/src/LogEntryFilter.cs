using System;

namespace Icatt.Logging.DataAccess
{
    public class LogEntryFilter
    {
        public string AppNamePart { get; set; }

        public string AreaNamePart { get; set; }

        public string ContainedInDetail { get; set; }

        public string ContainedInMessage { get; set; }

        public int? DataTypeId { get; set; }

        public long? EndStamp { get; set; }

        public DateTime? Endtime { get; set; }

        public int? MaxLoggingLevel { get; set; }

        public int? MessageNr { get; set; }

        public int? MinLoggingLevel { get; set; }

        public Guid? RequestId { get; set; }

        public Guid? SessionId { get; set; }

        public long? StartStamp { get; set; }

        public DateTime? Starttime { get; set; }


        public LogEntryFilter(string appNamePart = null, string areaNamePart = null, Guid? sessionId = null, Guid? requestId= null, int? minLoggingLevel = null,
            int? maxLoggingLevel=null, int? messageNr = null, 
            string containedInMessage = null, string containedInDetail = null, DateTime? starttime = null, 
            long? startStamp = null, DateTime? endtime = null, long? endStamp = null)
        {
            AppNamePart = appNamePart;
            AreaNamePart = areaNamePart;
            SessionId = sessionId;
            RequestId = requestId;
            MinLoggingLevel = minLoggingLevel;
            MaxLoggingLevel = maxLoggingLevel;
            MessageNr = messageNr;
            ContainedInMessage = containedInMessage;
            ContainedInDetail = containedInDetail;
            Starttime = starttime;
            StartStamp = startStamp;
            Endtime = endtime;
            EndStamp = endStamp;
        }

        public LogEntryFilter()
        {
        }
    }
}
