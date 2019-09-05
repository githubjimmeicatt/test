using System;
using JetBrains.Annotations;

namespace Icatt.Caching.Exceptions
{
    internal class CacheCallbackReturnsNullException : Exception
    {
        [StringFormatMethod("s")]
        public CacheCallbackReturnsNullException(string s, params object[] args) : base(string.Format(s,args))
        {

        }
    }
}