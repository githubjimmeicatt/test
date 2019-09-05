using System;
using System.Linq;
using Icatt.Caching.Exceptions;
using System.Runtime.Caching;
using JetBrains.Annotations;

namespace Icatt.Caching
{

    /// <summary>
    /// An application level default ICache implementation for Icatt.Forms.. Internally MemoryCache.Default is used. 
    /// </summary>
    /// <remarks>
    /// See https://msdn.microsoft.com/en-us/library/ff477235(v=vs.110).aspx and https://msdn.microsoft.com/en-us/library/dd997357.aspx for background on caching in ASP.NET 4.5+
    /// See https://msdn.microsoft.com/en-us/library/system.runtime.caching.memorycache.default(v=vs.110).aspx for background on the MemoryCache.Default property
    /// See http://stackoverflow.com/questions/7422859/memorycache-empty-returns-null-after-being-set about fix of MemoryCache.Default issues 
    /// </remarks>
    public class DefaultApplicationCache : DynamicPolicyCacheBase
    {
        //In Web environments the MemoryCache.Default internally uses the same cache as System.Web.HttpContext.Current.Cache
        private readonly ObjectCache _theCache = MemoryCache.Default;

        public override void Clear([NotNull]string key)
        {
            if (key == null) throw new ArgumentNullException("key");
            _theCache.Remove(key);
        }

        protected override object Get(string key)
        {
            return _theCache.Get(key);
        }

        protected override void Set(string key, object value, CacheItemPolicy policy)
        {
           _theCache.Set(key,value,policy);
        }

        public virtual void ClearAll(string keyPrefix = null)
        {
            var allKeys =

                _theCache
                    .Select(o => o.Key);

            if (!string.IsNullOrEmpty(keyPrefix))
            {
                allKeys = allKeys.Where(k => k.StartsWith(keyPrefix, StringComparison.Ordinal));
            }

            var keyList = allKeys.ToList();

            keyList.ForEach(key => _theCache.Remove(key));
        }

       
    }
}
