using System.Net.Mail;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;

namespace Wsg.CorporateUmbraco.Features.Forms
{

    public class SendFormSubmittedConfirmation
    {
        private readonly SmtpClient _smtpClient;

        public SendFormSubmittedConfirmation(SmtpClient smtpClient)
        {
            _smtpClient = smtpClient;
        }

        public Task SendAsync(string formId, JsonElement formData, CancellationToken token) => formId switch
        {
            _ => Task.CompletedTask
        };
    }
}
