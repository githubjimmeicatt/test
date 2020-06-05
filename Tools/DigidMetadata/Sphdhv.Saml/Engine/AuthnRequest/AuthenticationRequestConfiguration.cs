namespace Icatt.Security.Saml2.Engine.AuthnRequest
{
    public class AuthenticationRequestConfiguration
    {
        public string Id { get; set; }
        public string Issuer { get; set; }
        public byte AssertionConsumerServiceIndex { get; set; }
        public string Destination { get; set; }
    }
}
