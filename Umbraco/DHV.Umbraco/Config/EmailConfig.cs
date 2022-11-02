using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Wsg.CorporateUmbraco.Config
{
    public class EmailConfig
    {
        public string Host { get; set; }
        public int Port { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public bool EnableSsl { get; set; }
    }
}
