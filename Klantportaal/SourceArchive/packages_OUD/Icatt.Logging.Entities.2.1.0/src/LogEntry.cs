using System;

namespace Icatt.Logging.Entities
{
    public class LogEntry: LoggingEntity
    {
        public Guid Id { get; set; }

        public string ApplicationName { get; set; }

        public string ApplicationArea { get; set; }

        public Guid? SessionId { get; set; }

        public Guid? RequestId { get; set; }

        /// <summary>
        /// Can contain Message ID of EventType ID
        /// </summary>
        public int? MessageId { get; set; }

        public string Message { get; set; }

        /// <summary>
        /// Serialize data object of simple string
        /// </summary>
        public string Details { get; set; }

        public byte[] DetailsEncrypted { get; set; }

        public int? DetailsTypeId { get; set; }

        public int LogLevel { get; set; }

        public DateTime CreatedAtUtc { get; set; }

        public long Timestamp { get; set; }

    }
    
}
