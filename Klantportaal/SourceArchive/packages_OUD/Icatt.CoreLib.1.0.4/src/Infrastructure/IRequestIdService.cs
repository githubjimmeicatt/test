using System;

namespace Icatt.Infrastructure
{
    /// <summary>
    /// Interface for services that provide a requestId that uniquely identifies the current request
    /// </summary>
    /// <remarks>Scope and lifetime of a request can vary depening to the context the code is running in. The concept is not limited to HTTP requests.</remarks>
    public interface IRequestIdService
    {
        /// <summary>
        /// Returns null if <see cref="EnsureRequestId"/> has not been called yet for the current request.
        /// </summary>
        /// <returns></returns>
        Guid? GetRequestId();

        /// <summary>
        /// Returns a globally unique id for the current request.
        /// </summary>
        Guid EnsureRequestId();

    }
}