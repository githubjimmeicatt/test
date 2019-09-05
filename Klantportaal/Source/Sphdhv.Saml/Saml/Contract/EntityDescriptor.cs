using System;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:metadata")]
    [XmlRoot(Namespace = "urn:oasis:names:tc:SAML:2.0:metadata", IsNullable = false)]
    public class EntityDescriptor
    {
        [XmlAttribute("ID")]
        public string Id { get; set; }


        [XmlElement("SPSSODescriptor")]
        public SpSsoDescriptor SpSsoDescriptor { get; set; }

        [XmlAttribute("entityID")]
        public string EntityId { get; set; }

        public XmlDocument ToXml()
        {
            var xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(Serialize());
            return xmlDoc;
        }

        private string Serialize()
        {
            var ns = new XmlSerializerNamespaces();
            ns.Add("md", "urn:oasis:names:tc:SAML:2.0:metadata");
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