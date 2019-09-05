using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Azure.Access
{
    public interface IKeyVault
    {
        byte[] GetSecret(string secret);  
    }
}
