using System;
using Icatt.ServiceModel;
using Icatt.Auditing.Access.AuditTrail.Interface;

namespace Icatt.Auditing.Access.AuditTrail.Proxy
{
    public class AuditTrailAccessProxy<TContext> : ProxyBase<IAuditTrailAccess, TContext>, IAuditTrailAccess where TContext : class
    {
        public AuditTrailAccessProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void WriteEntry(Enum eventType, object data, bool encryptData)
        {
            Invoke(eventType, data, encryptData, Service.WriteEntry);
        }
    }
}