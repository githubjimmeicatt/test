namespace Icatt.Logging.DataAccess
{
    public class LoggingRepositoryFactory : ILoggingRepositoryFactory
    {
        private readonly int _databaseAppenderTimeoutInSeconds;
        private readonly string _nameOrConnectionstring;
        private readonly bool _createIfNotExists;

        public LoggingRepositoryFactory(string nameOrConnectionstring, int databaseAppenderTimeoutInSeconds,bool createIfNotExists)
        {
            _databaseAppenderTimeoutInSeconds = databaseAppenderTimeoutInSeconds;
            _nameOrConnectionstring = nameOrConnectionstring;
            _createIfNotExists = createIfNotExists;
        }


        public LoggingRepositoryFactory(int databaseAppenderTimeoutInSeconds) : this(null, databaseAppenderTimeoutInSeconds,false)
        {
        }

        public LoggingRepositoryFactory(string nameOrConnectionstring ) :this(nameOrConnectionstring,1,false)
        {
        }

        public LoggingRepositoryFactory(string nameOrConnectionstring,bool createIfNotExists) : this(nameOrConnectionstring, 1, createIfNotExists)
        {
        }

        public ILoggingRepository Create()
        {
            return Create(_nameOrConnectionstring);
        }

        public ILoggingRepository Create(string nameOrConnectionstring)
        {
            return new LoggingRepository(nameOrConnectionstring, _databaseAppenderTimeoutInSeconds, _createIfNotExists);
        }
    }
}