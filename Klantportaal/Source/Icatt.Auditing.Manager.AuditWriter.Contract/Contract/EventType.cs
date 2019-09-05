using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Auditing.Manager.AuditTrailWriter.Contract
{
    public enum EventType
    {
        Login = 0,
        CancelledByUser = 1,
        ServiceFailure = 2,
        Logoff = 3 
    }
}

