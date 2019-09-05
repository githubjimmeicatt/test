using System;
using System.Runtime.Caching;
using System.Runtime.Remoting.Messaging;

namespace Icatt.Caching
{
    public abstract class CacheBase : ICache
    {
        public virtual T Get<T>(string key, Func<T> callBack)
        {
            return Get<T>(key, callBack,(CacheItemPolicy) null);
        }

        public virtual T Get<T>(string key, Func<T> callBack, CacheItemPolicy policy)
        {
            return Get(key, callBack, (item) => policy);
        }


        public virtual T Get<T>(string key, Func<T> callBack, Func<T,CacheItemPolicy> policyFunc)
        {
            var item = Get(key);

            if (item != null) return (T)item;

            item = callBack();

            var policy = policyFunc((T)item );

            Set(key, item, policy);

            return (T)item;

        }

        protected abstract object Get(string key);

        protected abstract void Set(string key,object value,CacheItemPolicy policy );

    }
}