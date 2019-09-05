using System;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Xml;
using Icatt.Security.Saml2.Saml.Contract;

namespace Icatt.Security.Saml2.Engine.Metadata
{
    public class MetadataEngine
    {
        public XmlDocument CreateMetadata(MetadataConfiguration configuration, X509Certificate2 certificate)
        {
            var descriptor = new EntityDescriptor
            {
                EntityId = configuration.EntityId,
                Id = configuration.Id,
                SpSsoDescriptor = new SpSsoDescriptor()
                {
                    WantAssertionsSigned = false, //stond op true
                    ProtocolSupportEnumeration = "urn:oasis:names:tc:SAML:2.0:protocol",
                    KeyDescriptor = new KeyDescriptor()
                    {
                        Use = "signing",
                        KeyInfo = new KeyInfo()
                        {
                            KeyName = configuration.KeyName,
                            X509Data = new KeyInfoX509Data()
                            {
                                X509Certificate = Convert.ToBase64String(certificate.Export(X509ContentType.Cert), Base64FormattingOptions.None)
                            }
                        }
                    },
                    
                    AssertionConsumerServices = configuration.AssertionConsumerServiceArtifactLocations.Select((a, index) =>
                        new AssertionConsumerService()
                        {
                            Binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact",
                            Location = a,
                            Index = (byte)index
                        }
                    ).ToArray()
                    
                }
            };
            return descriptor.ToXml();
        }
    }
}
