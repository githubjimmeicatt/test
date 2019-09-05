using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Auditing.Access.AuditTrail.Interface
{
    public interface IAuditTrailAccess
    {
        void WriteEntry(Enum eventType, object data, bool encryptData);
    }
}
