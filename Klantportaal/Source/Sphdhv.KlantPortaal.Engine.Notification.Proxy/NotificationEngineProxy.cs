using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Engine.Notification.Contract;

namespace Sphdhv.KlantPortaal.Engine.Notification.Proxy
{
    public class NotificationEngineProxy<TContext> : ProxyBase<Interface.INotification, TContext>, Interface.INotification where TContext : class
    {
        public NotificationEngineProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void RaiseNotificationEvent(ApplicationEnvironment sourceApp, EventType eventType, Argument[] arguments)
        {
            Invoke(sourceApp, eventType, arguments, Service.RaiseNotificationEvent);
        }

        public string SerializeToString(object objectToSerialize)
        {
            return Invoke(objectToSerialize, Service.SerializeToString);
        }
    }
}
