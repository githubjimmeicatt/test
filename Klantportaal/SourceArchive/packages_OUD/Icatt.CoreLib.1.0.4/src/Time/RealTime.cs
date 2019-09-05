using System;

namespace Icatt.Time
{
    public class RealTime : ITimeMachine
    {
        public DateTime Now => DateTime.Now;

        public DateTime UtcNow => DateTime.UtcNow;
    }
}