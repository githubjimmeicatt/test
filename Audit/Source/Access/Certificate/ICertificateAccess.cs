using System.Security.Cryptography.X509Certificates;

namespace Sphdhv.Klantportaal.Audit.Engine.Certificate
{
    public interface ICertificateAccess
    {
        X509Certificate2 FindCertificateByThumbprint(string findValue, bool validOnly = false);
        X509Certificate2 FindCertificateByThumbprint(string findValue, StoreName storeName, StoreLocation storeLocation, bool validOnly = false);

    }
}