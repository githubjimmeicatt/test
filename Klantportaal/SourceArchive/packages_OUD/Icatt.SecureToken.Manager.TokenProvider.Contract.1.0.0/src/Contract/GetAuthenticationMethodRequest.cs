using System.Runtime.Serialization;

namespace Icatt.SecureToken.Manager.TokenProvider.Contract
{
    [DataContract]
    public class GetAuthenticationMethodRequest
    {
        public string ClientAppId { get; set; }

        public string ClientAppEnvironment { get; set; } //Dev, Accept, Prod, Test

        public string ClientSecret { get; set; }

        public string[] Scopes { get; set; }
        public string RedirectUrl { get; set; }
        public string State { get; set; }

        public bool PromptConsent { get; set; } = false;
    }
}