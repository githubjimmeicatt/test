using System;
using System.Runtime.Caching;
using Icatt.Caching.Exceptions;

namespace Icatt.Caching
{
    public abstract class ClearableCacheBase : CacheBase,  IClearableCache
    {

        public abstract void Clear(string key);


    }
}