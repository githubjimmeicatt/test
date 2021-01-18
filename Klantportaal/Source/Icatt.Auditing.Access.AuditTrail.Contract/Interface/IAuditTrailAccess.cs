using System;

namespace Icatt.Auditing.Access.AuditTrail.Interface
{
    public interface IAuditTrailAccess
    {
        void WriteEntry(Enum eventType, object data, bool encryptData);
    }
}
