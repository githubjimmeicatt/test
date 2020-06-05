using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Engine.Serialization
{
    public class SamlSerializationEngine
    {
        public XmlDocument ToXml<T>(T obj)
        {
            var xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(Serialize<T>(obj));
            return xmlDoc;
        }

        private string Serialize<T>(T obj)
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
                    // var responseSerializer = new XmlSerializer(GetType());
                    var responseSerializer = new XmlSerializer(typeof(T));
                    responseSerializer.Serialize(responseWriter, obj, ns);
                    responseWriter.Close();
                }

                return stringWriter.ToString();
            }
        }
    }
}
