using System;

namespace Icatt.Time
{
    public interface ITimeMachine
    {
        DateTime Now { get; }
        DateTime UtcNow { get; }
    }
}