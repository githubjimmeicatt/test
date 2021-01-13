using System;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.Security.Manager.Authentication.Proxy;
using Sphdhv.KlantPortaal.Manager.Session.Proxy;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Proxy;
using Sphdhv.KlantPortaal.Common;
using Icatt.ServiceModel;
using System.Diagnostics;
using Icatt.Infrastructure;
using Icatt.Web.Infrastructure;

namespace Sphdhv.Security.Environment
{
    public class AuthenticationProxyFactory<TContext> : ProxyFactoryBase<TContext>
        where TContext : class, IAuthenticationTicket, IUserContext, ISessionMarkerContext
    {
        public override IContract CreateProxy<IContract>(TContext context)
        {
            var type = typeof(IContract);
            var typeName = type.Name.ToUpperInvariant();

            #region Managers

            if (type == typeof(IAuthenticationManager))
            {
                var proxy = new AuthenticationManagerProxy<TContext>(context, FactoryContainer);
                proxy.NoAuth();

                return proxy as IContract;
            }

            if (type == typeof(ISessionManager))
            {
                var proxy = new SessionManagerProxy<TContext>(context, FactoryContainer);
                proxy.NoAuth();

                return proxy as IContract;
            }

            #endregion

            #region Access

            if (type == typeof(ISessionMarkerAccess))
            {
                var proxy = new TerminatedSessionAccessProxy<TContext>(context, FactoryContainer);
                proxy.NoAuth();

                return proxy as IContract;
            }

            #endregion

            #region Services

            if (type == typeof(IContextFactory))
            {
                return new HttpContextFactory() as IContract;
            }

            #endregion

            throw new InvalidOperationException($"Proxy requested for unknown interface: '{type.FullName}'");
        }
    }

    public static class ProxyBaseExtensions
    {
        public static void NoAuth<TService, TContract>(this ProxyBase<TService, TContract> proxy) where TService : class where TContract : class
        {
            Debug.Assert(proxy != null);
            proxy.OnAuthenticate += (_, __) => true;
            proxy.OnAuthorize += (_, __) => true;
        }
    }
}