using System;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    [XmlRoot(Namespace = "urn:oasis:names:tc:SAML:2.0:protocol", IsNullable = false)]
    public class AuthnRequest
    {
        private string _issuerField;

        private AuthnRequestRequestedAuthnContext _requestedAuthnContextField;

        private string _destinationField;

        private bool _forceAuthnField;

        private string _idField;

        private string _versionField;

        private string _issueInstantField;

        private byte _assertionConsumerServiceIndexField;

        private string _providerNameField;

        
        [XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
        public string Issuer
        {
            get
            {
                return _issuerField;
            }
            set
            {
                _issuerField = value;
            }
        }
        
        public AuthnRequestRequestedAuthnContext RequestedAuthnContext
        {
            get
            {
                return _requestedAuthnContextField;
            }
            set
            {
                _requestedAuthnContextField = value;
            }
        }

        
        [XmlAttribute()]
        public string Destination
        {
            get
            {
                return _destinationField;
            }
            set
            {
                _destinationField = value;
            }
        }

        
        [XmlAttribute()]
        public bool ForceAuthn
        {
            get
            {
                return _forceAuthnField;
            }
            set
            {
                _forceAuthnField = value;
            }
        }

        
        [XmlAttribute("ID")]
        public string Id
        {
            get
            {
                return _idField;
            }
            set
            {
                _idField = value;
            }
        }

        
        [XmlAttribute()]
        public string Version
        {
            get
            {
                return _versionField;
            }
            set
            {
                _versionField = value;
            }
        }

        
        [XmlAttribute()]
        public string IssueInstant
        {
            get
            {
                return _issueInstantField;
            }
            set
            {
                _issueInstantField = value;
            }
        }

        
        [XmlAttribute()]
        public byte AssertionConsumerServiceIndex
        {
            get
            {
                return _assertionConsumerServiceIndexField;
            }
            set
            {
                _assertionConsumerServiceIndexField = value;
            }
        }

        
        [XmlAttribute()]
        public string ProviderName
        {
            get
            {
                return _providerNameField;
            }
            set
            {
                _providerNameField = value;
            }
        }



        public XmlDocument ToXml()
        {
            var xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(Serialize());
            return xmlDoc;
        }

        private string Serialize()
        {
            var ns = new XmlSerializerNamespaces();
            ns.Add("samlp", "urn:oasis:names:tc:SAML:2.0:protocol");
            ns.Add("saml", "urn:oasis:names:tc:SAML:2.0:assertion");
            ns.Add("ds", "http://www.w3.org/2000/09/xmldsig#");
            ns.Add("ec", "http://www.w3.org/2001/10/xml-exc-c14n#");

            using (var stringWriter = new StringWriter())
            {

                using (var responseWriter = XmlWriter.Create(
                        stringWriter,
                        new XmlWriterSettings
                        {
                            OmitXmlDeclaration = true,
                            Indent = true,
                            Encoding = Encoding.UTF8
                        }
                    )
                )
                {
                    var responseSerializer = new XmlSerializer(GetType());
                    responseSerializer.Serialize(responseWriter, this, ns);
                    responseWriter.Close();
                }

                return stringWriter.ToString();
            }
        }
    }
}
