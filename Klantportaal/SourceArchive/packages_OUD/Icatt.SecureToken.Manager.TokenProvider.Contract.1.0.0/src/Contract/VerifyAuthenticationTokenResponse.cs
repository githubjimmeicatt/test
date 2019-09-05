using System;
using System.Runtime.Serialization;

namespace Icatt.SecureToken.Manager.TokenProvider.Contract
{
    [DataContract]
    public class VerifyAuthenticationTokenResponse
    {
        [DataMember]
        public string AccessToken { get; set; }
        [DataMember]
        public string RefreshToken { get; set; }
        [DataMember]
        public string TokenType { get; set; }
        [DataMember]
        public long? ExpiresInSeconds { get; set; }
        [DataMember]
        public DateTime IssuedUtc { get; set; }
        [DataMember]
        public string UserId { get; set; }

    }
}