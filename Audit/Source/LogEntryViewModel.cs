using System;
using Icatt.Logging.Entities;

namespace Sphdhv.Klantportaal.Audit
{
    public class LogEntryViewModel
    {
        readonly LogEntry _data;

        public LogEntryViewModel(LogEntry data)
        {
            _data = data;
        }

        public Guid Id
        {
            get { return _data.Id; }
            set { _data.Id = value; }
        }

        public string ApplicationName
        {
            get { return _data.ApplicationName; }
            set { _data.ApplicationName = value; }
        }

        public string ApplicationArea
        {
            get { return _data.ApplicationArea; }
            set { _data.ApplicationArea = value; }
        }

        public Guid? SessionId
        {
            get { return _data.SessionId; }
            set { _data.SessionId = value; }
        }

        public Guid? RequestId
        {
            get { return _data.RequestId; }
            set { _data.RequestId = value; }
        }

        public int? MessageId
        {
            get { return _data.MessageId; }
            set { _data.MessageId = value; }
        }

        public string Message
        {
            get { return _data.Message; }
            set { _data.Message = value; }
        }

        public string Details
        {
            get { return _data.Details; }
            set { _data.Details = value; }
        }

        public int LogLevel
        {
            get { return _data.LogLevel; }
            set { _data.LogLevel = value; }
        }

        public DateTime CreatedAtLocal
        {
            get { return _data.CreatedAtUtc.ToLocalTime(); }
        }
        public DateTime CreatedAtUtc
        {
            get { return _data.CreatedAtUtc; }
        }


        public long Timestamp
        {
            get { return _data.Timestamp; }
            set { _data.Timestamp = value; }
        }
    }
}
