using System.Runtime.Serialization;

namespace Icatt.SecureToken.Manager.TokenProvider.Contract
{
    [DataContract]
    public class RefreshTokenRequest
    {
        [DataMember]
        public string RefreshToken { get; set; }
        [DataMember]
        public string[] Scopes { get; set; }
        [DataMember]
        public string RedirectUrl { get; set; }
        [DataMember]
        public string State { get; set; }
    }
}