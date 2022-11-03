namespace DHV.Umbraco.Features.Forms
{
    public class ContactFormulierNotificationConfig : FormEmailConfig
    {
    }

    public class ContactFormulierConfirmationConfig : FormEmailConfig
    {
    }

    public class FormEmailConfig
    {
        public string FormId { get; set; }
        public string To { get; set; }
        public string ReplyTo { get; set; }
        public string From { get; set; }
        public string Subject { get; set; }
    }
}
