using System;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.KlantPortaal.Common;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Contract;

namespace Sphdhv.KlantPortaal.Manager.Session.Service
{
    public class SessionManager<TContext> : ServiceBase<TContext>, ISessionManager where TContext : class, ISessionMarkerContext, IUserContext
    {
        public SessionManager(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void StartSession()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<ISessionMarkerAccess>(Context);
            proxy.ClearMarker();
        }

        public bool IsActiveSession()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<ISessionMarkerAccess>(Context);
            return !proxy.HasMarker();
        }

        public void EndSession()
        {
            try
            {
                Audit(EventType.Logoff);
            }
            catch(Exception e)
            {
                var t = e;
            }
            finally{
                //altijd uitloggen ook als audit faalt..

                var proxy = FactoryContainer.ProxyFactory.CreateProxy<ISessionMarkerAccess>(Context);
                try
                {
                    proxy.SetMarker();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
            }            
          
        }


        private void Audit(EventType eventType)
        {            
            var auditData = new Icatt.Auditing.Manager.AuditTrailWriter.Contract.DigidAuditData() { Bsn = Context.Bsn, Ip = Context.Ip };
            var auditTrailManagerproxy = FactoryContainer.ProxyFactory.CreateProxy<IAuditTrailWriter>(Context);
            auditTrailManagerproxy.WriteEntryEncrypted(eventType,  auditData);
            
        }
        

    }
}
