using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:metadata")]
    public class SpSsoDescriptor
    {
        public KeyDescriptor KeyDescriptor { get; set; }

        [XmlElement("SingleLogoutService")]
        public SingleLogoutService[] SingleLogoutServices { get; set; }

        [XmlElement("AssertionConsumerService")]
        public AssertionConsumerService[] AssertionConsumerServices { get; set; }

        [XmlAttribute()]
        public bool WantAssertionsSigned { get; set; }

        [XmlAttribute("protocolSupportEnumeration")]
        public string ProtocolSupportEnumeration { get; set; }
    }
}