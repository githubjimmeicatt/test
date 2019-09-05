using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;

namespace Sphdhv.KlantPortaal.Access.TerminatedSession.Proxy
{
    public class TerminatedSessionAccessProxy<TContext> : ProxyBase<ISessionMarkerAccess, TContext>, ISessionMarkerAccess where TContext : class
    {
        public TerminatedSessionAccessProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void SetMarker()
        {
            Invoke(Service.SetMarker);
        }

        public void ClearMarker()
        {
            Invoke(Service.ClearMarker);
        }

        public bool HasMarker()
        {
            return Invoke(Service.HasMarker);
        }
    }
}
