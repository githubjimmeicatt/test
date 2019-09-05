using System;
using Icatt.Infrastructure;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Sphdhv.KlantPortaal.Host.WebHost
{
    public class KlantPortaalLoggingContextFactory<TContext> : IContextFactory
        where TContext: class, ILogIdentities
    {
        private readonly TContext _context;

        public KlantPortaalLoggingContextFactory(TContext klantPortaalContext)
        {
            _context = klantPortaalContext;
        }

        public IRequestIdService CreateRequestIdService()
        {
            return new KlantPortaalLoggingIdsService<TContext>(_context);
        }

        public ISessionIdService CreateSessionIdService()
        {
            return new KlantPortaalLoggingIdsService<TContext>(_context);
        }
    }

    public class KlantPortaalLoggingIdsService<TContext> : IRequestIdService, ISessionIdService
        where TContext:class,ILogIdentities
    {
        public KlantPortaalLoggingIdsService(TContext context)
        {
            Context = context;
        }

        public Guid? GetRequestId()
        {
            return Context.LogRequestId;
        }

        public Guid EnsureRequestId()
        {
            if (!Context.LogRequestId.HasValue)
            {
                Context.LogRequestId = Guid.NewGuid();
            }
            return Context.LogRequestId.Value;
        }

        public TContext Context { get; }
        public Guid? GetSessionId()
        {
            return Context.LogSessionId;
        }

        public Guid EnsureSessionId()
        {
            if (!Context.LogSessionId.HasValue)
            {
                Context.LogSessionId = new Guid();
            }
            return Context.LogSessionId.Value;
        }
    }
}
