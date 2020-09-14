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
            string certificateThumbprint;
            MetadataConfiguration metadataConfiguration;
            CreateProductionConfig(out certificateThumbprint, out metadataConfiguration);
           // CreateAcceptConfig(out certificateThumbprint, out metadataConfiguration);
            GenerateMetadataFile(certificateThumbprint, metadataConfiguration);

        }

        private static void CreateAcceptConfig(out string certificateThumbprint, out MetadataConfiguration metadataConfiguration)
        {
            // input values;
            var metadataEntityId = "https://mijn.accept.pensioenfondshaskoningdhv.nl/metadata.xml"; // AR: Lijkt een unieke maar wel constante identifier te moeten zijn

            var assertionConsumerServiceEndpointLocalKlantportaal = "https://localhost:44304/authentication/verifytoken";
            var assertionConsumerServiceEndpointAcceptIcattKlantportaalAA = "https://klantportaal-sphdhv.accept.icatt.nl/AA/authentication/VerifyToken";
            var assertionConsumerServiceEndpointAcceptIcattKlantportaalOO = "https://klantportaal-sphdhv.accept.icatt.nl/OO/authentication/VerifyToken";
            var assertionConsumerServiceEndpointAcceptMijnDhv = "https://mijn.accept.pensioenfondshaskoningdhv.nl/DesktopModules/Sphdhv/KlantPortaal/api/digid/VerifyToken";

            var certificateKeyName = "SSO Key"; // AR: Vermoed dat deze niet verplicht is;
            certificateThumbprint = "db6ebc6098355941e2b741fe54b647a32cca4c63";
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
            certificateSubject = "d0b0f307eef13df6b4e91b4f140c8608d9654522";
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

        private static void GenerateMetadataFile(string thumbprint, MetadataConfiguration metadataConfiguration)
        {

            // Get certificate from store
            var certificateStoreAccess = new CertificateStoreAccess();
            var certificate = certificateStoreAccess.FindCertificateByThumbprint(StoreName.My, StoreLocation.LocalMachine, thumbprint);

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
