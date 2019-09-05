using System;

namespace Icatt.Logging
{
    public class RequestStartedEventArgs : EventArgs
    {
        public RequestStartedEventArgs(Guid id)
        {
            RequestId = id;
        }

        public Guid RequestId { get; set; }
    }
}