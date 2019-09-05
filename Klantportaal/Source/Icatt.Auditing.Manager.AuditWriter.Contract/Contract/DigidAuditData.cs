using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Auditing.Manager.AuditTrailWriter.Contract
{
    public class DigidAuditData
    {
        public string Bsn { get; set; }
        public string Sofinummer { get; set; }
        public string Ip { get; set; }
    }
}
