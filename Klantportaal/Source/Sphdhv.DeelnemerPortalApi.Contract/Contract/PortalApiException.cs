using System;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    public class PortalApiException : Exception
    {

        public PortalApiException(Exception e) : base(e.Message, e)
        {
        }
    }
}
