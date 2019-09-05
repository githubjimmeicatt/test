using System.Runtime.Serialization;

namespace Icatt.OAuth.Contract
{
    [DataContract]
    public class Claim
    {
        [DataMember]
        public string Issuer { get; set; }
        [DataMember]
        public string Value { get; set; }
        [DataMember]
        public string Type { get; set; }

        [DataMember]
        public string OriginalIssuer { get; set; }

        [DataMember]
        public string ValueType { get; set; }
    }

}
