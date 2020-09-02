using System;
using System.Xml;
using Icatt.Security.Saml2.Saml.Contract;

namespace Icatt.Security.Saml2.Engine.AuthnRequest
{
    public class AuthenticationRequestBuilder
    {
        public XmlDocument CreateRequest(AuthenticationRequestConfiguration configuration)
        {

            var request = new Saml.Contract.AuthnRequest
            {
                Id = configuration.Id,
                Issuer = configuration.Issuer,
                IssueInstant = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ"),
                ForceAuthn = false,
                Version = "2.0",
                AssertionConsumerServiceIndex = configuration.AssertionConsumerServiceIndex,
                Destination = configuration.Destination,
                RequestedAuthnContext = new AuthnRequestRequestedAuthnContext
                {
                    Comparison = "minimum",
                    AuthnContextClassRef = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
                }
            };

            return request.ToXml();
        }
    }
}
