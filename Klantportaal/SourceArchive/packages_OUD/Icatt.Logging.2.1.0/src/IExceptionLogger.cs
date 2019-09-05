using System;

namespace Icatt.Logging
{
    public interface IExceptionLogger
    {
        void LogException(Exception ex);
    }
}