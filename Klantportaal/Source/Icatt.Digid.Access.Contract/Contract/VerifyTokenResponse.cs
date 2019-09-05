using System;
using System.Runtime.Serialization;

namespace Icatt.Digid.Access.Contract
{
    [DataContract]
    public class VerifyTokenResponse
    {
        [DataMember]
        public StatusCode Status { get; set; }
        [DataMember]
        public string Bsn { get; set; }
        [DataMember]
        public string Sofi { get; set; }
        [DataMember]
        public string Issuer { get; set; }
        [DataMember]
        public string InResponseTo { get; set; }
        [DataMember]
        public string Id { get; set; }
        [DataMember]
        public DateTime IssuedAt { get; set; }
        public string ClientIp { get; set; }
    }

    public enum StatusCode
    {
        Success = 0,
        AuthnFailed = 1,
        ServiceFailure = 2,
        InvalidArtifactSignature= 3,

        
    }
}
