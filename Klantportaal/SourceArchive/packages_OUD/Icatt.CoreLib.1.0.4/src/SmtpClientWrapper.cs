using System;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;

namespace Icatt
{
    public class SmtpClientWrapper: ISmtpClient, IDisposable
    {
        private readonly SmtpClient _client = new SmtpClient();
        public virtual void Send(string @from, string recipients, string subject, string body)
        {
            _client.Send(@from, recipients, subject, body);
        }

        public virtual void Send(MailMessage message)
        {
            _client.Send(message);
        }

        public virtual void SendAsync(string @from, string recipients, string subject, string body, object userToken)
        {
            _client.SendAsync(@from, recipients, subject, body, userToken);
        }

        public virtual void SendAsync(MailMessage message, object userToken)
        {
            _client.SendAsync(message, userToken);
        }

        public virtual void SendAsyncCancel()
        {
            _client.SendAsyncCancel();
        }

        public virtual Task SendMailAsync(string @from, string recipients, string subject, string body)
        {
            return _client.SendMailAsync(@from, recipients, subject, body);
        }

        public virtual Task SendMailAsync(MailMessage message)
        {
            return _client.SendMailAsync(message);
        }

        public void Dispose()
        {
            _client.Dispose();
        }

        public string Host
        {
            get { return _client.Host; }
            set { _client.Host = value; }
        }

        public int Port
        {
            get { return _client.Port; }
            set { _client.Port = value; }
        }

        public bool UseDefaultCredentials
        {
            get { return _client.UseDefaultCredentials; }
            set { _client.UseDefaultCredentials = value; }
        }

        public ICredentialsByHost Credentials
        {
            get { return _client.Credentials; }
            set { _client.Credentials = value; }
        }

        public int Timeout
        {
            get { return _client.Timeout; }
            set { _client.Timeout = value; }
        }

        public ServicePoint ServicePoint
        {
            get { return _client.ServicePoint; }
        }

        public SmtpDeliveryMethod DeliveryMethod
        {
            get { return _client.DeliveryMethod; }
            set { _client.DeliveryMethod = value; }
        }

        public SmtpDeliveryFormat DeliveryFormat
        {
            get { return _client.DeliveryFormat; }
            set { _client.DeliveryFormat = value; }
        }

        public string PickupDirectoryLocation
        {
            get { return _client.PickupDirectoryLocation; }
            set { _client.PickupDirectoryLocation = value; }
        }

        public bool EnableSsl
        {
            get { return _client.EnableSsl; }
            set { _client.EnableSsl = value; }
        }

        public X509CertificateCollection ClientCertificates
        {
            get { return _client.ClientCertificates; }
        }

        public string TargetName
        {
            get { return _client.TargetName; }
            set { _client.TargetName = value; }
        }

        public event SendCompletedEventHandler SendCompleted
        {
            add { _client.SendCompleted += value; }
            remove { _client.SendCompleted -= value; }
        }
    }
}
