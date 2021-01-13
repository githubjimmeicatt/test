using System;
using System.Runtime.Serialization;

namespace Icatt.Digid.Access.Contract
{
    [DataContract]
    public class DigidSettings
    {
        [DataMember]
        public byte AssertionConsumerServiceEndPointIndex { get; set; }
        [DataMember]
        public String CertificateIssuer { get; set; }
        [DataMember]
        public string CertificateSubjectDistinguishedName { get; set; }

        [DataMember]
        public string RequestAuthenticationEndpoint { get; set; }
        [DataMember]
        public string ResolveArtifactEndpoint { get; set; }
    }


}