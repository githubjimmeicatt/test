using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Icatt.Test.Moq.Builders
{
    /// <summary>
    /// 
    /// </summary>
    /// <remarks>
    /// Builder template
    /// 
    /// From... methods modify the constructor. Order of From... calls is important. Only the last From... call wins.
    /// With... methods add modifiers. Order of calls may be important. The last call wins in case of conflicting With... calls.
    /// With[Methodname]Recorder methods are special modifiers with the signature With[Methodname]Recorder(out IList&lt;TRecording&gt; recordings) that sets the mock up to record calls in the list 'recordings'
    /// Use[ChildBuilder] methods return a child builder that you can use to configure services that the service you are building depends on.
    /// 
    /// <see cref="Builder{T}.Build"/> can be called as often as needed, and always returns a new object instance..
    /// 
    /// </remarks>
    public abstract class Builder<T> where T : class
    {
        protected Func<T> Constructor;
        protected readonly List<Action<T>> Modifiers = new List<Action<T>>();
        protected readonly List<Builder<object>> ChildBuilders = new List<Builder<object>>();

        public virtual T Build()
        {
            Assert.IsNotNull(Constructor, "No default constructor provided. Use one of the From... methods on the builder to select a constructor for the build.");

            var result = Constructor();

            foreach (var modifier in Modifiers)
            {
                modifier(result);
            }

            return result;
        }


        protected  Builder<T> WithModifier(Action<T> modifier)
        {
            Modifiers.Add(modifier);

            return this;
        }


    }
}