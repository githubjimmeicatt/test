
namespace Icatt.Data.Entity
{
    public static class ContextHelpers
    {
        /// <summary>
        /// Sets entity state according to ObjectState for all types implementing IObjectWithState
        /// </summary>
        /// <param name="context"></param>
        /// <remarks>
        /// NB For use in short lived context objects (disconntected scenario's like web applications)
        /// </remarks>
        public static void ApplyStateChanges(this System.Data.Entity.DbContext context)
        {
            foreach (var entry in context.ChangeTracker.Entries<IObjectWithState>())
            {
                entry.State = StateHelpers.ConvertState(entry.Entity.State);
                entry.Entity.State = ObjectState.Unchanged;
            }
        }
    }
}
