using System;
using System.Net;
using System.Net.Security;

namespace Icatt.Test.Net
{
    /// <summary>
    /// Adds a ServerCertificateValidationCallback handler that allows all certificates and removes it in de Dispose()
    /// </summary>
    public class AllowInvalidCertificatesPolicy : IDisposable
    {
        private readonly RemoteCertificateValidationCallback _allowHandler = delegate { return true; };
        private readonly Func<bool> _conditional;

        public AllowInvalidCertificatesPolicy() : this(null)
        {
        }

        public AllowInvalidCertificatesPolicy(Func<bool>  conditional)
        {
            _conditional = conditional;

            if (conditional == null || conditional())
            {
                //replace with dummy
                ServicePointManager.ServerCertificateValidationCallback += _allowHandler;
            }

        }

        public void Dispose()
        {
            if (_conditional == null || _conditional())
            {
                // ReSharper disable once DelegateSubtraction - only one handler is subtracted, not a sublist
                ServicePointManager.ServerCertificateValidationCallback -= _allowHandler;
            }
        }
    }
}
