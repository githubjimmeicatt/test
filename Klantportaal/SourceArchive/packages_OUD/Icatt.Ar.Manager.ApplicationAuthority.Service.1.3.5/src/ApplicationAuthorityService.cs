using System;
using Icatt.Ar.Manager.ApplicationAuthority.Contract;
using Icatt.Ar.Manager.ApplicationAuthority.Interface;
using Icatt.ServiceModel;
using Icatt.Sks.Common;

namespace Icatt.Ar.Manager.ApplicationAuthority.Service
{
    public class ApplicationAuthorityService<TContext> : ServiceBase<TContext>, IApplicationAuthority where TContext : class, IX509Identity
    {
        private readonly  MemoryApplicationRegistry _applicationRegistry = new MemoryApplicationRegistry();


        public ApplicationAuthorityService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        PublicCertificate IApplicationAuthority.ApplicationEnvironmentCertificate(ApplicationEnvironment appenv)
        {
            throw new NotImplementedException();
        }

        ApplicationEnvironment IApplicationAuthority.IdentifyThumbprint()
        {

            ApplicationEnvironment appEnv;
            if (_applicationRegistry.TryGetValue(Context.Thumbprint,out appEnv))
            {
                return appEnv;
            }

            return null;
        }
    }
}
