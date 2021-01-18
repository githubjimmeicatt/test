using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography.Xml;
using System.Xml;

namespace Icatt.Security.Saml2.Engine.Signing
{
    public class SamlSignatureEngine
    {
        public XmlElement SignElement(XmlElement documentElement, X509Certificate2 certificate, string referenceAttributeName, string referenceAttributeValue)
        {
            if (null != documentElement)
            {
                var signature = CreateSignature(documentElement, certificate, referenceAttributeName, referenceAttributeValue);
                if (null != signature && documentElement.ChildNodes.Count > 0)
                {
                    var firstChild = documentElement.ChildNodes[0];
                    documentElement.InsertBefore(signature, firstChild);
                }
            }
            return documentElement;
        }

        public XmlElement CreateSignature(XmlElement documentElement, X509Certificate2 certificate, string referenceAttributeName, string referenceAttributeValue)
        {
            var sig = new SignedXmlWrapper(documentElement, referenceAttributeName);

            //vereist voor versleuteling post berichten
            sig.SignedInfo.SignatureMethod = @"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256";
            sig.SignedInfo.CanonicalizationMethod = "http://www.w3.org/2001/10/xml-exc-c14n#";
            // Create a reference to be signed. 
            var reference = new Reference { Uri = "#" + referenceAttributeValue, DigestMethod = @"http://www.w3.org/2001/04/xmlenc#sha256" };
            reference.AddTransform(new XmlDsigEnvelopedSignatureTransform());
            reference.AddTransform(new XmlDsigExcC14NTransform() { InclusiveNamespacesPrefixList = "ds saml samlp xs" });
            sig.AddReference(reference);
            
            sig.SigningKey = certificate.GetRSAPrivateKey();
            sig.ComputeSignature();
            // Compute the signature. 


            return sig.GetXml();


        }


        /// <summary>
        /// Valideert tegen <paramref name="certificate"/> en zoekt Signature node zonde namespace qualificatie
        /// </summary>
        public bool ValidateSignature(XmlElement documentElement, X509Certificate2 certificate, string referenceAttributeName, string referenceAttributeValue)
        {
            var sig = new SignedXmlWrapper(documentElement, referenceAttributeName);


            var reference = new Reference { Uri = "#" + referenceAttributeValue };
            reference.AddTransform(new XmlDsigEnvelopedSignatureTransform());
            reference.AddTransform(new XmlDsigC14NTransform());
            sig.AddReference(reference);

            var nodeList = documentElement.GetElementsByTagName("Signature");
            if (0 == nodeList.Count)
                return false;

            foreach (var node in nodeList)
            {
                sig.LoadXml((XmlElement)node);

                if (!sig.CheckSignature(certificate, false))
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary>
        /// Valideert tegen meegestuurde publice key en zoekt Signature node binnen namespace qualificatie 'http://www.w3.org/2000/09/xmldsig#'
        /// </summary>
        public bool ValidateArtifactSignature(XmlElement documentElement, string referenceAttributeName, string referenceAttributeValue)
        {

            var sig = new SignedXmlWrapper(documentElement, referenceAttributeName);


            var reference = new Reference { Uri = "#" + referenceAttributeValue };
            reference.AddTransform(new XmlDsigEnvelopedSignatureTransform());
            reference.AddTransform(new XmlDsigC14NTransform());
            sig.AddReference(reference);

            var nodeList = documentElement.GetElementsByTagName("Signature", "http://www.w3.org/2000/09/xmldsig#");
            if (0 == nodeList.Count)
                return false;

            foreach (var node in nodeList)
            {
                sig.LoadXml((XmlElement)node);

                if (!sig.CheckSignature()) //false
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary>
        /// Validates the artifact signature and, if the assertion is present, the assertion signature
        /// </summary>
        /// <param name="documentRoot"></param>
        /// <param name="referenceAttributeValue"></param>
        /// <returns></returns>
        public bool ValidateSamlSignatures(XmlElement documentRoot)
        {
            var nsmgr = new XmlNamespaceManager(documentRoot.OwnerDocument.NameTable);
            nsmgr.AddNamespace("p", "urn:oasis:names:tc:SAML:2.0:protocol");
            nsmgr.AddNamespace("a", "urn:oasis:names:tc:SAML:2.0:assertion");
            nsmgr.AddNamespace("s", "http://www.w3.org/2000/09/xmldsig#");

            var artifact = documentRoot.SelectSingleNode("//p:ArtifactResponse", nsmgr) as XmlElement;


            //Validate artifact signature
            var valid = ValidateElementSignature(artifact, nsmgr);

            if (!valid) return false;

            var assertion = artifact.SelectSingleNode("//a:Assertion", nsmgr) as XmlElement;

            if (assertion == null)
            {
                return true;
            }

            //Validate assertion signature
            return ValidateElementSignature(artifact, nsmgr);
        }

        private bool ValidateElementSignature(XmlElement artifact, XmlNamespaceManager nsmgr)
        {
            if (artifact == null)
                return false;

            var idValue = artifact.Attributes["ID"]?.Value;

            if (idValue == null)
                return false;

            var sig = new SignedXmlWrapper(artifact, "ID");
            var reference = new Reference { Uri = "#" + idValue };

            reference.AddTransform(new XmlDsigEnvelopedSignatureTransform());
            reference.AddTransform(new XmlDsigC14NTransform());
            sig.AddReference(reference);

            var signatureNode = artifact.SelectSingleNode("./s:Signature", nsmgr);
            if (signatureNode == null)
                return false;

            sig.LoadXml((XmlElement)signatureNode);

            if (!sig.CheckSignature()) //false
            {
                return false;
            }
            return true;
        }

        private class SignedXmlWrapper : SignedXml
        {
            private readonly string _referenceAttributeName;

            public SignedXmlWrapper(XmlElement element, string referenceAttributeName) : base(element)
            {
                _referenceAttributeName = referenceAttributeName;
            }

            public override XmlElement GetIdElement(XmlDocument document, string idValue)
            {
                return (XmlElement)document.SelectSingleNode(string.Format("//*[@" + _referenceAttributeName + "='{0}']", idValue));
            }

        }
    }
}
