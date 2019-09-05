using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.OAuth.Contract
{
    [DataContract]
    public class AuthenticationMethod
    {
        [DataMember]
        public AuthMethodType Type { get; set; }
        [DataMember]
        public string Url { get; set; }

        [DataMember]
        public string Html { get; set; }

        [DataMember]
        public NameValuePair[] Parameters { get; set; }


    }

}
