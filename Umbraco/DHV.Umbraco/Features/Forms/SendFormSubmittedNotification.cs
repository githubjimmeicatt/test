using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using Wsg.CorporateUmbraco.Config;

namespace Wsg.CorporateUmbraco.Features.Forms
{
    public class SendFormSubmittedNotification
    {
        private SmtpClient _smtpClient;
        private readonly IOptions<FormsConfig> _config;

        public SendFormSubmittedNotification(SmtpClient smtpClient, IOptions<FormsConfig> config)
        {
            _smtpClient = smtpClient;
            _config = config;
        }

        public async Task SendAsync(string formId, CancellationToken token)
        {
            var formConfig = GetFormConfigOrDefault(formId);

            if(formConfig == null)
            {
                return;
            }

            var formsBackofficeDomain = _config.Value.FormsBackofficeDomain;
            using var message = new MailMessage()
            {
                IsBodyHtml = true,
                Body = @$"Er is een formulier ingevuld in de website.<br/>Bekijk <a href=""{formsBackofficeDomain}/umbraco/#/forms/form/entries/{formId}"">hier</a> de gegevens",
                From = new MailAddress(formConfig.From),
                Subject = formConfig.Subject
            };

            message.To.Add(new MailAddress(formConfig.To));
            message.ReplyToList.Add(new MailAddress(formConfig.ReplyTo));

            await _smtpClient.SendMailAsync(message, token);

        }

        private Form GetFormConfigOrDefault(string formId)
        {
            var formConfig = _config.Value.Forms.FirstOrDefault(f => f.Id == formId);

            if (formConfig == null)
            {
                formConfig = _config.Value.Default;
            }

            return formConfig;
        }
    }
}
