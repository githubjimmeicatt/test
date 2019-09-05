using System;
using Moq;

namespace Icatt.Test.Moq.Builders
{
    /// <summary>
    /// Concept.. not ready for use
    /// </summary>
    /// <remarks>
    /// Builder template for building mocks
    /// 
    /// From... methods replace the constructor. Order of From... calls is important. Only the last From... call wins.
    /// With... methods add modifiers. Order of calls may be important. The last call wins in case of conflicting With... calls.
    /// 
    /// <see cref="Builder{T}.Build"/> can be called as often as needed, and always returns a new object instance..
    /// 
    /// </remarks>
    public class MockBuilder<T> : Builder<Mock<T>> where T : class
    {

        protected MockBehavior MockBehavior = MockBehavior.Strict;

        public MockBuilder()
        {
            Constructor = () =>
            {
                var mock = new Mock<T>(MockBehavior);

                return mock;
            };
        }

        public MockBuilder<T> WithMockBehaviour(MockBehavior mockBehavior)
        {
            MockBehavior = mockBehavior;

            return this;
        }

        public MockBuilder<T> WithMockModifier(Action<Mock<T>> modifier)
        {
            return WithModifier(modifier) as MockBuilder<T>;

        }

    }
}