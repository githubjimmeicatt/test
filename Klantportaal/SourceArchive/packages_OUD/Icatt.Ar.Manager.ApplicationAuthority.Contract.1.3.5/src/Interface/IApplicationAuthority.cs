using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Ar.Manager.ApplicationAuthority.Interface
{
    public interface IApplicationAuthority
    {
        Contract.ApplicationEnvironment IdentifyThumbprint();

        Contract.PublicCertificate ApplicationEnvironmentCertificate(Contract.ApplicationEnvironment appenv);
    }
}
