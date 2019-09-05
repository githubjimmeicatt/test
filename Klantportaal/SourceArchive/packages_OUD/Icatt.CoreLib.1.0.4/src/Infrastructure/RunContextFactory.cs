using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Infrastructure
{

    /// <summary>
    /// Creates a context without a meaningful request id and a single RunId as session Id for the lifetime of the factory object.
    /// </summary>
public    class RunContextFactory: IContextFactory
    {
        private Guid _runId = Guid.NewGuid();

        public IRequestIdService CreateRequestIdService()
    {
        return new EmptyRequestIdService();
    }

    public ISessionIdService CreateSessionIdService()
    {
        return new RunIdService(_runId);
    }
    }


    /// <summary>
    /// Provides a single Guid for its entire lifetime..
    /// </summary>
    public class RunIdService : ISessionIdService
    {
        private Guid? _id;
        private Guid _runId;

        public RunIdService(Guid runId)
        {
            _runId = runId;
        }


        public Guid? GetSessionId()
        {
            return _id;
        }

        public Guid EnsureSessionId()
        {
            if (_id.HasValue) return _id.Value;

            _id = _runId;

            return _id.Value;
        }
    }


    /// <summary>
    /// Provides an empty requestId
    /// </summary>
    public class EmptyRequestIdService   : IRequestIdService
    {
        private Guid? _id;

        public Guid? GetRequestId()
        {
            return _id;
        }

        public Guid EnsureRequestId()
        {
            if (_id.HasValue) return _id.Value;

            _id = Guid.Empty;

            return _id.Value;
        }
    }
}
