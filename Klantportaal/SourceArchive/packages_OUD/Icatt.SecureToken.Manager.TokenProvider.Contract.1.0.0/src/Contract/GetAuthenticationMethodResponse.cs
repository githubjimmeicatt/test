using System.Runtime.Serialization;

namespace Icatt.SecureToken.Manager.TokenProvider.Contract
{
    [DataContract]
    public class GetAuthenticationMethodResponse
    {
        [DataMember]
        public string Url { get; set; }
    }
}
