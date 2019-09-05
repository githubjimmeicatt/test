namespace Sphdhv.KlantPortaal.Common
{
    public interface IApplicationEnvironmentContext
    {
        string ApplicationId { get; }
        string EnvironmentId { get; }
    }
}