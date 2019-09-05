using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2001/10/xml-exc-c14n#")]
    [XmlRoot(Namespace = "http://www.w3.org/2001/10/xml-exc-c14n#", IsNullable = false)]
    public class InclusiveNamespaces
    {
        [XmlAttribute()]
        public string PrefixList { get; set; }
    }
}