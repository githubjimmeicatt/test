using System;

namespace Icatt.Logging.Entities
{
    public partial class ExceptionEntry: LoggingEntity
    {
        public Guid Id { get; set; }

        public string ApplicationName { get; set; }

        public string ApplicationArea { get; set; }
        public Guid? RequestId { get; set; }
        public Guid? SessionId { get; set; }
        public string Message { get; set; }

        public string Type { get; set; }

        public string Source { get; set; }

        public string StackTrace { get; set; }

        public string TargetSite { get; set; }

        public bool IsInnerException { get; set; }

        public Guid? InnerExceptionId { get; set; }

        public DateTime CreatedAtUtc { get; set; }
        public long? Timestamp { get; set; }

        /// <summary>
        /// Number of inner exceptions..
        /// </summary>
        public int Depth { get; set; }
    }
}
