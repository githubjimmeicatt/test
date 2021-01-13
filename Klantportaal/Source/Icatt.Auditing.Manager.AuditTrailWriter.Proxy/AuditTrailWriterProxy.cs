using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.ServiceModel;
using Icatt.Auditing.Manager.AuditTrailWriter.Contract;

namespace Icatt.Auditing.Manager.AuditTrailWriter.Proxy
{
    public class AuditTrailWriterProxy<TContext> : ProxyBase<IAuditTrailWriter, TContext>, IAuditTrailWriter where TContext : class
    {
        public AuditTrailWriterProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }
        

        public void WriteEntryEncrypted(EventType eventType, object data)
        {
            Invoke(eventType, data, Service.WriteEntryEncrypted);
        }
    }
}
