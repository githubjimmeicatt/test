using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using Wsg.CorporateUmbraco.Config;

namespace Wsg.CorporateUmbraco.Features.Forms
{

    public class SendFormSubmittedConfirmation
    {
        private readonly SmtpClient _smtpClient;

        public SendFormSubmittedConfirmation(SmtpClient smtpClient)
        {
            _smtpClient = smtpClient;
        }

        public async Task SendAsync(string formId, string formData, CancellationToken token)
        {

            var message = ConfirmationMailFactory.Create(formId, formData);

            if (message == null)
            {
                return;
            }

            await _smtpClient.SendMailAsync(message, token);
        }
    }


    public class ConfirmationMailFactory
    {

        public static MailMessage Create(string formId, string formData)
        {
            MailMessage mail = null;

            switch (formId)
            {
                case "11d0c24d-e57f-4895-921c-e320f1b534e0":
                    mail = MakeOnlinePanelContactJeugdGezinsbeschermerConfirmation(formData);
                    break;
                case "523fd842-720e-4ed3-b1c1-71be01cd6cdc":
                    mail = MakeOnlinePanelVragenOverClientenkrantConfirmation(formData);
                    break;
                case "a67fbfcf-65e7-461b-9fe3-33852b63561e":
                    mail = MakeOnlinePanelVragenOverWebsiteConfirmation(formData);
                    break;
                case "4793ffc9-edd3-4beb-9826-d8e20e4316cd":
                    mail = MakeOnlinePanelVragenOverDeClientenraadConfirmation(formData);
                    break;
                case "89b52e6b-2dfb-4e8d-896b-ea0496e27381":
                    mail = MakeOnlinePanelVragenOverDeClientenpaginaConfirmation(formData);
                    break;
                case "05eff01d-e610-4891-a0b3-670526bed714":
                    mail = MakeOnlinePanelVragenOverContactJeugdzorgwerkerConfirmation(formData);
                    break;
                default:
                    break;
            }
            return mail;
        }



        private static MailMessage MakeOnlinePanelVragenOverClientenkrantConfirmation(string formData) => GetDefaultOnlinePanelConfirmation(formData);
        private static MailMessage MakeOnlinePanelContactJeugdGezinsbeschermerConfirmation(string formData) => GetDefaultOnlinePanelConfirmation(formData);
        private static MailMessage MakeOnlinePanelVragenOverWebsiteConfirmation(string formData) => GetDefaultOnlinePanelConfirmation(formData);
        private static MailMessage MakeOnlinePanelVragenOverDeClientenraadConfirmation(string formData) => GetDefaultOnlinePanelConfirmation(formData);
        private static MailMessage MakeOnlinePanelVragenOverDeClientenpaginaConfirmation(string formData) => GetDefaultOnlinePanelConfirmation(formData);
        private static MailMessage MakeOnlinePanelVragenOverContactJeugdzorgwerkerConfirmation(string formData) => GetDefaultOnlinePanelConfirmation(formData);


        private static MailMessage GetDefaultOnlinePanelConfirmation(string formData)
        {
            //alleen een bevestiging sturen als er een email adres ingevuld is en de vraag 'melding' met 'Ja' beantwoord is.


            var confirmAddress = string.Empty;
            var melding = string.Empty;
            var doc = JsonDocument.Parse(formData);
            var root = doc.RootElement;

            if (root.TryGetProperty("emailadres", out var senderQuestion))
            {
                confirmAddress = senderQuestion.GetString();
            }
            else
            if (root.TryGetProperty("eMailadres", out senderQuestion))
            {
                confirmAddress = senderQuestion.GetString();
            }

            if (root.TryGetProperty("melding", out var meldingQuestion))
            {
                melding = meldingQuestion.GetString();
            }
            else
            if (root.TryGetProperty("Mening", out  meldingQuestion))
            {
                melding = meldingQuestion.GetString();
            }

            if (confirmAddress == null || melding == null || melding.ToLowerInvariant() != "ja")
            {
                return null;
            }
            var message = new MailMessage()
            {
                IsBodyHtml = true,
                Body = @"<p>Beste deelnemer,</p>

                        <p>Bedankt voor het invullen van de vragenlijst van het cliëntpanel.<br/>
                        Je hebt aangegeven dat je vaker mee wilt doen. We hebben je emailadres genoteerd.<br/>
                        Je ontvangt een mail van ons als er nieuwe vragenlijsten zijn.</p>

                        <p>Wil je geen mails meer ontvangen als er nieuwe vragenlijsten zijn, stuur dan een berichtje naar <a href=""mailto:onlinepanel@pvj.nl"" style=""color:rgb(33, 150, 243); text-decoration:none;"">onlinepanel@pvj.nl</a></p>

                        <p>Met vriendelijke groet,<br/>
                        Cliëntbureau William Schrikker / DJGB<br/>
                        <a href=""mailto:clientbureau@wsg.nu"" style=""color:rgb(33, 150, 243); text-decoration:none;"">clientbureau@wsg.nu</a></p>",
                From = new MailAddress("onlinepanel@pvj.nl"),
                Subject = "Bedankt voor het invullen van deze vragenlijst"
            };
            message.To.Add(new MailAddress(confirmAddress));

            return message;
        }


 


    }


}
