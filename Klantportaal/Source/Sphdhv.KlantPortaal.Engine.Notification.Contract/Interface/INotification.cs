namespace Sphdhv.KlantPortaal.Engine.Notification.Interface
{
    public interface INotification
    {
        void RaiseNotificationEvent(Contract.ApplicationEnvironment sourceApp, Contract.EventType eventType, Contract.Argument[] arguments);

        string SerializeToString(object objectToSerialize);

    }
}
