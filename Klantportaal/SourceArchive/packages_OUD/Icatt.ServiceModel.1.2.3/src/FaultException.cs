using System;
using System.Runtime.Serialization;

namespace Icatt.ServiceModel
{
    [DataContract]
    public class FaultException : Exception
    {

        public FaultException(Exception e) : base("Fault:" + e.Message,e)
        {
        }
    }


}
