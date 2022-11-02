using System.Collections.Generic;

namespace DHV.Umbraco.Features.Forms
{
    public class FormsConfig
    {
        public Form Default { get; set; }

        public IReadOnlyDictionary<string, Form> Forms { get; set; }
    }

    public class Form
    {
        public string Id { get; set; }
        public string To { get; set; }
        public string ReplyTo { get; set; }
        public string From { get; set; }
        public string Subject { get; set; }
    }
}
