using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;

namespace Sphdhv.Klantportaal.Audit.Engine.Certificate
{
    public   class CertificateAccess : ICertificateAccess
    {

        public   X509Certificate2 FindCertificateByThumbprint(string findValue, bool validOnly = false)
        {

            return  FindCertificateByThumbprint(findValue, StoreName.My, StoreLocation.LocalMachine, validOnly);


          
        }

        public X509Certificate2 FindCertificateByThumbprint(string findValue, StoreName storeName, StoreLocation storeLocation,  bool validOnly = false)
        {
            X509Store store = new X509Store(storeName, storeLocation);
            try
            {
                store.Open(OpenFlags.ReadOnly);
                //tfs projects > ICATT packages / icatt.Certificate.Access
                //todo laatste param moet gezet kunne worden. storename 
                //en store location ook als params meegeven (overload).
                X509Certificate2Collection col = store.Certificates.Find(X509FindType.FindByThumbprint, findValue, validOnly); // Don't validate certs, since the test root isn't installed.
                if (col == null || col.Count == 0)
                    return null;
                return col[0];
            }
            finally
            {
                store.Close();
            }
        }


    }
}