namespace Sphdhv.KlantPortaal.Access.TerminatedSession.Interface
{
    public interface ISessionMarkerContext
    {
        string Marker { get; set; }
    }

    public interface ISessionMarkerAccess
    {
        void SetMarker();
        void ClearMarker();
        bool HasMarker();
    }
}
