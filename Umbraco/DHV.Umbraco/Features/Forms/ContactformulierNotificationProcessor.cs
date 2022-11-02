using System.Net.Mail;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Umbraco.Forms;
using Microsoft.Extensions.Options;

namespace DHV.Umbraco.Features.Forms
{
    public class ContactformulierNotificationProcessor : IFormProcessor
    {
        private readonly SmtpClient _smtpClient;
        private readonly Form _config;

        public ContactformulierNotificationProcessor(SmtpClient smtpClient, IOptions<FormsConfig> config)
        {
            _smtpClient = smtpClient;
            _config = config.Value.Forms.TryGetValue("Contactformulier", out var cfConfig) ? cfConfig : config.Value.Default;
        }

        public bool ShouldProcess(IFormSubmission formInstance) => _config != null && formInstance.FormDefinitionId == _config.Id;

        public async Task Process(IFormSubmission formInstance, CancellationToken cancellationToken)
        {
            if (_config == null || !TryGetToAddress(formInstance.Body, out var to))
            {
                return;
            }

            using var message = new MailMessage()
            {
                IsBodyHtml = true,
                Body = @$"Er is een formulier ingevuld in de website.<br/>Bekijk <a href=""{formInstance.BackofficeUrl}"">hier</a> de gegevens",
                From = new MailAddress(_config.From),
                Subject = _config.Subject
            };

            message.To.Add(new MailAddress(to));
            message.ReplyToList.Add(new MailAddress(_config.ReplyTo));

            await _smtpClient.SendMailAsync(message, cancellationToken);
        }

        private static bool TryGetToAddress(JsonElement formData, out string to)
        {
            to = null;

            if (formData.ValueKind == JsonValueKind.Object && formData.TryGetProperty("subject", out var subjectProp))
            {
                to = subjectProp.GetString();
            }

            return !string.IsNullOrWhiteSpace(to);
        }
    }
}
