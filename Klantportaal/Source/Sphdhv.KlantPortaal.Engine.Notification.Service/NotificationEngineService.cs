using Icatt;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Engine.Notification.Contract;
using System.IO;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;

namespace Sphdhv.KlantPortaal.Engine.Notification.Service
{
    public class NotificationEngineService<TContext> : ServiceBase<TContext>, Interface.INotification where TContext : class

    {
        public NotificationEngineService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public void RaiseNotificationEvent(ApplicationEnvironment sourceApp, EventType eventType, Argument[] arguments)
        {

            switch (eventType.SourceType)
            {
                case "IEmailManager": //?????
                    switch (eventType.OperationName)
                    {
                        case "VerifyEmail": //???????
                            SendVerificationMessage<VerificationRequest>(arguments);  
                            break;

                    }
                    break;
            }
        }

        public string SerializeToString(object objectToSerialize)
        {
            var serializer = new DataContractSerializer(objectToSerialize.GetType());

            var output = new StringBuilder();
            using (var xmlWriter = XmlWriter.Create(output))
            {
                serializer.WriteObject(xmlWriter, objectToSerialize);
                xmlWriter.Close();
            }
            return output.ToString();
        }


        private void SendVerificationMessage<TType>(Argument[] arguments) where TType : VerificationRequest
        {
            var notificatieRequestData = GetRequestData<TType>(arguments);

            var smtpClient = FactoryContainer.ProxyFactory.CreateProxy<ISmtpClient>(Context);

            var mail = new MailClient(smtpClient);

            mail.Send(mail.GetVerifyEmailAddressMessage(notificatieRequestData.To, notificatieRequestData.VerificationLink));

        }

        private static TType GetRequestData<TType>(Argument[] arguments) where TType : VerificationRequest
        {
            using (StringReader reader = new StringReader(arguments[0].XmlSerialized))
            {
                using (XmlReader xmlReader = XmlReader.Create(reader))
                {
                    var serializer = new DataContractSerializer(typeof(TType));
                    return  (TType)serializer.ReadObject(xmlReader);

                }
            }
        }
    }
}
