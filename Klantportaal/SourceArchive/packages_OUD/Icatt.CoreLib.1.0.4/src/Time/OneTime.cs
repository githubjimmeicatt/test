using System;

namespace Icatt.Time
{
    public class OneTime : ITimeMachine
    {
        public OneTime(DateTime now, DateTime utcNow)
        {
            Now = now;
            UtcNow = utcNow;
        }

        public DateTime Now
        {
            get;
        }

        public DateTime UtcNow
        {
            get;
        }
    }
}
