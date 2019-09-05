using Icatt.Ar.Manager.ApplicationAuthority.Interface;
using Icatt.ServiceModel;
using System;
using Icatt.Ar.Manager.ApplicationAuthority.Contract;
using Icatt.Sks.Common;

namespace Icatt.Ar.Manager.ApplicationAuthority.Proxy
{
    public class ApplicationAuthorityProxy<TContext> : ProxyBase<IApplicationAuthority, TContext>,IApplicationAuthority where TContext : class , IX509Identity
    {
        public ApplicationAuthorityProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        PublicCertificate IApplicationAuthority.ApplicationEnvironmentCertificate(ApplicationEnvironment appenv)
        {
            throw new NotImplementedException();
        }

        ApplicationEnvironment IApplicationAuthority.IdentifyThumbprint()
        {
            return Invoke( Service.IdentifyThumbprint);
        }
    }
}
