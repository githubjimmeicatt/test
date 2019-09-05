using System;

namespace Icatt.Infrastructure
{
    /// <summary>
    /// Interface for services that provide a SessionId that uniquely identifies the current Session
    /// </summary>
    /// <remarks>
    /// Scope and lifetime of a session can vary dependening on the context. The consept is not limited to HTTP sessions.
    /// </remarks>
    public interface ISessionIdService
    {
        /// <summary>
        /// Returns null if <see cref="EnsureSessionId"/> has not been called yet for the current Session.
        /// </summary>
        Guid? GetSessionId();

        /// <summary>
        /// Returns a globally unique id for the current Session.
        /// </summary>
        Guid EnsureSessionId();

    }
}