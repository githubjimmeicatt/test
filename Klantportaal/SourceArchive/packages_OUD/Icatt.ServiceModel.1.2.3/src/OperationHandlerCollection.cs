using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.ServiceModel
{
    internal class OperationHandlerCollection<TContext, THandlerResult> : IOperationHandlerCollection<TContext, THandlerResult>
    {
        private readonly Dictionary<string, Dictionary<Type, object>> _handlers = new Dictionary<string, Dictionary<Type, object>>();

        internal OperationHandlerCollection()
        {

        }

        #region Action Interceptors

        public Func<TContext, THandlerResult> GetActionHandler(Action forMember, string serviceMemberName)
        {
            return GetInterceptor<Action, Func<TContext, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, THandlerResult> GetActionHandler<T1>(Action<T1> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1>, Func<TContext, T1, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, THandlerResult> GetActionHandler<T1, T2>(Action<T1, T2> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2>, Func<TContext, T1, T2, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, THandlerResult> GetActionHandler<T1, T2, T3>(Action<T1, T2, T3> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3>, Func<TContext, T1, T2, T3, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, THandlerResult> GetActionHandler<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4>, Func<TContext, T1, T2, T3, T4, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5>, Func<TContext, T1, T2, T3, T4, T5, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5, T6>, Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5, T6, T7>, Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5, T6, T7, T8>, Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult>>(serviceMemberName);
        }

        #endregion

        #region Function Interceptors

        public Func<TContext, THandlerResult> GetFuncHandler<TReturn>(Func<TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<TReturn>, Func<TContext, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, THandlerResult> GetFuncHandler<T1, TReturn>(Func<T1, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, TReturn>, Func<TContext, T1, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, THandlerResult> GetFuncHandler<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, TReturn>, Func<TContext, T1, T2, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, THandlerResult> GetFuncHandler<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, TReturn>, Func<TContext, T1, T2, T3, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, THandlerResult> GetFuncHandler<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, TReturn>, Func<TContext, T1, T2, T3, T4, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, TReturn>, Func<TContext, T1, T2, T3, T4, T5, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, T6, TReturn>, Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, T6, T7, TReturn>, Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult>>(serviceMemberName);
        }

        public Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>, Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult>>(serviceMemberName);
        }

        #endregion


        #region Register Action Interceptors

        public void Register(Action forMember, Func<TContext, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1>(Action<T1> forMember, Func<TContext, T1, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }

        #endregion

        #region Register Function Interceptors

        public void Register<TReturn>(Func<TReturn> forMember, Func<TContext, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, TReturn>(Func<T1, TReturn> forMember, Func<TContext, T1, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, Func<TContext, T1, T2, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, Func<TContext, T1, T2, T3, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, Func<TContext, T1, T2, T3, T4, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }

        #endregion

        private THandler GetInterceptor<TMember, THandler>(string forMemberName) where TMember : class where THandler : class
        {
            Dictionary<Type, object> memberHandlers = null;
            if (!_handlers.ContainsKey(forMemberName))
            {
                return null;
            }
            memberHandlers = _handlers[forMemberName];
            var t = typeof(TMember);

            if (memberHandlers.ContainsKey(t))
            {
                var retval = memberHandlers[t];
                if (retval is THandler)
                    return (THandler)retval;
            }
            return null;
        }

        private void RegisterToCollection<TMember, THandler>(TMember forMember, string forMemberName, THandler handler)
        {
            Dictionary<Type, object> memberHandlers = null;
            if (!_handlers.ContainsKey(forMemberName))
            {
                memberHandlers = new Dictionary<Type, object>();
                _handlers.Add(forMemberName, memberHandlers);
            }
            else
            {
                memberHandlers = _handlers[forMemberName];
            }
            memberHandlers.Add(typeof(TMember), handler);
        }

    }


    internal class OperationHandlerCollection<TContext> : IOperationHandlerCollection<TContext>
    {
        private readonly Dictionary<string, Dictionary<Type, object>> _handlers = new Dictionary<string, Dictionary<Type, object>>();

        internal OperationHandlerCollection()
        {

        }

        #region Action Interceptors

        public Action<TContext> GetActionHandler(Action forMember, string serviceMemberName)
        {
            return GetInterceptor<Action, Action<TContext>>(serviceMemberName);
        }

        public Action<TContext, T1> GetActionHandler<T1>(Action<T1> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1>, Action<TContext, T1>>(serviceMemberName);
        }

        public Action<TContext, T1, T2> GetActionHandler<T1, T2>(Action<T1, T2> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2>, Action<TContext, T1, T2>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3> GetActionHandler<T1, T2, T3>(Action<T1, T2, T3> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3>, Action<TContext, T1, T2, T3>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4> GetActionHandler<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4>, Action<TContext, T1, T2, T3, T4>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5> GetActionHandler<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5>, Action<TContext, T1, T2, T3, T4, T5>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5, T6> GetActionHandler<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5, T6>, Action<TContext, T1, T2, T3, T4, T5, T6>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5, T6, T7> GetActionHandler<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5, T6, T7>, Action<TContext, T1, T2, T3, T4, T5, T6, T7>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> GetActionHandler<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, string serviceMemberName)
        {
            return GetInterceptor<Action<T1, T2, T3, T4, T5, T6, T7, T8>, Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8>>(serviceMemberName);
        }

        #endregion

        #region Function Interceptors

        public Action<TContext> GetFuncHandler<TReturn>(Func<TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<TReturn>, Action<TContext>>(serviceMemberName);
        }

        public Action<TContext, T1> GetFuncHandler<T1, TReturn>(Func<T1, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, TReturn>, Action<TContext, T1>>(serviceMemberName);
        }

        public Action<TContext, T1, T2> GetFuncHandler<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, TReturn>, Action<TContext, T1, T2>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3> GetFuncHandler<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, TReturn>, Action<TContext, T1, T2, T3>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4> GetFuncHandler<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, TReturn>, Action<TContext, T1, T2, T3, T4>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5> GetFuncHandler<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, TReturn>, Action<TContext, T1, T2, T3, T4, T5>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5, T6> GetFuncHandler<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, T6, TReturn>, Action<TContext, T1, T2, T3, T4, T5, T6>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5, T6, T7> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, T6, T7, TReturn>, Action<TContext, T1, T2, T3, T4, T5, T6, T7>>(serviceMemberName);
        }

        public Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, string serviceMemberName)
        {
            return GetInterceptor<Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>, Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8>>(serviceMemberName);
        }

        #endregion


        #region Register Action Interceptors

        public void Register(Action forMember, Action<TContext> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1>(Action<T1> forMember, Action<TContext, T1> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2>(Action<T1, T2> forMember, Action<TContext, T1, T2> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3>(Action<T1, T2, T3> forMember, Action<TContext, T1, T2, T3> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Action<TContext, T1, T2, T3, T4> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Action<TContext, T1, T2, T3, T4, T5> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }

        #endregion

        #region Register Function Interceptors

        public void Register<TReturn>(Func<TReturn> forMember, Action<TContext> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, TReturn>(Func<T1, TReturn> forMember, Action<TContext, T1> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, Action<TContext, T1, T2> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, Action<TContext, T1, T2, T3> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, Action<TContext, T1, T2, T3, T4> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }
        public void Register<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> handler)
        {
            RegisterToCollection(forMember, forMember.Method.Name, handler);
        }

        #endregion

        private THandler GetInterceptor<TMember, THandler>(string forMemberName) where TMember : class where THandler : class
        {
            Dictionary<Type, object> memberHandlers = null;
            if (!_handlers.ContainsKey(forMemberName))
            {
                return null;
            }
            memberHandlers = _handlers[forMemberName];
            var t = typeof(TMember);

            if (memberHandlers.ContainsKey(t))
            {
                var retval = memberHandlers[t];
                if (retval is THandler)
                    return (THandler)retval;
            }
            return null;
        }

        private void RegisterToCollection<TMember, THandler>(TMember forMember, string forMemberName, THandler handler)
        {
            Dictionary<Type, object> memberHandlers = null;
            if (!_handlers.ContainsKey(forMemberName))
            {
                memberHandlers = new Dictionary<Type, object>();
                _handlers.Add(forMemberName, memberHandlers);
            }
            else
            {
                memberHandlers = _handlers[forMemberName];
            }
            memberHandlers.Add(typeof(TMember), handler);
        }

    }
}