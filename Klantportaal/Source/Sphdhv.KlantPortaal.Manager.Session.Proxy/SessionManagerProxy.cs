using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;

namespace Sphdhv.KlantPortaal.Manager.Session.Proxy
{
    public class SessionManagerProxy<TContext> : ProxyBase<ISessionManager, TContext>, ISessionManager where TContext : class
    {
        public SessionManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void StartSession()
        {
            Invoke(Service.StartSession);
        }

        public bool IsActiveSession()
        {
            return Invoke(Service.IsActiveSession);
        }

        public void EndSession()
        {
            Invoke(Service.EndSession);
        }
    }
}
