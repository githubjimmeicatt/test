using System;

namespace Icatt.Logging.DataAccess
{
    public class ExceptionEntryFilter
    {
        public string AppNamePart { get; set; }

        public string AreaNamePart { get; set; }

        public string MessagePart { get; set; }

        public string ExceptionTypePart { get; set; }

        public string StackTracePart { get; set; }

        public bool? IsInnerException { get; set; }

        public bool? HasInnerException { get; set; }

        public DateTime? Starttime { get; set; }

        public long? StartStamp { get; set; }

        public DateTime? Endtime { get; set; }

        public long? EndStamp { get; set; }

        public Guid? SessionId { get; set; }

        public Guid? RequestId { get; set; }

        public ExceptionEntryFilter(string appNamePart = null, string areaNamePart = null,
            Guid? sessionId = null, Guid? requestId = null, string messagePart = null,
            string exceptionTypePart = null, string stackTracePart = null, bool? isInnerException = null, 
            bool? hasInnerException = null, DateTime? starttime = null, long? startStamp = null, 
            DateTime? endtime = null, long? endStamp = null)
        {
            AppNamePart = appNamePart;
            AreaNamePart = areaNamePart;
            SessionId = sessionId;
            RequestId = requestId;
            MessagePart = messagePart;
            ExceptionTypePart = exceptionTypePart;
            StackTracePart = stackTracePart;
            IsInnerException = isInnerException;
            HasInnerException = hasInnerException;
            Starttime = starttime;
            StartStamp = startStamp;
            Endtime = endtime;
            EndStamp = endStamp;
        }

        public ExceptionEntryFilter()
        {
        }

    }
}