using System.Runtime.Serialization;

namespace Icatt.SecureToken.Manager.TokenProvider.Contract
{
    [DataContract]
    public class GetAccessTokenRequest
    {
        [DataMember]
        public string ApplicationId { get; set; }
        [DataMember]
        public string UserId { get; set; }
        [DataMember]
        public string AuthenticationCode { get; set; }
        [DataMember]
        public string[] Scopes { get; set; }
        [DataMember]
        public string RedirectUrl { get; set; }
        [DataMember]
        public string State { get; set; }
    }
}