using System.Security.Cryptography.X509Certificates;

namespace Icatt.Security.Saml2.Access.CertificateStore
{
    public class CertificateStoreAccess
    {
        public X509Certificate2 FindCertificateByThumbprint(StoreName storeName, StoreLocation storeLocation, string thumbprint)
        {
            using (var store = new X509Store(storeName, storeLocation))
            {
                store.Open(OpenFlags.OpenExistingOnly);
                var array = store.Certificates.Find(X509FindType.FindByThumbprint, thumbprint, true);
                if (0 == array.Count)
                {
                    return null;
                }
                store.Close();
                return array[0];
            }
        }
    }
}
