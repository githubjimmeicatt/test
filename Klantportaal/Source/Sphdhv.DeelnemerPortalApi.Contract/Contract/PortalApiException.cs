using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    public class PortalApiException : Exception
    {

        public PortalApiException(Exception e) : base(e.Message, e)
        {
        }
    }
}
