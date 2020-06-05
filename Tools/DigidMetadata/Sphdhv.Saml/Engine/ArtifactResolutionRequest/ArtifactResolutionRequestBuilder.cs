using System;
using System.Diagnostics;
using System.Security.Cryptography.X509Certificates;
using System.Xml;
using Icatt.Security.Saml2.Engine.Serialization;
using Icatt.Security.Saml2.Engine.Signing;
using Icatt.Security.Saml2.Saml.Contract;

namespace Icatt.Security.Saml2.Engine.ArtifactResolutionRequest
{
    public class ArtifactResolutionRequestBuilder
    {
        public XmlDocument CreateRequest(ArtifactResolutionRequestConfiguration configuration)
        {

            var request = new ArtifactResolve
            {
                Id = configuration.Id,
                Issuer = configuration.Issuer,
                IssueInstant = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ"),
                Version = "2.0",
                Artifact = configuration.Artifact 
            };


            var serializer  = new SamlSerializationEngine();
            var result = serializer.ToXml(request);
            return result;
        }

        /// <summary>
        /// Wraps a saml
        /// </summary>
        /// <param name="samlArtefact"></param>
        /// <param name="id"></param>
        /// <param name="issuer"></param>
        /// <param name="clientCert"></param>
        /// <returns></returns>
        public XmlDocument CreateSamlSoapEnvelope(string samlArtefact, string id, string issuer, X509Certificate2 clientCert)
        {
            //creeer artifact resolve bericht
            var artifactResolveEngine = new ArtifactResolutionRequestBuilder();

            var xmlDoc = artifactResolveEngine.CreateRequest(new ArtifactResolutionRequestConfiguration { Artifact = samlArtefact, Id = id, Issuer = issuer });
            Debug.Assert(xmlDoc.DocumentElement != null);

            //Create signature for artifact resolution request
            var signingEngine = new SamlSignatureEngine();

            var signature = signingEngine.CreateSignature(xmlDoc.DocumentElement, clientCert, "ID", id);

            //Insert signature node
            var child = xmlDoc.DocumentElement.ChildNodes[0];
            xmlDoc.DocumentElement.InsertBefore(signature, child);

            //Wrap in SOAP envelope
            var soapEnvelope = $"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><soapenv:Body>{xmlDoc.DocumentElement.OuterXml}</soapenv:Body></soapenv:Envelope>";

            var soapEnvelopeXml = new XmlDocument { PreserveWhitespace = true };

            soapEnvelopeXml.LoadXml(soapEnvelope);

            return soapEnvelopeXml;
        }
    }
}
