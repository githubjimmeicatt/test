using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Text;
using System.Threading.Tasks;
using Icatt.Caching.Exceptions;

namespace Icatt.Caching
{
    public abstract class DynamicPolicyCacheBase : ClearableCacheBase,IDynamicPolicyCache
    {
        public T Get<T, TInput>(string key, Func<TInput, T> callBack, Func<TInput, CacheItemPolicy> policyFunc, Func<TInput> inputFunc = null )
        {
            if (callBack == null) throw new ArgumentNullException("callBack");
            if (policyFunc == null) throw new ArgumentNullException("policyFunc");
            if (key == null) throw new ArgumentNullException("key");

            var item = Get(key);

            if (item is T) return (T)item;

            if (item != null)
            {
                throw new CallbackTypeMismatchException("The callback function used to get cache item '{0}' returns a value of type '{1}' which does not match with the actual value found in the cache which is of type '{2}'. If both types are not the same, type '{2}' must be a subclass of type '{1}'", key, typeof(T).FullName, item.GetType().FullName);
            }

            var input = default(TInput) ;
            if (inputFunc != null)
            {
                input = inputFunc();
            }


            item = callBack(input);

            if (item == null)
            {
                //geen null teruggeven omdat T non-nullable valuetype kan zijn en je niet default(T) terug wil geven...
                throw new CacheCallbackReturnsNullException(
                    "Callback function for cache item '{0}' returned null. Callback functions passed with the Get method should never return null.", key);
            }

            var policy = policyFunc(input);

            Set(key, item, policy);

            return (T)item;

        }


    }
}
