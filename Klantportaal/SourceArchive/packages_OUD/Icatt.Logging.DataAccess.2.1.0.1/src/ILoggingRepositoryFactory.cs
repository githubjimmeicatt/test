namespace Icatt.Logging.DataAccess
{
    public interface ILoggingRepositoryFactory
    {
        ILoggingRepository Create();
        ILoggingRepository Create(string nameOrConnectionstring);
    }
}