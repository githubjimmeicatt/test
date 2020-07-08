using System;
using System.Runtime.Serialization;
using System.Web.SessionState;
using Icatt.Digid.Access.Client;
using Icatt.Digid.Access.Contract;
using Icatt.Digid.Access.Interface;
using Icatt.Infrastructure;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Pensioen.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Engine.Pensioen.Interface;
using Sphdhv.KlantPortaal.Manager.Authentication.Interface;
using Sphdhv.KlantPortaal.Manager.Authentication.Service;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Service;
using Sphdhv.DeelnemerPortalApi.Interface;
using Sphdhv.DeelnemerPortalApi.Client;
using Sphdhv.KlantPortaal.Engine.Claims.Interface;
using Sphdhv.KlantPortaal.Engine.Claims.Service;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using Sphdhv.KlantPortaal.Access.AuthToken.Service;
using Icatt.Membership.Access.User.Contract;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Service;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Service;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.KlantPortaal.Manager.Session.Service;
using Icatt.Membership.Access.User.Service;
using Icatt.Membership.Access.User.Contract.Interface;
using System.Collections.Generic;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Service;
using Sphdhv.Klantportaal.Manager.Deelnemer.Interface;
using Sphdhv.Klantportaal.Manager.Deelnemer.Service;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Access.Deelnemer.Service;
using Sphdhv.KlantPortaal.Engine.Notification.Interface;
using Icatt.Auditing.Access.AuditTrail.Interface;
using Icatt.Auditing.Access.AuditTrail.Service;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Service;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;
using Sphdhv.KlantPortaal.Access.Correspondentie.Service;
using Icatt.Azure.Access;
using System.Security.Cryptography.X509Certificates;
using Sphdhv.KlantPortaal.Host.WebHost.Properties;

namespace Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal
{
    public class KlantPortaalServiceFactory<TContext> : ServiceFactoryBase<TContext>
        where TContext : class, IApplicationEnvironmentContext, IUserContext, ISessionMarkerContext, ILogIdentities, IMembershipAccessContext, IPiramideContext, IWebRequest, IAuditContext
    {

        IDictionary<Type, Func<TContext, object>> _mocks;

        public KlantPortaalServiceFactory(IDictionary<Type, Func<TContext, object>> mocks = null) 
        {
            _mocks = mocks;
        }

        public override IService CreateService<IService>(TContext context)
        {
            var type = typeof(IService);

            Func<TContext, object> m;
            if (_mocks != null && _mocks.TryGetValue(type, out m))
            {
                return m(context) as IService;
            }


            if (type == typeof(IMijnPensioenManager))
            {
                return new MijnPensioenManager<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IPensioenEngine))
            {
                return new Engine.Pensioen.Service.PensioenEngine<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IPensioenAccess))
            {
                return new Access.Pensioen.Service.PensioenAccess<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IContextFactory))
            {
                return new KlantPortaalLoggingContextFactory<TContext>(context) as IService;
            }
            if (type == typeof(IAuthenticationManager))
            {
                return new AuthenticationManagerService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IClaimsEngine))
            {
                return new ClaimsEngineService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(ICryptographer))
            {
                return new CryptographerEngine<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IDeelnemerPortalApi))
            {
                return new DeelnemerPortalApiClient<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IDigidAccess))
            {
                if (!Enum.IsDefined(typeof(KlantportaalDigidAssertionEndpoint), Properties.Settings.Default.AssertionConsumerServiceIndex))
                {
                    throw new Exception($"Invalid AssertionConsumerServiceIndex setting: {Properties.Settings.Default.AssertionConsumerServiceIndex}");
                }
                var digidSettings = //Properties.Settings.Default.DigidSettings ??
                    new KlantportaalDigidSettings
                    {
                        AssertionConsumerServiceEndPointIndex = (KlantportaalDigidAssertionEndpoint)Properties.Settings.Default.AssertionConsumerServiceIndex,
                        RequestAuthenticationEndpoint = Properties.Settings.Default.DigidRequestAuthenticationEndpoint,
                        CertificateIssuer = Properties.Settings.Default.DigidMedataIssuer,
                        CertificateSubject = Properties.Settings.Default.DigidClientCertificateSubject,
                        ResolveArtifactEndpoint = Properties.Settings.Default.DigidResolveArtifactEndpoint,
                    };

                return new DigidAccessClient<TContext>(
                    context,
                    FactoryContainer,
                    digidSettings) as IService;
            }
            if (type == typeof(IAuthTokenAccess))
            {
                return new AuthTokenAccessService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(ISessionMarkerAccess))
            {
                return new TerminatedSessionAccess<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(ISessionManager))
            {
                return new SessionManager<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IUserAccess))
            {
                return new UserAccessService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IAspNetIdentityManager))
            {
                return new AspNetIdentityManagerService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IDeelnemerManager))
            {
                return new DeelnemerManager<TContext>(context, FactoryContainer,Properties.Settings.Default.EmailVerificatieEndpoint) as IService;
            }
            if (type == typeof(IDeelnemerAccess))
            {
                return new DeelnemerAccessService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(INotification))
            {
                return new Engine.Notification.Service.NotificationEngineService<TContext>(context, FactoryContainer) as IService;
            }
            if (type == typeof(IAuditTrailAccess))
            {
      
                return new AuditTrailAccessService<TContext>(context, FactoryContainer ) as IService;
            }
             if (type == typeof(IAuditTrailWriter))
            {
                return new AuditTrailWriterService<TContext>(context, FactoryContainer) as IService;               
            }
            if (type == typeof(ICorrespondentieAccess))
            {
                return new CorrespondentieAccess<TContext>(context, FactoryContainer) as IService;
            }


            
            throw new InvalidOperationException($"Service requested for unknown interface type: '{type.FullName}'");
        }

     

    }

    [DataContract]
    public class KlantportaalDigidSettings : DigidSettings
    {
        [DataMember]
        public new KlantportaalDigidAssertionEndpoint AssertionConsumerServiceEndPointIndex
        {
            get
            {
                return (KlantportaalDigidAssertionEndpoint)base.AssertionConsumerServiceEndPointIndex;
            }
            set
            {
                base.AssertionConsumerServiceEndPointIndex = (byte)value;
            }
        }
    }

}
