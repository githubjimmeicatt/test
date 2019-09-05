using System;

namespace Icatt.Logging.Exceptions
{
    public class InvalidILoggerImplementation : Exception
    {
        public InvalidILoggerImplementation(Type implementingType, Type areaEnumType, Type messageEnumType) :
            base(string.Format("Icatt.Logging.ILogger implementations must use integer based Enum types for the type parameters TAppAreaEnum and TLogMessageEnum. Type '{0}'  uses '{1}' for TAppAreaEnum and '{2}' for TLogMessageEnum which are not both enums",
                implementingType.FullName, areaEnumType.FullName, messageEnumType.FullName))
        {
        }
    }
}