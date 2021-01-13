using System.Linq;
using Icatt.Data.Entity;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Data.TerminatedSession.DbContext;

namespace Sphdhv.KlantPortaal.Access.TerminatedSession.Service
{
    public class TerminatedSessionAccess<TContext> : ServiceBase<TContext>, ISessionMarkerAccess where TContext : class, ISessionMarkerContext
    {
        private readonly string _connectionstringOrName;
        private readonly TerminatedSessionDbContext.DatabaseInitializationMode _initializationMode;
        public TerminatedSessionAccess(TContext requestContext = null, IFactoryContainer<TContext> env = null) : this(null, TerminatedSessionDbContext.DatabaseInitializationMode.NoInitialization, requestContext, env)
        {
        }

        public TerminatedSessionAccess(string connectionstringOrName, TerminatedSessionDbContext.DatabaseInitializationMode initializationMode = TerminatedSessionDbContext.DatabaseInitializationMode.NoInitialization, TContext requestContext = null, IFactoryContainer<TContext> env = null) : base(requestContext, env)
        {
            _connectionstringOrName = connectionstringOrName;
            _initializationMode = initializationMode;
        }

        public void SetMarker()
        {
            using (var context = new TerminatedSessionDbContext(_connectionstringOrName, _initializationMode))
            {
                if (context.TerminatedSessions.Any(x => x.MarkerId == Context.Marker)) return;
                context.TerminatedSessions.Add(new Data.TerminatedSession.Entities.TerminatedSession
                {
                    MarkerId = Context.Marker,
                    State = ObjectState.Added
                });
                context.SaveChanges();
            }
        }

        public void ClearMarker()
        {
            using (var context = new TerminatedSessionDbContext(_connectionstringOrName, _initializationMode))
            {
                var terminatedSession = context.TerminatedSessions.SingleOrDefault(x => x.MarkerId == Context.Marker);
                if (terminatedSession == null) return;
                context.TerminatedSessions.Remove(terminatedSession);
                terminatedSession.State = ObjectState.Deleted;
                context.SaveChanges();
            }
        }

        public bool HasMarker()
        {
            using (var context = new TerminatedSessionDbContext(_connectionstringOrName, _initializationMode))
            {
                return context.TerminatedSessions.SingleOrDefault(x => x.MarkerId == Context.Marker) != null;
            }
        }
    }
}
