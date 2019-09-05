using System;
using System.Runtime.Caching;

namespace Icatt.Caching
{
    /// <summary>
    /// Caching interface bedoeld als wrapper voor zowel System.Web.Caching als System.Runtime.Caching
    /// </summary>
    public interface ICache
    {
        T Get<T>(string key, Func<T> callback);
        T Get<T>(string key, Func<T> callback,CacheItemPolicy policy);

    }
}