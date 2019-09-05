using System;
using System.Runtime.Caching;
using Icatt.Caching.Exceptions;

namespace Icatt.Caching
{
    public interface IDynamicPolicyCache : IClearableCache
    {

        /// <summary>
        /// Returns an object of type <typeparamref name="T"/> from the cache if it is found with key <paramref name="key"/> or 
        /// calls <paramref name="callBack"/> and <paramref name="policyFunc"/> to create te object and add it to the cache before returning it.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="TInput"></typeparam>
        /// <param name="key"></param>
        /// <param name="callBack">function called when no entry if found in the cache with key <paramref name="key"/></param>
        /// <param name="policyFunc">function called to generate the <see cref="CacheItemPolicy"/> that is used when adding the object returned by <paramref name="callBack"/> to the cache </param>
        /// <param name="inputFunc">
        ///     Optional function returning an input object that is padded to by both the <paramref name="callBack"/> and <paramref name="policyFunc"/> functions as input
        ///     <br />If no <paramref name="inputFunc"/> is provided, default(TInput) is passed to the <paramref name="callBack"/> and <paramref name="policyFunc"/> funtions. </param>
        /// <returns>Always an instance of <typeparamref name="T"/>. If <paramref name="callBack"/> returns null, a <see cref="CacheCallbackReturnsNullException"/> must be thrown by implementers. If the cache conainst an object that is not of type <typeparamref name="T"/>, implementors must thow a <see cref="CallbackTypeMismatchException"/> </returns>
        T Get<T, TInput>(string key, Func<TInput, T> callBack, Func<TInput, CacheItemPolicy> policyFunc, Func<TInput> inputFunc = null);

    }
}