using System.Net.Mail;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Umbraco.Forms;
using Microsoft.Extensions.Options;

namespace DHV.Umbraco.Features.Forms
{
    public class ContactformulierConfirmation : IFormProcessor
    {
        private readonly SmtpClient _smtpClient;
        private readonly IOptions<ContactFormulierConfirmationConfig> _config;

        public ContactformulierConfirmation(SmtpClient smtpClient, IOptions<ContactFormulierConfirmationConfig> config)
        {
            _smtpClient = smtpClient;
            _config = config;
        }

        public bool ShouldProcess(IFormSubmission formInstance) => _config.Value != null && formInstance.FormDefinitionId == _config.Value.FormId;

        public async Task Process(IFormSubmission formInstance, CancellationToken cancellationToken)
        {
            if (_config == null || !TryGetToAddress(formInstance.Body, out var to))
            {
                return;
            }

            using var message = new MailMessage()
            {
                IsBodyHtml = true,
                Body = "<p>Hartelijk dank voor je bericht aan Pensioenfonds HaskoningDHV.</p><p>Dit is een automatisch antwoord.</p><p>Wij streven ernaar binnen enkele werkdagen een reactie te geven op je vraag of je opmerking.</p><p>Met vriendelijke groet,</p><p>Pensioenfonds HaskoningDHV</p>",
                From = new MailAddress(_config.Value.From),
                Subject = _config.Value.Subject,
            };

            message.To.Add(new MailAddress(to));

            if (!string.IsNullOrWhiteSpace(_config.Value.ReplyTo))
            {
                message.ReplyToList.Add(new MailAddress(_config.Value.ReplyTo));
            }

            await _smtpClient.SendMailAsync(message, cancellationToken);
        }

        private static bool TryGetToAddress(JsonElement formData, out string to)
        {
            to = null;

            if (formData.ValueKind == JsonValueKind.Object && formData.TryGetProperty("email", out var subjectProp))
            {
                to = subjectProp.GetString();
            }

            return !string.IsNullOrWhiteSpace(to);
        }
    }
}
