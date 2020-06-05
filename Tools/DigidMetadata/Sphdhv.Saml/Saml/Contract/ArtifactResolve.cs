using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{

    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    [XmlRoot(Namespace = "urn:oasis:names:tc:SAML:2.0:protocol", IsNullable = false)]
   
    public class ArtifactResolve
    {

        private string _issuerField;
        
        private string _idField;

        private string _versionField;

        private string _issueInstantField;
        
        private string _artifact;
 

 

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


        /// <remarks/>
        [XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
        public string Artifact
        {
            get
            {
                return _artifact;
            }
            set
            {
                _artifact = value;
            }
        }

    }
}
