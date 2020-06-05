using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{

    [Serializable()]
     [XmlType(AnonymousType = true, Namespace = "soapenv=http://schemas.xmlsoap.org/soap/envelope/")]
    [XmlRoot(Namespace  = "http://schemas.xmlsoap.org/soap/envelope/", IsNullable = false, ElementName = "soapenv" )]
    public class SoapEnvelope
    {

        private Body _body;




        [XmlElement(Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public Body Body
        {
            get
            {
                return _body;
            }
            set
            {
                _body = value;
            }
        }
 

    }

    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
    public class Body
    {
        private ArtifactResolve _artifactResolve;

        public ArtifactResolve ArtifactResolve
        {
            get
            {
                return _artifactResolve;
            }
            set
            {
                _artifactResolve = value;
            }
        }

    }
}
