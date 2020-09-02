using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    public class AuthnRequestRequestedAuthnContext
    {

        private string _authnContextClassRefField;

        private string _comparisonField;

        /// <remarks/>
        [XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
        public string AuthnContextClassRef
        {
            get
            {
                return _authnContextClassRefField;
            }
            set
            {
                _authnContextClassRefField = value;
            }
        }

        /// <remarks/>
        [XmlAttribute()]
        public string Comparison
        {
            get
            {
                return _comparisonField;
            }
            set
            {
                _comparisonField = value;
            }
        }
    }
}