using Icatt;
using System;
using System.Net.Mail;

namespace Sphdhv.KlantPortaal.Engine.Notification.Service
{
    public class MailClient : IDisposable
    {
        private readonly ISmtpClient _client;
        public MailClient(ISmtpClient client)
        {
            this._client = client;
        }

        public MailMessage GetVerifyEmailAddressMessage(string  to, string verificatielink)
        {
            var template = Properties.Resources.VerifyEmailAddresMailTemplate;
                      
            var message = new MailMessage();
            message.To.Add(to);
            message.ReplyToList.Add(new MailAddress(Properties.Settings.Default.VerifyEmailAddressReplyTo));
            message.Subject = Properties.Settings.Default.VerifyEmailAddressSubject;
            message.IsBodyHtml = true;
            message.Body = string.Format(template, System.Net.WebUtility.HtmlEncode( verificatielink));
            message.From = new MailAddress(Properties.Settings.Default.VerifyEmailAddressFrom, Properties.Settings.Default.VerifyEmailAddressDisplayName );
            message.Sender = new MailAddress(Properties.Settings.Default.VerifyEmailAddressFrom, Properties.Settings.Default.VerifyEmailAddressDisplayName );
            return message;
        }

        public void Send(MailMessage message)
        {
            _client.Host = Properties.Settings.Default.MailHost;
            _client.Port = Properties.Settings.Default.MailHostPort;
            _client.Send(message);
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
        
    }
}