using System;

namespace Icatt.Logging
{
    public class SessionStartedEventArgs : EventArgs
    {
        public SessionStartedEventArgs(Guid id)
        {
            SessionId = id;
        }

        public Guid SessionId { get; set; }
    }
}