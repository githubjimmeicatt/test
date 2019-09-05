using Icatt.Data.Entity;

namespace Sphdhv.KlantPortaal.Data.TerminatedSession.Entities
{
    public class TerminatedSession : IObjectWithState
    {
        public string MarkerId { get; set; }
        public ObjectState State { get; set; }
    }
}
