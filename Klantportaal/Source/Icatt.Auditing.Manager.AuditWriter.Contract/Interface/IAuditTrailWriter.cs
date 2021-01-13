namespace Icatt.Auditing.Manager.AuditTrailWriter.Interface
{
    public interface IAuditTrailWriter
    {
        void WriteEntryEncrypted(Contract.EventType eventType, object data);

        //void WriteEntry(Enum eventType, DateTime timestamp, object data);
    }
}
