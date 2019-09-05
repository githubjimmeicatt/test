using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public class KeyInfoX509Data
    {
        public string X509Certificate { get; set; }
    }
}