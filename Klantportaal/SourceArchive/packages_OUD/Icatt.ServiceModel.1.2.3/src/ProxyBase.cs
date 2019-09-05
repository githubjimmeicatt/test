using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices.ComTypes;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace Icatt.ServiceModel
{
    public class ProxyBase<IContract, TContext> where IContract : class where TContext : class
    {
        private IOperationHandlerCollection<TContext, bool> AuthenticateInvokeHandlers = new OperationHandlerCollection<TContext, bool>();
        private IOperationHandlerCollection<TContext, Task<bool>> AuthenticateInvokeAsyncHandlers = new OperationHandlerCollection<TContext, Task<bool>>();

        private IOperationHandlerCollection<TContext, bool> AuthorizeInvokeHandlers = new OperationHandlerCollection<TContext, bool>();
        private IOperationHandlerCollection<TContext, Task<bool>> AuthorizeInvokeAsyncHandlers = new OperationHandlerCollection<TContext, Task<bool>>();

        private IOperationHandlerCollection<TContext> PreInvokeHandlers = new OperationHandlerCollection<TContext>();
        private IOperationHandlerCollection<TContext, Task> PreInvokeAsyncHandlers = new OperationHandlerCollection<TContext, Task>();

        private IOperationHandlerCollection<TContext> PostInvokeHandlers = new OperationHandlerCollection<TContext>();
        private IOperationHandlerCollection<TContext, Task> PostInvokeAsyncHandlers = new OperationHandlerCollection<TContext, Task>();

        private IOperationHandlerCollection<TContext> InvokeErrorHandlers = new OperationHandlerCollection<TContext>();
        private IOperationHandlerCollection<TContext, Task> InvokeErrorAsyncHandlers = new OperationHandlerCollection<TContext, Task>();

        public event EventHandler<PostInvokeArgs> OnPostInvoke;
        public event EventHandler<PreInvokeArgs> OnPreInvoke;
        public event EventHandler<ErrorEventArgs> OnError;
        public OnAuthenticateHandler OnAuthenticate;
        public OnAuthorizeHandler OnAuthorize;

        private IContract _service;

        protected ProxyBase(TContext context, IFactoryContainer<TContext> factoryContainer)
        {
            FactoryContainer = factoryContainer;
            Context = context;
        }

        protected virtual IFactoryContainer<TContext> FactoryContainer { get; }

        protected IContract Service
        {
            get
            {
                return _service ?? (_service = FactoryContainer.ServiceFactory.CreateService<IContract>(Context));
            }
        }

        protected virtual TContext Context { get; }

        #region synchronous methods

        #region void Invoke overloads

        protected void Invoke(Action action, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Action(() =>
            {
                var authenticated = AuthenticateInvoke(Context, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, action, serviceMemberName);

                InnerInvoke(Context, action);

                OperationPostInvoke(Context, action, serviceMemberName);

            });

            wrapper();
        }

        protected void Invoke<T1>(T1 arg1, Action<T1> action, [CallerMemberName] string serviceMemberName = null)
        {


            var wrapper = new Action<T1>((a1) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, action, serviceMemberName);

                InnerInvoke(Context, a1, action);

                OperationPostInvoke(Context, a1, action, serviceMemberName);

            });

            wrapper(arg1);
        }

        protected void Invoke<T1, T2>(T1 arg1, T2 arg2, Action<T1, T2> action, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Action<T1, T2>((a1, a2) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, action, serviceMemberName);

                InnerInvoke(Context, a1, a2, action);

                OperationPostInvoke(Context, a1, a2, action, serviceMemberName);

            });

            wrapper(arg1, arg2);
        }

        protected void Invoke<T1, T2, T3>(T1 arg1, T2 arg2, T3 arg3, Action<T1, T2, T3> action, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Action<T1, T2, T3>((a1, a2, a3) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, action, serviceMemberName);

                InnerInvoke(Context, a1, a2, a3, action);

                OperationPostInvoke(Context, a1, a2, a3, action, serviceMemberName);

            });

            wrapper(arg1, arg2, arg3);
        }

        protected void Invoke<T1, T2, T3, T4>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, Action<T1, T2, T3, T4> action, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Action<T1, T2, T3, T4>((a1, a2, a3, a4) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, a4, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, a4, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, a4, action, serviceMemberName);

                InnerInvoke(Context, a1, a2, a3, a4, action);

                OperationPostInvoke(Context,  a1, a2, a3, a4, action, serviceMemberName);

            });

            wrapper(arg1, arg2, arg3, arg4);
        }

        protected void Invoke<T1, T2, T3, T4, T5>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Action<T1, T2, T3, T4, T5> action, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Action<T1, T2, T3, T4, T5>((a1, a2, a3, a4, a5) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, a4, a5, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, a4, a5, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();


                OperationPreInvoke(Context, a1, a2, a3, a4, a5, action, serviceMemberName);

                InnerInvoke(Context, a1, a2, a3, a4, a5, action);

                OperationPostInvoke(Context,  a1, a2, a3, a4, a5, action, serviceMemberName);

            });

            wrapper(arg1, arg2, arg3, arg4, arg5);
        }

        protected void Invoke<T1, T2, T3, T4, T5, T6>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Action<T1, T2, T3, T4, T5, T6> action, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Action<T1, T2, T3, T4, T5, T6>((a1, a2, a3, a4, a5, a6) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, a4, a5, a6, action, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, a4, a5, a6, action, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, a4, a5, a6, action, serviceMemberName);

                InnerInvoke(Context, a1, a2, a3, a4, a5, a6, action);

                OperationPostInvoke(Context,  a1, a2, a3, a4, a5, a6, action, serviceMemberName);

            });

            wrapper(arg1, arg2, arg3, arg4, arg5, arg6);
        }

        #endregion

        #region TResult Invoke overloads

        protected TResult Invoke<TResult>(Func<TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<TResult>(() =>
           {
               var authenticated = AuthenticateInvoke(Context, function, serviceMemberName);

               if (!authenticated)
                   throw new AuthenticationException();

               var AuthorizeInvoked = AuthorizeInvoke(Context, function, serviceMemberName);

               if (!AuthorizeInvoked)
                   throw new AuthorizationException();

               OperationPreInvoke(Context, function, serviceMemberName);

               var result = InnerInvoke(Context, function);

               OperationPostInvoke(Context, result, function, serviceMemberName);

               return result;
           });

            return wrapper();
        }

        protected TResult Invoke<T1, TResult>(T1 arg1, Func<T1, TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<T1, TResult>((a1) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, function, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, function, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, function, serviceMemberName);

                var result = InnerInvoke(Context, a1, function);

                OperationPostInvoke(Context, result, arg1, function, serviceMemberName);

                return result;
            });

            return wrapper(arg1);
        }

        protected TResult Invoke<T1, T2, TResult>(T1 arg1, T2 arg2, Func<T1, T2, TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<T1, T2, TResult>((a1, a2) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, function, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, function, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, function, serviceMemberName);

                var result = InnerInvoke(Context, a1, a2, function);

                OperationPostInvoke(Context, result, a1, a2, function, serviceMemberName);

                return result;
            });

            return wrapper(arg1, arg2);
        }

        protected TResult Invoke<T1, T2, T3, TResult>(T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<T1, T2, T3, TResult>((a1, a2, a3) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, function, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, function, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, function, serviceMemberName);

                var result = InnerInvoke(Context, a1, a2, a3, function);

                OperationPostInvoke(Context, result, a1, a2, a3, function, serviceMemberName);

                return result;
            });

            return wrapper(arg1, arg2, arg3);
        }

        protected TResult Invoke<T1, T2, T3, T4, TResult>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<T1, T2, T3, T4, TResult>((a1, a2, a3, a4) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, a4, function, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, a4, function, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, a4, function, serviceMemberName);

                var result = InnerInvoke(Context, a1, a2, a3, a4, function);

                OperationPostInvoke(Context, result, a1, a2, a3, a4, function, serviceMemberName);

                return result;
            });

            return wrapper(arg1, arg2, arg3, arg4);
        }

        protected TResult Invoke<T1, T2, T3, T4, T5, TResult>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<T1, T2, T3, T4, T5, TResult>((a1, a2, a3, a4, a5) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, a4, a5, function, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, a4, a5, function, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, a4, a5, function, serviceMemberName);

                var result = InnerInvoke(Context, a1, a2, a3, a4, a5, function);

                OperationPostInvoke(Context, result, a1, a2, a3, a4, a5, function, serviceMemberName);

                return result;
            });

            return wrapper(arg1, arg2, arg3, arg4, arg5);
        }

        protected TResult Invoke<T1, T2, T3, T4, T5, T6, TResult>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> function, [CallerMemberName] string serviceMemberName = null)
        {
            var wrapper = new Func<T1, T2, T3, T4, T5, T6, TResult>((a1, a2, a3, a4, a5, a6) =>
            {
                var authenticated = AuthenticateInvoke(Context, a1, a2, a3, a4, a5, a6, function, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var AuthorizeInvoked = AuthorizeInvoke(Context, a1, a2, a3, a4, a5, a6, function, serviceMemberName);

                if (!AuthorizeInvoked)
                    throw new AuthorizationException();

                OperationPreInvoke(Context, a1, a2, a3, a4, a5, a6, function, serviceMemberName);

                var result = InnerInvoke(Context, a1, a2, a3, a4, a5, a6, function);

                OperationPostInvoke(Context, result, a1, a2, a3, a4, a5, a6, function, serviceMemberName);

                return result;
            });

            return wrapper(arg1, arg2, arg3, arg4, arg5, arg6);
        }

        #endregion

        #region void InnerInvoke overloads

        //private void InnerInvoke(TContext context, Action action, params object[] input)
        //{
        //    try
        //    {
        //        action();
        //    }
        //    catch (Exception e)
        //    {
        //        RaiseError("InnerInvoke", context, null, e, input);
        //        throw new FaultException(e);
        //    }

        //}

        private void InnerInvoke(TContext context, Action action)
        {
            try
            {
                action();
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e);
                throw new FaultException(e);
            }

        }

        private void InnerInvoke<T1>(TContext context, T1 arg1, Action<T1> action)
        {
            try
            {
                action(arg1);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1);
                throw new FaultException(e);
            }

        }

        private void InnerInvoke<T1, T2>(TContext context, T1 arg1, T2 arg2, Action<T1, T2> action)
        {
            try
            {
                action(arg1, arg2);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2);
                throw new FaultException(e);
            }

        }
        private void InnerInvoke<T1, T2, T3>(TContext context, T1 arg1, T2 arg2, T3 arg3, Action<T1, T2, T3> action)
        {
            try
            {
                action(arg1, arg2, arg3);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3);
                throw new FaultException(e);
            }

        }
        private void InnerInvoke<T1, T2, T3, T4>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Action<T1, T2, T3, T4> action)
        {
            try
            {
                action(arg1, arg2, arg3, arg4);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4);
                throw new FaultException(e);
            }

        }

        private void InnerInvoke<T1, T2, T3, T4, T5>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Action<T1, T2, T3, T4, T5> action)
        {
            try
            {
                action(arg1, arg2, arg3, arg4, arg5);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5);
                throw new FaultException(e);
            }

        }

        private void InnerInvoke<T1, T2, T3, T4, T5, T6>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Action<T1, T2, T3, T4, T5, T6> action)
        {
            try
            {
                action(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5, arg6);
                throw new FaultException(e);
            }

        }

        #endregion

        #region TResult InnerInvoke overloads

        //private TResult InnerInvoke<TResult>(TContext context, object[] input, Func<TResult> func)
        //{
        //    try
        //    {
        //        return func();
        //    }
        //    catch (Exception e)
        //    {
        //        RaiseError("InnerInvoke", context, null, e, input);
        //        throw new FaultException(e);
        //    }

        //}

        //private TResult InnerInvoke<TResult>(TContext context, object[] input, Func<object[], TResult> func)
        //{
        //    try
        //    {
        //        return func(input);
        //    }
        //    catch (Exception e)
        //    {
        //        RaiseError("InnerInvoke", context, null, e, input);
        //        throw new FaultException(e);
        //    }

        //}

        private TResult InnerInvoke<TResult>(TContext context, Func<TResult> func)
        {
            try
            {
                return func();
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e);
                throw new FaultException(e);
            }

        }

        private TResult InnerInvoke<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func)
        {
            try
            {
                return func(arg1);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1);
                throw new FaultException(e);
            }

        }

        private TResult InnerInvoke<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func)
        {
            try
            {
                return func(arg1, arg2);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2);
                throw new FaultException(e);
            }

        }

        private TResult InnerInvoke<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func)
        {
            try
            {
                return func(arg1, arg2, arg3);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3);
                throw new FaultException(e);
            }

        }

        private TResult InnerInvoke<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func)
        {
            try
            {
                return func(arg1, arg2, arg3, arg4);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4);
                throw new FaultException(e);
            }

        }

        private TResult InnerInvoke<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func)
        {
            try
            {
                return func(arg1, arg2, arg3, arg4, arg5);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5);
                throw new FaultException(e);
            }

        }

        private TResult InnerInvoke<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func)
        {
            try
            {
                return func(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            catch (Exception e)
            {
                RaiseError("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5, arg6);
                throw new FaultException(e);
            }

        }

        #endregion

        #endregion

        #region asynchronous methods

        #region Task<TResult> InvokeAsync overloads

        protected async Task<TReturn> InvokeAsync<TReturn>(Func<Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<Task<TReturn>>(async () =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, func, serviceMemberName);

                var result = await InnerInvokeAsync(Context, func);

                await OperationPostInvokeAsync(Context, result, func, serviceMemberName);

                return result;
            });

            return await action();

        }

        protected async Task<TReturn> InvokeAsync<T1, TReturn>(T1 arg1, Func<T1, Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, Task<TReturn>>(async (a1) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, func, serviceMemberName);

                var result = await InnerInvokeAsync(Context, a1, func);

                await OperationPostInvokeAsync(Context, result, a1, func, serviceMemberName);

                return result;
            });

            return await action(arg1);

        }
        protected async Task<TReturn> InvokeAsync<T1, T2, TReturn>(T1 arg1, T2 arg2, Func<T1, T2, Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, Task<TReturn>>(async (a1, a2) =>
             {
                 var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, func, serviceMemberName);

                 if (!authenticated)
                     throw new AuthenticationException();

                 var authorized = await AuthorizeInvokeAsync(Context, a1, a2, func, serviceMemberName);

                 if (!authorized)
                     throw new AuthorizationException();

                 await OperationPreInvokeAsync(Context, a1, a2, func, serviceMemberName);

                 var result = await InnerInvokeAsync(Context, a1, a2, func);

                 await OperationPostInvokeAsync(Context, result, a1, a2, func, serviceMemberName);

                 return result;
             });

            return await action(arg1, arg2);

        }
        protected async Task<TReturn> InvokeAsync<T1, T2, T3, TReturn>(T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, Task<TReturn>>(async (a1, a2, a3) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, func, serviceMemberName);

                var result = await InnerInvokeAsync(Context, a1, a2, a3, func);

                await OperationPostInvokeAsync(Context, result, a1, a2, a3, func, serviceMemberName);

                return result;
            });

            return await action(arg1, arg2, arg3);

        }

        protected async Task<TReturn> InvokeAsync<T1, T2, T3, T4, TReturn>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, T4, Task<TReturn>>(async (a1, a2, a3, a4) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, a4, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, a4, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, a4, func, serviceMemberName);

                var result = await InnerInvokeAsync(Context, a1, a2, a3, a4, func);

                await OperationPostInvokeAsync(Context, result, a1, a2, a3, a4, func, serviceMemberName);

                return result;
            });

            return await action(arg1, arg2, arg3, arg4);

        }

        protected async Task<TReturn> InvokeAsync<T1, T2, T3, T4, T5, TReturn>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, T4, T5, Task<TReturn>>(async (a1, a2, a3, a4, a5) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, a4, a5, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, a4, a5, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, a4, a5, func, serviceMemberName);

                var result = await InnerInvokeAsync(Context, a1, a2, a3, a4, a5, func);

                await OperationPostInvokeAsync(Context, result, a1, a2, a3, a4, a5, func, serviceMemberName);

                return result;
            });

            return await action(arg1, arg2, arg3, arg4, arg5);

        }

        protected async Task<TReturn> InvokeAsync<T1, T2, T3, T4, T5, T6, TReturn>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, Task<TReturn>> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, T4, T5, T6, Task<TReturn>>(async (a1, a2, a3, a4, a5, a6) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                var result = await InnerInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func);

                await OperationPostInvokeAsync(Context, result, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                return result;
            });

            return await action(arg1, arg2, arg3, arg4, arg5, arg6);

        }

        #endregion

        #region Task InvokeAsync overloads

        protected async Task InvokeAsync(Func<Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<Task>(async () =>
           {
               var authenticated = await AuthenticateInvokeAsync(Context, func, serviceMemberName);

               if (!authenticated)
                   throw new AuthenticationException();

               var authorized = await AuthorizeInvokeAsync(Context, func, serviceMemberName);

               if (!authorized)
                   throw new AuthorizationException();

               await OperationPreInvokeAsync(Context, func, serviceMemberName);

               await InnerInvokeAsync(Context, func);

               await OperationPostInvokeAsync(Context, null, func, serviceMemberName);

           });

            await action();

        }

        protected async Task InvokeAsync<T1>(T1 arg1, Func<T1, Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, Task>(async (a1) =>
             {
                 var authenticated = await AuthenticateInvokeAsync(Context, a1, func, serviceMemberName);

                 if (!authenticated)
                     throw new AuthenticationException();

                 var authorized = await AuthorizeInvokeAsync(Context, a1, func, serviceMemberName);

                 if (!authorized)
                     throw new AuthorizationException();

                 await OperationPreInvokeAsync(Context, a1, func, serviceMemberName);

                 await InnerInvokeAsync(Context, a1, func);

                 await OperationPostInvokeAsync(Context, null, a1, func, serviceMemberName);

             });

            await action(arg1);

        }

        protected async Task InvokeAsync<T1, T2>(T1 arg1, T2 arg2, Func<T1, T2, Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, Task>(async (a1, a2) =>
             {
                 var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, func, serviceMemberName);

                 if (!authenticated)
                     throw new AuthenticationException();

                 var authorized = await AuthorizeInvokeAsync(Context, a1, a2, func, serviceMemberName);

                 if (!authorized)
                     throw new AuthorizationException();

                 await OperationPreInvokeAsync(Context, a1, a2, func, serviceMemberName);

                 await InnerInvokeAsync(Context, a1, a2, func);

                 await OperationPostInvokeAsync(Context, null, a1, a2, func, serviceMemberName);

             });

            await action(arg1, arg2);

        }

        protected async Task InvokeAsync<T1, T2, T3>(T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, Task>(async (a1, a2, a3) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, func, serviceMemberName);

                await InnerInvokeAsync(Context, a1, a2, a3, func);

                await OperationPostInvokeAsync(Context, null, a1, a2, a3, func, serviceMemberName);

            });

            await action(arg1, arg2, arg3);

        }

        protected async Task InvokeAsync<T1, T2, T3, T4>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, T4, Task>(async (a1, a2, a3, a4) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, a4, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, a4, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, a4, func, serviceMemberName);

                await InnerInvokeAsync(Context, a1, a2, a3, a4, func);

                await OperationPostInvokeAsync(Context, null, a1, a2, a3, a4, func, serviceMemberName);

            });

            await action(arg1, arg2, arg3, arg4);

        }

        protected async Task InvokeAsync<T1, T2, T3, T4, T5>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, T4, T5, Task>(async (a1, a2, a3, a4, a5) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, a4, a5, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, a4, a5, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, a4, a5, func, serviceMemberName);

                await InnerInvokeAsync(Context, a1, a2, a3, a4, a5, func);

                await OperationPostInvokeAsync(Context, null, a1, a2, a3, a4, a5, func, serviceMemberName);

            });

            await action(arg1, arg2, arg3, arg4, arg5);

        }

        protected async Task InvokeAsync<T1, T2, T3, T4, T5, T6>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, Task> func, [CallerMemberName] string serviceMemberName = null)
        {

            var action = new Func<T1, T2, T3, T4, T5, T6, Task>(async (a1, a2, a3, a4, a5, a6) =>
            {
                var authenticated = await AuthenticateInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                if (!authenticated)
                    throw new AuthenticationException();

                var authorized = await AuthorizeInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                if (!authorized)
                    throw new AuthorizationException();

                await OperationPreInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

                await InnerInvokeAsync(Context, a1, a2, a3, a4, a5, a6, func);

                await OperationPostInvokeAsync(Context, null, a1, a2, a3, a4, a5, a6, func, serviceMemberName);

            });

            await action(arg1, arg2, arg3, arg4, arg5, arg6);

        }

        #endregion

        #region Task<TResult> InnerInvokeAsync overloads

        private async Task<TResult> InnerInvokeAsync<TResult>(TContext context, Func<Task<TResult>> func)
        {
            try
            {
                return await func();
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e);
                throw new FaultException(e);
            }

        }

        private async Task<TResult> InnerInvokeAsync<T1, TResult>(TContext context, T1 arg1, Func<T1, Task<TResult>> func)
        {
            try
            {
                return await func(arg1);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1);
                throw new FaultException(e);
            }

        }

        private async Task<TResult> InnerInvokeAsync<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, Task<TResult>> func)
        {
            try
            {
                return await func(arg1, arg2);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2);
                throw new FaultException(e);
            }

        }

        private async Task<TResult> InnerInvokeAsync<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, Task<TResult>> func)
        {
            try
            {
                return await func(arg1, arg2, arg3);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3);
                throw new FaultException(e);
            }

        }

        private async Task<TResult> InnerInvokeAsync<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, Task<TResult>> func)
        {
            try
            {
                return await func(arg1, arg2, arg3, arg4);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4);
                throw new FaultException(e);
            }

        }

        private async Task<TResult> InnerInvokeAsync<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, Task<TResult>> func)
        {
            try
            {
                return await func(arg1, arg2, arg3, arg4, arg5);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5);
                throw new FaultException(e);
            }

        }

        private async Task<TResult> InnerInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, Task<TResult>> func)
        {
            try
            {
                return await func(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5, arg6);
                throw new FaultException(e);
            }

        }

        #endregion

        #region Task InnverInvokeAsync overloads

        private async Task InnerInvokeAsync(TContext context, Func<Task> func)
        {
            try
            {
                await func();
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e);
                throw new FaultException(e);
            }

        }

        private async Task InnerInvokeAsync<T1>(TContext context, T1 arg1, Func<T1, Task> func)
        {
            try
            {
                await func(arg1);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1);
                throw new FaultException(e);
            }

        }

        private async Task InnerInvokeAsync<T1, T2>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, Task> func)
        {
            try
            {
                await func(arg1, arg2);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2);
                throw new FaultException(e);
            }

        }

        private async Task InnerInvokeAsync<T1, T2, T3>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, Task> func)
        {
            try
            {
                await func(arg1, arg2, arg3);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3);
                throw new FaultException(e);
            }

        }

        private async Task InnerInvokeAsync<T1, T2, T3, T4>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, Task> func)
        {
            try
            {
                await func(arg1, arg2, arg3, arg4);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4);
                throw new FaultException(e);
            }

        }

        private async Task InnerInvokeAsync<T1, T2, T3, T4, T5>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, Task> func)
        {
            try
            {
                await func(arg1, arg2, arg3, arg4, arg5);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5);
                throw new FaultException(e);
            }

        }

        private async Task InnerInvokeAsync<T1, T2, T3, T4, T5, T6>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, Task> func)
        {
            try
            {
                await func(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync("InnerInvoke", context, null, e, arg1, arg2, arg3, arg4, arg5, arg6);
                throw new FaultException(e);
            }

        }

        #endregion

        #endregion

        #region OnError

        private async Task RaiseErrorAsync(string source, TContext context, object result, Exception exception, params object[] input)
        {
            try
            {
                var sender = this;
                var args = new ErrorEventArgs
                {
                    Context = context,
                    Result = result,
                    Exception = exception,
                    Input = input,
                    Source = source
                };

                Func<EventHandler<ErrorEventArgs>, Task> taskFactory = d => new Task(() => d(sender, args));

                await AsyncErrorEventRaiser(OnError, taskFactory);

            }
            catch (Exception)
            {
                //Hide any errors in the error handling or just throw them strait up?
            }
        }

        private void RaiseError(string source, TContext context, object result, Exception exception, params object[] input)
        {
            if (OnError == null)
                return;

            try
            {



                var sender = this;
                var args = new ErrorEventArgs
                {
                    Context = context,
                    Result = result,
                    Exception = exception,
                    Input = input,
                    Source = source
                };

                OnError(sender, args);

            }
            catch (Exception)
            {
                //Hide any errors in the error handling or just throw them strait up?
            }
        }

        [DataContract]
        public class ErrorEventArgs
        {
            [DataMember]
            public TContext Context { get; set; }
            [DataMember]
            public object[] Input { get; set; }
            [DataMember]
            public Exception Exception { get; set; }
            [DataMember]
            public string Source { get; set; }
            [DataMember]
            public object Result { get; set; }
        }

        #endregion

        #region OnAuthenticate

        private async Task<bool?> AuthenticateAsync(TContext context, params object[] input)
        {
            if (OnAuthenticate == null)
                return null;

            var handlers = OnAuthenticate.GetInvocationList();
            if (0 == handlers.Length)
                return null;

            Func<Delegate, Task<bool>> taskFactory = (d) => new Task<bool>(() => ((OnAuthenticateHandler)d)(context, input));

            Func<bool, bool, bool> fAggregate = (seed, result) => seed && result;

            return await AsyncEventRaiser(context, input, handlers, taskFactory, fAggregate, true);
        }

        private bool? Authenticate(TContext context, params object[] input)
        {
            if (OnAuthenticate == null)
                return null;

            var handlers = OnAuthenticate.GetInvocationList();
            if (0 == handlers.Length)
                return null;

            var auth = true;
            foreach (var authHandler in handlers)
            {
                auth = auth && ((OnAuthenticateHandler)authHandler)(context, input);
                if (!auth)
                    return false;
            }

            return auth;

        }

        public delegate bool OnAuthenticateHandler(TContext context, object[] input);



        #region AuthenticateInvoke

        private bool AuthenticateInvoke(TContext context, Action action, string serviceMemberName)
        {
            var authenticated = Authenticate(context);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context);
        }

        private bool AuthenticateInvoke<T1>(TContext context, T1 arg1, Action<T1> action, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1);
        }

        private bool AuthenticateInvoke<T1, T2>(TContext context, T1 arg1, T2 arg2, Action<T1, T2> action, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2);
        }

        private bool AuthenticateInvoke<T1, T2, T3>(TContext context, T1 arg1, T2 arg2, T3 arg3, Action<T1, T2, T3> action, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3);
        }

        private bool AuthenticateInvoke<T1, T2, T3, T4>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Action<T1, T2, T3, T4> action, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3, arg4);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3, arg4);
        }

        private bool AuthenticateInvoke<T1, T2, T3, T4, T5>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Action<T1, T2, T3, T4, T5> action, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3, arg4, arg5);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private bool AuthenticateInvoke<T1, T2, T3, T4, T5, T6>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Action<T1, T2, T3, T4, T5, T6> action, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3, arg4, arg5, arg6);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private bool AuthenticateInvoke<TResult>(TContext context, Func<TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context);
        }

        private bool AuthenticateInvoke<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1);
        }

        private bool AuthenticateInvoke<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2);
        }

        private bool AuthenticateInvoke<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3);
        }

        private bool AuthenticateInvoke<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3, arg4);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3, arg4);
        }

        private bool AuthenticateInvoke<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3, arg4, arg5);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private bool AuthenticateInvoke<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            var authenticated = Authenticate(context, arg1, arg2, arg3, arg4, arg5, arg6);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private async Task<bool> AuthenticateInvokeAsync<TResult>(TContext context, Func<TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context);
        }

        private async Task<bool> AuthenticateInvokeAsync<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context, arg1);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context, arg1);
        }

        private async Task<bool> AuthenticateInvokeAsync<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context, arg1, arg2);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context, arg1, arg2);
        }

        private async Task<bool> AuthenticateInvokeAsync<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context, arg1, arg2, arg3);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context, arg1, arg2, arg3);
        }

        private async Task<bool> AuthenticateInvokeAsync<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context, arg1, arg2, arg3, arg4);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context, arg1, arg2, arg3, arg4);
        }

        private async Task<bool> AuthenticateInvokeAsync<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context, arg1, arg2, arg3, arg4, arg5);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private async Task<bool> AuthenticateInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            var authenticated = await AuthenticateAsync(context, arg1, arg2, arg3, arg4, arg5, arg6);
            if (authenticated.HasValue && !authenticated.Value)
                return false;

            var handler = AuthenticateInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authenticated.HasValue && authenticated.Value;

            return await handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        #endregion

        #region OnAuthenticateInvoke

        public void OnAuthenticateInvoke(Action forMember, Func<TContext, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1>(Action<T1> forMember, Func<TContext, T1, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<TResult>(Func<TResult> forMember, Func<TContext, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, TResult>(Func<T1, TResult> forMember, Func<TContext, T1, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Func<TContext, T1, T2, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Func<TContext, T1, T2, T3, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Func<TContext, T1, T2, T3, T4, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvoke<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, bool> handler)
        {
            AuthenticateInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync(Action forMember, Func<TContext, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1>(Action<T1> forMember, Func<TContext, T1, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<TResult>(Func<TResult> forMember, Func<TContext, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, TResult>(Func<T1, TResult> forMember, Func<TContext, T1, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Func<TContext, T1, T2, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Func<TContext, T1, T2, T3, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Func<TContext, T1, T2, T3, T4, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthenticateInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task<bool>> handler)
        {
            AuthenticateInvokeAsyncHandlers.Register(forMember, handler);
        }

        #endregion

        #endregion

        #region OnAuthorize

        private async Task<bool?> AuthorizeAsync(TContext context, params object[] input)
        {
            if (OnAuthorize == null)
                return null;

            var handlers = OnAuthorize.GetInvocationList();
            if (0 == handlers.Length)
                return null;

            Func<Delegate, Task<bool>> taskFactory = (d) => new Task<bool>(() => ((OnAuthorizeHandler)d)(context, input));

            //Provide function for aggregating handler results of all handlers
            Func<bool, bool, bool> fAggregate = (seed, result) => seed && result;

            return await AsyncEventRaiser(context, input, handlers, taskFactory, fAggregate, true);
        }


        private bool? Authorize(TContext context, params object[] input)
        {
            if (OnAuthorize == null)
                return null;

            var handlers = OnAuthorize.GetInvocationList();
            if (0 == handlers.Length)
                return null;

            var autorized = true;
            foreach (var autorizeHandler in OnAuthorize.GetInvocationList())
            {
                autorized = autorized && ((OnAuthorizeHandler)autorizeHandler)(context, input);
                if (!autorized)
                    return false;
            }

            return autorized;
        }


        public delegate bool OnAuthorizeHandler(TContext context, object[] input);
        #region AuthorizeInvoke

        private bool AuthorizeInvoke(TContext context, Action action, string serviceMemberName)
        {
            var authorized = Authorize(context);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context);
        }

        private bool AuthorizeInvoke<T1>(TContext context, T1 arg1, Action<T1> action, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1);
        }

        private bool AuthorizeInvoke<T1, T2>(TContext context, T1 arg1, T2 arg2, Action<T1, T2> action, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2);
        }

        private bool AuthorizeInvoke<T1, T2, T3>(TContext context, T1 arg1, T2 arg2, T3 arg3, Action<T1, T2, T3> action, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3);
        }

        private bool AuthorizeInvoke<T1, T2, T3, T4>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Action<T1, T2, T3, T4> action, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3, arg4);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3, arg4);
        }

        private bool AuthorizeInvoke<T1, T2, T3, T4, T5>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Action<T1, T2, T3, T4, T5> action, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3, arg4, arg5);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private bool AuthorizeInvoke<T1, T2, T3, T4, T5, T6>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Action<T1, T2, T3, T4, T5, T6> action, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3, arg4, arg5, arg6);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private bool AuthorizeInvoke<TResult>(TContext context, Func<TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context);
        }

        private bool AuthorizeInvoke<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1);
        }

        private bool AuthorizeInvoke<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2);
        }

        private bool AuthorizeInvoke<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3);
        }

        private bool AuthorizeInvoke<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3, arg4);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3, arg4);
        }

        private bool AuthorizeInvoke<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3, arg4, arg5);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private bool AuthorizeInvoke<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            var authorized = Authorize(context, arg1, arg2, arg3, arg4, arg5, arg6);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private async Task<bool> AuthorizeInvokeAsync<TResult>(TContext context, Func<TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return await handler(context);
        }

        private async Task<bool> AuthorizeInvokeAsync<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context, arg1);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return await handler(context, arg1);
        }

        private async Task<bool> AuthorizeInvokeAsync<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context, arg1, arg2);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return await handler(context, arg1, arg2);
        }

        private async Task<bool> AuthorizeInvokeAsync<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context, arg1, arg2, arg3);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return await handler(context, arg1, arg2, arg3);
        }

        private async Task<bool> AuthorizeInvokeAsync<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context, arg1, arg2, arg3, arg4);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return await handler(context, arg1, arg2, arg3, arg4);
        }

        private async Task<bool> AuthorizeInvokeAsync<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context, arg1, arg2, arg3, arg4, arg5);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return authorized.HasValue && authorized.Value;

            return await handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private async Task<bool> AuthorizeInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            var authorized = await AuthorizeAsync(context, arg1, arg2, arg3, arg4, arg5, arg6);
            if (authorized.HasValue && !authorized.Value)
                return false;

            var handler = AuthorizeInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return true;

            return await handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        #endregion

        #region OnAuthorizeInvoke

        public void OnAuthorizeInvoke(Action forMember, Func<TContext, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1>(Action<T1> forMember, Func<TContext, T1, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<TResult>(Func<TResult> forMember, Func<TContext, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, TResult>(Func<T1, TResult> forMember, Func<TContext, T1, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Func<TContext, T1, T2, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Func<TContext, T1, T2, T3, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Func<TContext, T1, T2, T3, T4, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvoke<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, bool> handler)
        {
            AuthorizeInvokeHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync(Action forMember, Func<TContext, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1>(Action<T1> forMember, Func<TContext, T1, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<TResult>(Func<TResult> forMember, Func<TContext, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, TResult>(Func<T1, TResult> forMember, Func<TContext, T1, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Func<TContext, T1, T2, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Func<TContext, T1, T2, T3, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Func<TContext, T1, T2, T3, T4, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnAuthorizeInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task<bool>> handler)
        {
            AuthorizeInvokeAsyncHandlers.Register(forMember, handler);
        }

        #endregion

        #endregion

        #region OnPreInvoke

        public class PreInvokeArgs
        {
            public TContext Context { get; set; }
            public object[] Input { get; set; }
        }

        protected virtual async Task PreInvokeAsync(TContext context, params object[] input)
        {
            if (OnPreInvoke == null)
                return;

            var sender = this;
            var args = new PreInvokeArgs()
            {
                Context = context,
                Input = input
            };

            Func<Delegate, Task> taskFactory = (d) => new Task(() => ((EventHandler<PreInvokeArgs>)d)(sender, args));

            await AsyncEventRaiser(context, input, OnPreInvoke, taskFactory);

        }

        protected virtual void PreInvoke(TContext context, params object[] input)
        {
            if (OnPreInvoke == null)
                return;

            var sender = this;
            var args = new PreInvokeArgs()
            {
                Context = context,
                Input = input
            };

            OnPreInvoke(sender, args);

        }

        #region OperationPreInvoke



        private void OperationPreInvoke(TContext context, Action action, string serviceMemberName)
        {
            PreInvoke(context);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context);
        }

        private void OperationPreInvoke<T1>(TContext context, T1 arg1, Action<T1> action, string serviceMemberName)
        {
            PreInvoke(context, arg1);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1);
        }

        private void OperationPreInvoke<T1, T2>(TContext context, T1 arg1, T2 arg2, Action<T1, T2> action, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2);
        }

        private void OperationPreInvoke<T1, T2, T3>(TContext context, T1 arg1, T2 arg2, T3 arg3, Action<T1, T2, T3> action, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3);
        }

        private void OperationPreInvoke<T1, T2, T3, T4>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Action<T1, T2, T3, T4> action, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3, arg4);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4);
        }

        private void OperationPreInvoke<T1, T2, T3, T4, T5>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Action<T1, T2, T3, T4, T5> action, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3, arg4, arg5);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private void OperationPreInvoke<T1, T2, T3, T4, T5, T6>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Action<T1, T2, T3, T4, T5, T6> action, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PreInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private void OperationPreInvoke<TResult>(TContext context, Func<TResult> func, string serviceMemberName)
        {
            PreInvoke(context);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context);
        }

        private void OperationPreInvoke<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            PreInvoke(context, arg1);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1);
        }

        private void OperationPreInvoke<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2);
        }

        private void OperationPreInvoke<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3);
        }

        private void OperationPreInvoke<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3, arg4);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4);
        }

        private void OperationPreInvoke<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3, arg4, arg5);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private void OperationPreInvoke<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            PreInvoke(context, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PreInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private async Task OperationPreInvokeAsync<TResult>(TContext context, Func<TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context);
        }

        private async Task OperationPreInvokeAsync<T1, TResult>(TContext context, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context, arg1);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1);
        }

        private async Task OperationPreInvokeAsync<T1, T2, TResult>(TContext context, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context, arg1, arg2);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2);
        }

        private async Task OperationPreInvokeAsync<T1, T2, T3, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context, arg1, arg2, arg3);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3);
        }

        private async Task OperationPreInvokeAsync<T1, T2, T3, T4, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context, arg1, arg2, arg3, arg4);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4);
        }

        private async Task OperationPreInvokeAsync<T1, T2, T3, T4, T5, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context, arg1, arg2, arg3, arg4, arg5);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private async Task OperationPreInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            await PreInvokeAsync(context, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PreInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }



        #endregion

        #region OnOperationPreInvoke

        public void OnOperationPreInvoke(Action forMember, Action<TContext> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1>(Action<T1> forMember, Action<TContext, T1> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2>(Action<T1, T2> forMember, Action<TContext, T1, T2> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3>(Action<T1, T2, T3> forMember, Action<TContext, T1, T2, T3> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Action<TContext, T1, T2, T3, T4> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Action<TContext, T1, T2, T3, T4, T5> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<TResult>(Func<TResult> forMember, Action<TContext> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, TResult>(Func<T1, TResult> forMember, Action<TContext, T1> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Action<TContext, T1, T2> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Action<TContext, T1, T2, T3> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Action<TContext, T1, T2, T3, T4> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Action<TContext, T1, T2, T3, T4, T5> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvoke<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler)
        {
            PreInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync(Action forMember, Func<TContext, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1>(Action<T1> forMember, Func<TContext, T1, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<TResult>(Func<TResult> forMember, Func<TContext, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, TResult>(Func<T1, TResult> forMember, Func<TContext, T1, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Func<TContext, T1, T2, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Func<TContext, T1, T2, T3, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Func<TContext, T1, T2, T3, T4, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPreInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task> handler)
        {
            PreInvokeAsyncHandlers.Register(forMember, handler);
        }

        #endregion

        #endregion

        #region OnPostInvoke

        public class PostInvokeArgs
        {

            // ReSharper disable once UnusedAutoPropertyAccessor.Global
            public TContext Context { get; set; }

            // ReSharper disable once UnusedAutoPropertyAccessor.Global
            public object[] Input { get; set; }

            public object Result { get; set; }
        }

        protected virtual async Task PostInvokeAsync(TContext context, object result, params object[] input)
        {
            if (OnPostInvoke == null)
                return;

            var sender = this;
            var args = new PostInvokeArgs()
            {
                Context = context,
                Input = input,
                Result = result
            };

            Func<Delegate, Task> taskFactory = (d) => new Task(() => ((EventHandler<PostInvokeArgs>)d)(sender, args));

            await AsyncEventRaiser(context, input, OnPostInvoke, taskFactory, result);
        }

        protected virtual void PostInvoke(TContext context, object result, params object[] input)
        {
            if (OnPostInvoke == null)
                return;

            var sender = this;
            var args = new PostInvokeArgs()
            {
                Context = context,
                Input = input,
                Result = result
            };

            OnPostInvoke(sender, args);
        }

        #region OperationPostInvoke



        private void OperationPostInvoke(TContext context, Action action, string serviceMemberName)
        {
            PostInvoke(context, null);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context);
        }

        private void OperationPostInvoke<T1>(TContext context, T1 arg1, Action<T1> action, string serviceMemberName)
        {
            PostInvoke(context, null, arg1);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1);
        }

        private void OperationPostInvoke<T1, T2>(TContext context, T1 arg1, T2 arg2, Action<T1, T2> action, string serviceMemberName)
        {
            PostInvoke(context, null, arg1, arg2);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2);
        }

        private void OperationPostInvoke<T1, T2, T3>(TContext context, T1 arg1, T2 arg2, T3 arg3, Action<T1, T2, T3> action, string serviceMemberName)
        {
            PostInvoke(context, null, arg1, arg2, arg3);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3);
        }

        private void OperationPostInvoke<T1, T2, T3, T4>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Action<T1, T2, T3, T4> action, string serviceMemberName)
        {
            PostInvoke(context, null, arg1, arg2, arg3, arg4);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4);
        }

        private void OperationPostInvoke<T1, T2, T3, T4, T5>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Action<T1, T2, T3, T4, T5> action, string serviceMemberName)
        {
            PostInvoke(context, null, arg1, arg2, arg3, arg4, arg5);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private void OperationPostInvoke<T1, T2, T3, T4, T5, T6>(TContext context, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Action<T1, T2, T3, T4, T5, T6> action, string serviceMemberName)
        {
            PostInvoke(context, null, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PostInvokeHandlers.GetActionHandler(action, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private void OperationPostInvoke<TResult>(TContext context, TResult result, Func<TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context);
        }

        private void OperationPostInvoke<T1, TResult>(TContext context, TResult result, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result, arg1);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1);
        }

        private void OperationPostInvoke<T1, T2, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result, arg1, arg2);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2);
        }

        private void OperationPostInvoke<T1, T2, T3, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result, arg1, arg2, arg3);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3);
        }

        private void OperationPostInvoke<T1, T2, T3, T4, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result, arg1, arg2, arg3, arg4);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4);
        }

        private void OperationPostInvoke<T1, T2, T3, T4, T5, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result, arg1, arg2, arg3, arg4, arg5);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private void OperationPostInvoke<T1, T2, T3, T4, T5, T6, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            PostInvoke(context, result, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PostInvokeHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private async Task OperationPostInvokeAsync<TResult>(TContext context, TResult result, Func<TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context);
        }

        private async Task OperationPostInvokeAsync<T1, TResult>(TContext context, TResult result, T1 arg1, Func<T1, TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1);
        }

        private async Task OperationPostInvokeAsync<T1, T2, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, Func<T1, T2, TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, T4, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3, arg4);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, T4, T5, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3, arg4, arg5);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, TResult> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }

        private async Task OperationPostInvokeAsync<TResult>(TContext context, TResult result, Func<Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context);
        }

        private async Task OperationPostInvokeAsync<T1, TResult>(TContext context, TResult result, T1 arg1, Func<T1, Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1);
        }

        private async Task OperationPostInvokeAsync<T1, T2, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, Func<T1, T2, Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, Func<T1, T2, T3, Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, T4, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, Func<T1, T2, T3, T4, Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3, arg4);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, T4, T5, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, Func<T1, T2, T3, T4, T5, Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3, arg4, arg5);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4, arg5);
        }

        private async Task OperationPostInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(TContext context, TResult result, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, Func<T1, T2, T3, T4, T5, T6, Task<TResult>> func, string serviceMemberName)
        {
            await PostInvokeAsync(context, result, arg1, arg2, arg3, arg4, arg5, arg6);

            var handler = PostInvokeAsyncHandlers.GetFuncHandler(func, serviceMemberName);
            if (null == handler)
                return;

            await handler(context, arg1, arg2, arg3, arg4, arg5, arg6);
        }



        #endregion

        #region OnOperationPostInvoke

        public void OnOperationPostInvoke(Action forMember, Action<TContext> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1>(Action<T1> forMember, Action<TContext, T1> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2>(Action<T1, T2> forMember, Action<TContext, T1, T2> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3>(Action<T1, T2, T3> forMember, Action<TContext, T1, T2, T3> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Action<TContext, T1, T2, T3, T4> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Action<TContext, T1, T2, T3, T4, T5> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<TResult>(Func<TResult> forMember, Action<TContext> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, TResult>(Func<T1, TResult> forMember, Action<TContext, T1> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Action<TContext, T1, T2> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Action<TContext, T1, T2, T3> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Action<TContext, T1, T2, T3, T4> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Action<TContext, T1, T2, T3, T4, T5> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvoke<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler)
        {
            PostInvokeHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync(Action forMember, Func<TContext, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1>(Action<T1> forMember, Func<TContext, T1, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<TResult>(Func<TResult> forMember, Func<TContext, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, TResult>(Func<T1, TResult> forMember, Func<TContext, T1, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, TResult>(Func<T1, T2, TResult> forMember, Func<TContext, T1, T2, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, TResult>(Func<T1, T2, T3, TResult> forMember, Func<TContext, T1, T2, T3, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, T4, TResult>(Func<T1, T2, T3, T4, TResult> forMember, Func<TContext, T1, T2, T3, T4, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, T4, T5, TResult>(Func<T1, T2, T3, T4, T5, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        public void OnOperationPostInvokeAsync<T1, T2, T3, T4, T5, T6, TResult>(Func<T1, T2, T3, T4, T5, T6, TResult> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, Task> handler)
        {
            PostInvokeAsyncHandlers.Register(forMember, handler);
        }

        #endregion

        #endregion

        #region private helpers

        /// <summary>
        /// This helper for raising async events with a <typeparam name="TResult">TResult</typeparam> return type 
        /// catches any exception occuring in the hanlders and calls <see cref="RaiseErrorAsync"/> to report it before 
        /// throwing a <see cref="FaultException"/>
        /// </summary>
        private async Task<TResult> AsyncEventRaiser<TResult>(TContext context, object[] input, Delegate[] invocationList, Func<Delegate, Task<TResult>> taskFactory, Func<TResult, TResult, TResult> fAggregate, TResult aggregateResultSeed, [CallerMemberName] string callerName = null)
        {
            try
            {
                var handlerTasks = new Task<TResult>[invocationList.Length];

                for (var i = 0; i < invocationList.Length; i++)
                {
                    var invocation = invocationList[i];
                    Task<TResult> task;
                    handlerTasks[i] = task = taskFactory(invocation);
                    task.Start();
                }

                var results = await Task.WhenAll(handlerTasks);

                //return the aggregate of all handler results..
                return results.Aggregate(aggregateResultSeed, fAggregate);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync(callerName, context, null, e, input);

                throw new FaultException(e);
            }
        }

        /// <summary>
        /// This helper for raising async events without a return type catches any exception occuring in the hanlders and calls <see cref="RaiseErrorAsync"/> to report it before throwing a <see cref="FaultException"/>
        /// </summary>
        private async Task AsyncEventRaiser(TContext context, object[] input, Delegate handler, Func<Delegate, Task> taskFactory, object result = null, [CallerMemberName]string callerName = null)
        {
            try
            {
                if (handler == null)
                {
                    //Do not authenticate by default
                    return;
                }


                var invocationList = handler.GetInvocationList();
                var handlerTasks = new Task[invocationList.Length];

                for (var i = 0; i < invocationList.Length; i++)
                {
                    var invocation = invocationList[i];
                    Task task;
                    handlerTasks[i] = task = taskFactory(invocation);
                    task.Start();
                }

                await Task.WhenAll(handlerTasks);
            }
            catch (Exception e)
            {
                await RaiseErrorAsync(callerName, context, result, e, input);
                throw new FaultException(e);
            }
        }


        /// <summary>
        /// This helper for raising async events simply throws any exception that occurs and does not call RaiseError to report it  (which could lead to endless recursion)
        /// </summary>
        private async Task AsyncErrorEventRaiser(EventHandler<ErrorEventArgs> handler, Func<EventHandler<ErrorEventArgs>, Task> taskFactory)
        {
            if (handler == null)
            {
                return;
            }


            var invocationList = handler.GetInvocationList();
            var handlerTasks = new Task[invocationList.Length];

            for (var i = 0; i < invocationList.Length; i++)
            {
                var invocation = (EventHandler<ErrorEventArgs>)invocationList[i];
                Task task;
                handlerTasks[i] = task = taskFactory(invocation);
                task.Start();
            }

            await Task.WhenAll(handlerTasks);

            Debug.Assert(handlerTasks.All(t => t.IsCompleted));
        }



        #endregion

    }

}