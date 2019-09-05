using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.ServiceModel
{
    internal interface IOperationHandlerCollection<TContext, THandlerResult>
    {

        #region Handle Actions

        Func<TContext, THandlerResult> GetActionHandler(Action forMember, string serviceMemberName);
        Func<TContext, T1, THandlerResult> GetActionHandler<T1>(Action<T1> forMember, string serviceMemberName);
        Func<TContext, T1, T2, THandlerResult> GetActionHandler<T1, T2>(Action<T1, T2> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, THandlerResult> GetActionHandler<T1, T2, T3>(Action<T1, T2, T3> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, THandlerResult> GetActionHandler<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> GetActionHandler<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, string serviceMemberName);

        #endregion

        #region Handle Functions

        Func<TContext, THandlerResult> GetFuncHandler<TReturn>(Func<TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, THandlerResult> GetFuncHandler<T1, TReturn>(Func<T1, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, THandlerResult> GetFuncHandler<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, THandlerResult> GetFuncHandler<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, THandlerResult> GetFuncHandler<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, string serviceMemberName);
        Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, string serviceMemberName);

        #endregion

        #region Register Action Handlers

        void Register(Action forMember, Func<TContext, THandlerResult> handler);
        void Register<T1>(Action<T1> forMember, Func<TContext, T1, THandlerResult> handler);
        void Register<T1, T2>(Action<T1, T2> forMember, Func<TContext, T1, T2, THandlerResult> handler);
        void Register<T1, T2, T3>(Action<T1, T2, T3> forMember, Func<TContext, T1, T2, T3, THandlerResult> handler);
        void Register<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Func<TContext, T1, T2, T3, T4, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Func<TContext, T1, T2, T3, T4, T5, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> handler);

        #endregion

        #region Register Function Handlers

        void Register<TReturn>(Func<TReturn> forMember, Func<TContext, THandlerResult> handler);
        void Register<T1, TReturn>(Func<T1, TReturn> forMember, Func<TContext, T1, THandlerResult> handler);
        void Register<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, Func<TContext, T1, T2, THandlerResult> handler);
        void Register<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, Func<TContext, T1, T2, T3, THandlerResult> handler);
        void Register<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, Func<TContext, T1, T2, T3, T4, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, THandlerResult> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, Func<TContext, T1, T2, T3, T4, T5, T6, T7, T8, THandlerResult> handler);

        #endregion
        
    }


    internal interface IOperationHandlerCollection<TContext>
    {

        #region Handle Actions

        Action<TContext> GetActionHandler(Action forMember, string serviceMemberName);
        Action<TContext, T1> GetActionHandler<T1>(Action<T1> forMember, string serviceMemberName);
        Action<TContext, T1, T2> GetActionHandler<T1, T2>(Action<T1, T2> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3> GetActionHandler<T1, T2, T3>(Action<T1, T2, T3> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4> GetActionHandler<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5> GetActionHandler<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5, T6> GetActionHandler<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5, T6, T7> GetActionHandler<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> GetActionHandler<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, string serviceMemberName);

        #endregion

        #region Handle Functions

        Action<TContext> GetFuncHandler<TReturn>(Func<TReturn> forMember, string serviceMemberName);
        Action<TContext, T1> GetFuncHandler<T1, TReturn>(Func<T1, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2> GetFuncHandler<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3> GetFuncHandler<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4> GetFuncHandler<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5> GetFuncHandler<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5, T6> GetFuncHandler<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5, T6, T7> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, string serviceMemberName);
        Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> GetFuncHandler<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, string serviceMemberName);

        #endregion

        #region Register Action Handlers

        void Register(Action forMember, Action<TContext> handler);
        void Register<T1>(Action<T1> forMember, Action<TContext, T1> handler);
        void Register<T1, T2>(Action<T1, T2> forMember, Action<TContext, T1, T2> handler);
        void Register<T1, T2, T3>(Action<T1, T2, T3> forMember, Action<TContext, T1, T2, T3> handler);
        void Register<T1, T2, T3, T4>(Action<T1, T2, T3, T4> forMember, Action<TContext, T1, T2, T3, T4> handler);
        void Register<T1, T2, T3, T4, T5>(Action<T1, T2, T3, T4, T5> forMember, Action<TContext, T1, T2, T3, T4, T5> handler);
        void Register<T1, T2, T3, T4, T5, T6>(Action<T1, T2, T3, T4, T5, T6> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7>(Action<T1, T2, T3, T4, T5, T6, T7> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7, T8>(Action<T1, T2, T3, T4, T5, T6, T7, T8> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> handler);

        #endregion

        #region Register Function Handlers

        void Register<TReturn>(Func<TReturn> forMember, Action<TContext> handler);
        void Register<T1, TReturn>(Func<T1, TReturn> forMember, Action<TContext, T1> handler);
        void Register<T1, T2, TReturn>(Func<T1, T2, TReturn> forMember, Action<TContext, T1, T2> handler);
        void Register<T1, T2, T3, TReturn>(Func<T1, T2, T3, TReturn> forMember, Action<TContext, T1, T2, T3> handler);
        void Register<T1, T2, T3, T4, TReturn>(Func<T1, T2, T3, T4, TReturn> forMember, Action<TContext, T1, T2, T3, T4> handler);
        void Register<T1, T2, T3, T4, T5, TReturn>(Func<T1, T2, T3, T4, T5, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5> handler);
        void Register<T1, T2, T3, T4, T5, T6, TReturn>(Func<T1, T2, T3, T4, T5, T6, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5, T6> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7> handler);
        void Register<T1, T2, T3, T4, T5, T6, T7, T8, TReturn>(Func<T1, T2, T3, T4, T5, T6, T7, T8, TReturn> forMember, Action<TContext, T1, T2, T3, T4, T5, T6, T7, T8> handler);

        #endregion

    }
}
