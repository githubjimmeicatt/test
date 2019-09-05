using System.Reflection;
using Moq.Language;
using Moq.Language.Flow;

namespace Icatt.Test.Moq
{
    public static class MoqExtensions
    {

        //Actions for mocking methods with reference or out parameters
        public delegate void RefAction<TRef>(ref TRef refVal);
        public delegate void RefAction<in T1,TRef>(T1 arg1,ref TRef refVal);
        public delegate void RefAction<in T1,in T2, TRef>(T1 arg1, T2 arg2, ref TRef refVal);

        public delegate void OutAction<TOut>(out TOut outVal);

        public delegate void OutAction<in T1, TOut>(T1 arg1, out TOut outVal);


        #region OutActions

        public static IReturnsThrows<TMock, TReturn> OutCallback<TMock, TReturn, TOut>(this ICallback<TMock, TReturn> mock, OutAction<TOut> action)
            where TMock : class
        {
            return OutCallbackInternal(mock, action);
        }

        public static IReturnsThrows<TMock, TReturn> OutCallback<TMock, TReturn, T1, TOut>(this ICallback<TMock, TReturn> mock, OutAction<T1, TOut> action)
            where TMock : class
        {
            return OutCallbackInternal(mock, action);
        }

        private static IReturnsThrows<TMock, TReturn> OutCallbackInternal<TMock, TReturn>(ICallback<TMock, TReturn> mock, object action)
            where TMock : class
        {
            mock.GetType()
                .Assembly.GetType("Moq.MethodCall")
                .InvokeMember("SetCallbackWithArguments", BindingFlags.InvokeMethod | BindingFlags.NonPublic | BindingFlags.Instance, null, mock,
                    new[] { action });
            return mock as IReturnsThrows<TMock, TReturn>;
        }

        #endregion


        #region RefActions

        public static IReturnsThrows<TMock, TReturn> RefCallback<TMock, TReturn, TRef>(
            this ICallback<TMock, TReturn> mock, RefAction<TRef> action) where TMock : class
        {
            return RefCallbackInternal(mock, action);
        }

        public static IReturnsThrows<TMock, TReturn> RefCallback<TMock, TReturn,T1, TRef>(
    this ICallback<TMock, TReturn> mock, RefAction<T1,TRef> action) where TMock : class
        {
            return RefCallbackInternal(mock, action);
        }

        public static IReturnsThrows<TMock, TReturn> RefCallback<TMock, TReturn, T1,T2, TRef>(this ICallback<TMock, TReturn> mock, RefAction<T1,T2, TRef> action) where TMock : class
        {
            return RefCallbackInternal(mock, action);
        }

        private static IReturnsThrows<TMock, TReturn> RefCallbackInternal<TMock,TReturn>(ICallback<TMock,TReturn> mock, object action) where TMock:class
        {
            mock.GetType()
                .Assembly.GetType("Moq.MethodCall")
                .InvokeMember("SetCallbackWithArguments", BindingFlags.InvokeMethod | BindingFlags.NonPublic | BindingFlags.Instance, null, mock,
                    new[] { action });
            return mock as IReturnsThrows<TMock, TReturn>;
            
        }

        //public static IReturnsResult<TReturn> RefReturns<TReturn>(this IMock) 

        #endregion
    }
}
