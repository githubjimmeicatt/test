using System;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.Security.Manager.Authentication.Service;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.KlantPortaal.Manager.Session.Service;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Service;
using Sphdhv.DeelnemerPortalApi.Interface;

namespace Sphdhv.KlantPortaal.Host.WebHost.Environment.Authentication
{
    public class AuthenticationServiceFactory<TContext> : Icatt.ServiceModel.ServiceFactoryBase<TContext>
        where TContext: class, IAuthenticationTicket, IUserContext, ISessionMarkerContext, IPiramideContext
    {
        public override IContract CreateService<IContract>(TContext context)
        {
            var type = typeof(IContract);

            if (type == typeof(IAuthenticationManager))
            {
                var serviceClient =
                    new AuthenticationManagerService<TContext>(context,FactoryContainer);

                return serviceClient as IContract;
            }

            if (type == typeof(ISessionMarkerAccess))
            {
                return new TerminatedSessionAccess<TContext>(context, FactoryContainer) as IContract;
            }

            if (type == typeof(ISessionManager))
            {
                return new SessionManager<TContext>(context, FactoryContainer) as IContract;
            }

            throw new InvalidOperationException("Unknown type requested: " + type.AssemblyQualifiedName);
        }
    }
}