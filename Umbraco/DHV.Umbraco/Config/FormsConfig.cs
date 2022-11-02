using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;

namespace Wsg.CorporateUmbraco.Config
{
    public class FormsConfig
    {
        public string FormsBackofficeDomain { get; set; }

        public Form Default { get; set; }

        public List<Form> Forms { get; set; }
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
