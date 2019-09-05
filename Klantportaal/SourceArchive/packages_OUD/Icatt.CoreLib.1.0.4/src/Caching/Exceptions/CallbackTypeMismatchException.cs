using System;
using JetBrains.Annotations;

namespace Icatt.Caching.Exceptions
{
    internal class CallbackTypeMismatchException : Exception
    {
        [StringFormatMethod("s")]
        public CallbackTypeMismatchException(string s, params object[] args) : base(String.Format(s,args)) {}

    }
}
