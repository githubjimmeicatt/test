using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Security.Cryptography.X509Certificates;
using Icatt.Security.Saml2.Access.CertificateStore;
using Icatt.Security.Saml2.Engine.Metadata;
using Icatt.Security.Saml2.Engine.Signing;

namespace Sphdhv.Saml.Metadata.Console
{
    public class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            string certificateSubject;
            MetadataConfiguration metadataConfiguration;
            CreateProductionConfig(out certificateSubject, out metadataConfiguration);
            //CreateAcceptConfig(out certificateSubject, out metadataConfiguration);
            GenerateMetadataFile(certificateSubject, metadataConfiguration);

        }

        private static void CreateAcceptConfig(out string certificateSubject, out MetadataConfiguration metadataConfiguration)
        {
            // input values;
            var metadataEntityId = "https://mijn.accept.pensioenfondshaskoningdhv.nl/metadata.xml"; // AR: Lijkt een unieke maar wel constante identifier te moeten zijn

            var assertionConsumerServiceEndpointLocalKlantportaal = "https://localhost:44304/authentication/verifytoken";
            var assertionConsumerServiceEndpointAcceptIcattKlantportaalAA = "https://klantportaal-sphdhv.accept.icatt.nl/authentication/VerifyToken";
            var assertionConsumerServiceEndpointAcceptIcattKlantportaalOO = "bestaat niet meer";
            var assertionConsumerServiceEndpointAcceptMijnDhv = "https://mijn.accept.pensioenfondshaskoningdhv.nl/DesktopModules/Sphdhv/KlantPortaal/api/digid/VerifyToken";

            var certificateKeyName = "SSO Key"; // AR: Vermoed dat deze niet verplicht is;
            certificateSubject = "CN=mijn.accept.pensioenfondshaskoningdhv.nl, SERIALNUMBER=00000003623067230000, O=Stichting Pensioenfonds HaskoningDHV, L=Amersfoort, S=Utrecht, C=NL";
            var id = "_1234567";

            // configuration objects
            metadataConfiguration = new MetadataConfiguration()
            {
                EntityId = metadataEntityId,
                AssertionConsumerServiceArtifactLocations = new List<string>() {
                    assertionConsumerServiceEndpointLocalKlantportaal,
                    assertionConsumerServiceEndpointAcceptIcattKlantportaalAA,
                    assertionConsumerServiceEndpointAcceptIcattKlantportaalOO,
                    assertionConsumerServiceEndpointAcceptMijnDhv,
                },
                KeyName = certificateKeyName,
                Id = id
            };
        }

        private static void CreateProductionConfig(out string certificateSubject, out MetadataConfiguration metadataConfiguration)
        {
            // input values;
            var metadataEntityId = "https://mijn.pensioenfondshaskoningdhv.nl/metadata.xml"; // AR: Lijkt een unieke maar wel constante identifier te moeten zijn

            var assertionConsumerServiceEndpointProdMijnDhvRoot = "https://mijn.pensioenfondshaskoningdhv.nl/DesktopModules/Sphdhv/KlantPortaal/api/digid/VerifyToken";

            var certificateKeyName = "SSO Key"; // AR: Vermoed dat deze niet verplicht is;
            certificateSubject = "CN=mijn.pensioenfondshaskoningdhv.nl, SERIALNUMBER=00000003623067230000, O=Stichting Pensioenfonds HaskoningDHV, L=Amersfoort, S=Utrecht, C=NL";
            var id = "_1234567";

            // configuration objects
            metadataConfiguration = new MetadataConfiguration()
            {
                EntityId = metadataEntityId,
                AssertionConsumerServiceArtifactLocations = new List<string>() {
                    assertionConsumerServiceEndpointProdMijnDhvRoot
                },
                KeyName = certificateKeyName,
                Id = id
            };
        }

        private static void GenerateMetadataFile(string certificateSubject, MetadataConfiguration metadataConfiguration)
        {

            // Get certificate from store
            var certificateStoreAccess = new CertificateStoreAccess();
            var certificate = certificateStoreAccess.FindBySubjectDistinguishedName(StoreName.My, StoreLocation.LocalMachine, certificateSubject);

            // Get metadata xml
            var manager = new MetadataEngine();
            var metadataXml = manager.CreateMetadata(metadataConfiguration, certificate);

            // Sign metadata xml
            var signingEngine = new SamlSignatureEngine();
            var xml = signingEngine.SignElement(metadataXml.DocumentElement, certificate, "ID", metadataConfiguration.Id);

            //var isValid = signingEngine.ValidateSignature(xml, certificate, "ID", metadataConfiguration.Id);

            //Debug.Assert(isValid);

            System.Console.WriteLine(xml.OuterXml);
            System.Console.ReadLine();
        }
    }
}
