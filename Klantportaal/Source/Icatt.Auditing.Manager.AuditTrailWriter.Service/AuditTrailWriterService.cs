using Icatt.Auditing.Access.AuditTrail.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.ServiceModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Auditing.Manager.AuditTrailWriter.Contract;

namespace Icatt.Auditing.Manager.AuditTrailWriter.Service
{
    public class AuditTrailWriterService<TContext> : ServiceBase<TContext>, IAuditTrailWriter where TContext : class
    {
        public AuditTrailWriterService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void WriteEntryEncrypted(EventType eventType,  object data)
        {
            var auditTrailAccess =  FactoryContainer.ProxyFactory.CreateProxy<IAuditTrailAccess>(Context);
            auditTrailAccess.WriteEntry(eventType, data, true);
        }
              
    }
}
