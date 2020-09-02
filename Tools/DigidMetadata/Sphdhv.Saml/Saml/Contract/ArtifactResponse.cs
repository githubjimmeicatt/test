using System;

namespace Icatt.Security.Saml2.Saml.Contract
{
    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
    [System.Xml.Serialization.XmlRoot(Namespace = "http://schemas.xmlsoap.org/soap/envelope/", IsNullable = false)]
    public partial class Envelope
    {

        private EnvelopeBody bodyField;

        /// <remarks/>
        public EnvelopeBody Body
        {
            get
            {
                return bodyField;
            }
            set
            {
                bodyField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
    public partial class EnvelopeBody
    {

        private ArtifactResponse artifactResponseField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
        public ArtifactResponse ArtifactResponse
        {
            get
            {
                return artifactResponseField;
            }
            set
            {
                artifactResponseField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    [System.Xml.Serialization.XmlRoot(Namespace = "urn:oasis:names:tc:SAML:2.0:protocol", IsNullable = false)]
    public partial class ArtifactResponse
    {

        private string issuerField;

        private Signature signatureField;

        private ArtifactResponseStatus statusField;

        private ArtifactResponseResponse responseField;

        private string idField;

        private decimal versionField;

        private DateTime issueInstantField;

        private string inResponseToField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
        public string Issuer
        {
            get
            {
                return issuerField;
            }
            set
            {
                issuerField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "http://www.w3.org/2000/09/xmldsig#")]
        public Signature Signature
        {
            get
            {
                return signatureField;
            }
            set
            {
                signatureField = value;
            }
        }

        /// <remarks/>
        public ArtifactResponseStatus Status
        {
            get
            {
                return statusField;
            }
            set
            {
                statusField = value;
            }
        }

        /// <remarks/>
        public ArtifactResponseResponse Response
        {
            get
            {
                return responseField;
            }
            set
            {
                responseField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string ID
        {
            get
            {
                return idField;
            }
            set
            {
                idField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public decimal Version
        {
            get
            {
                return versionField;
            }
            set
            {
                versionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime IssueInstant
        {
            get
            {
                return issueInstantField;
            }
            set
            {
                issueInstantField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string InResponseTo
        {
            get
            {
                return inResponseToField;
            }
            set
            {
                inResponseToField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    [System.Xml.Serialization.XmlRoot(Namespace = "http://www.w3.org/2000/09/xmldsig#", IsNullable = false)]
    public partial class Signature
    {

        private SignatureSignedInfo signedInfoField;

        private string signatureValueField;

        private SignatureKeyInfo keyInfoField;

        /// <remarks/>
        public SignatureSignedInfo SignedInfo
        {
            get
            {
                return signedInfoField;
            }
            set
            {
                signedInfoField = value;
            }
        }

        /// <remarks/>
        public string SignatureValue
        {
            get
            {
                return signatureValueField;
            }
            set
            {
                signatureValueField = value;
            }
        }

        /// <remarks/>
        public SignatureKeyInfo KeyInfo
        {
            get
            {
                return keyInfoField;
            }
            set
            {
                keyInfoField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureSignedInfo
    {

        private SignatureSignedInfoCanonicalizationMethod canonicalizationMethodField;

        private SignatureSignedInfoSignatureMethod signatureMethodField;

        private SignatureSignedInfoReference referenceField;

        /// <remarks/>
        public SignatureSignedInfoCanonicalizationMethod CanonicalizationMethod
        {
            get
            {
                return canonicalizationMethodField;
            }
            set
            {
                canonicalizationMethodField = value;
            }
        }

        /// <remarks/>
        public SignatureSignedInfoSignatureMethod SignatureMethod
        {
            get
            {
                return signatureMethodField;
            }
            set
            {
                signatureMethodField = value;
            }
        }

        /// <remarks/>
        public SignatureSignedInfoReference Reference
        {
            get
            {
                return referenceField;
            }
            set
            {
                referenceField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureSignedInfoCanonicalizationMethod
    {

        private string algorithmField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Algorithm
        {
            get
            {
                return algorithmField;
            }
            set
            {
                algorithmField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureSignedInfoSignatureMethod
    {

        private string algorithmField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Algorithm
        {
            get
            {
                return algorithmField;
            }
            set
            {
                algorithmField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureSignedInfoReference
    {

        private SignatureSignedInfoReferenceTransform[] transformsField;

        private SignatureSignedInfoReferenceDigestMethod digestMethodField;

        private string digestValueField;

        private string uRIField;

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("Transform", IsNullable = false)]
        public SignatureSignedInfoReferenceTransform[] Transforms
        {
            get
            {
                return transformsField;
            }
            set
            {
                transformsField = value;
            }
        }

        /// <remarks/>
        public SignatureSignedInfoReferenceDigestMethod DigestMethod
        {
            get
            {
                return digestMethodField;
            }
            set
            {
                digestMethodField = value;
            }
        }

        /// <remarks/>
        public string DigestValue
        {
            get
            {
                return digestValueField;
            }
            set
            {
                digestValueField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string URI
        {
            get
            {
                return uRIField;
            }
            set
            {
                uRIField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureSignedInfoReferenceTransform
    {

        private InclusiveNamespaces inclusiveNamespacesField;

        private string algorithmField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "http://www.w3.org/2001/10/xml-exc-c14n#")]
        public InclusiveNamespaces InclusiveNamespaces
        {
            get
            {
                return inclusiveNamespacesField;
            }
            set
            {
                inclusiveNamespacesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Algorithm
        {
            get
            {
                return algorithmField;
            }
            set
            {
                algorithmField = value;
            }
        }
    }

    ///// <remarks/>
    //[System.SerializableAttribute()]
    //[System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.w3.org/2001/10/xml-exc-c14n#")]
    //[System.Xml.Serialization.XmlRootAttribute(Namespace = "http://www.w3.org/2001/10/xml-exc-c14n#", IsNullable = false)]
    //public partial class InclusiveNamespaces
    //{

    //    private string prefixListField;

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlAttributeAttribute()]
    //    public string PrefixList
    //    {
    //        get
    //        {
    //            return this.prefixListField;
    //        }
    //        set
    //        {
    //            this.prefixListField = value;
    //        }
    //    }
    //}

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureSignedInfoReferenceDigestMethod
    {

        private string algorithmField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Algorithm
        {
            get
            {
                return algorithmField;
            }
            set
            {
                algorithmField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureKeyInfo
    {

        private string keyNameField;

        private SignatureKeyInfoX509Data x509DataField;

        /// <remarks/>
        public string KeyName
        {
            get
            {
                return keyNameField;
            }
            set
            {
                keyNameField = value;
            }
        }

        /// <remarks/>
        public SignatureKeyInfoX509Data X509Data
        {
            get
            {
                return x509DataField;
            }
            set
            {
                x509DataField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://www.w3.org/2000/09/xmldsig#")]
    public partial class SignatureKeyInfoX509Data
    {

        private string x509CertificateField;

        /// <remarks/>
        public string X509Certificate
        {
            get
            {
                return x509CertificateField;
            }
            set
            {
                x509CertificateField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    public partial class ArtifactResponseStatus
    {

        private ArtifactResponseStatusStatusCode statusCodeField;

        /// <remarks/>
        public ArtifactResponseStatusStatusCode StatusCode
        {
            get
            {
                return statusCodeField;
            }
            set
            {
                statusCodeField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    public partial class ArtifactResponseStatusStatusCode
    {

        private string valueField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Value
        {
            get
            {
                return valueField;
            }
            set
            {
                valueField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    public partial class ArtifactResponseResponse
    {

        private string issuerField;

        private ArtifactResponseResponseStatus statusField;

        private Assertion assertionField;

        private string idField;

        private decimal versionField;

        private DateTime issueInstantField;

        private string inResponseToField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
        public string Issuer
        {
            get
            {
                return issuerField;
            }
            set
            {
                issuerField = value;
            }
        }

        /// <remarks/>
        public ArtifactResponseResponseStatus Status
        {
            get
            {
                return statusField;
            }
            set
            {
                statusField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
        public Assertion Assertion
        {
            get
            {
                return assertionField;
            }
            set
            {
                assertionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string ID
        {
            get
            {
                return idField;
            }
            set
            {
                idField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public decimal Version
        {
            get
            {
                return versionField;
            }
            set
            {
                versionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime IssueInstant
        {
            get
            {
                return issueInstantField;
            }
            set
            {
                issueInstantField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string InResponseTo
        {
            get
            {
                return inResponseToField;
            }
            set
            {
                inResponseToField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    public partial class ArtifactResponseResponseStatus
    {

        private ArtifactResponseResponseStatusStatusCode statusCodeField;

        /// <remarks/>
        public ArtifactResponseResponseStatusStatusCode StatusCode
        {
            get
            {
                return statusCodeField;
            }
            set
            {
                statusCodeField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:protocol")]
    public partial class ArtifactResponseResponseStatusStatusCode
    {

        private ArtifactResponseResponseStatusStatusCode statusCodeField;

        private string valueField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Value
        {
            get
            {
                return valueField;
            }
            set
            {
                valueField = value;
            }
        }

        /// <remarks/>
        public ArtifactResponseResponseStatusStatusCode StatusCode
        {
            get
            {
                return statusCodeField;
            }
            set
            {
                statusCodeField = value;
            }
        }

    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    [System.Xml.Serialization.XmlRoot(Namespace = "urn:oasis:names:tc:SAML:2.0:assertion", IsNullable = false)]
    public partial class Assertion
    {

        private string issuerField;

        private Signature signatureField;

        private AssertionSubject subjectField;

        private AssertionConditions conditionsField;

        private AssertionAuthnStatement authnStatementField;

        private string idField;

        private decimal versionField;

        private DateTime issueInstantField;

        /// <remarks/>
        public string Issuer
        {
            get
            {
                return issuerField;
            }
            set
            {
                issuerField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElement(Namespace = "http://www.w3.org/2000/09/xmldsig#")]
        public Signature Signature
        {
            get
            {
                return signatureField;
            }
            set
            {
                signatureField = value;
            }
        }

        /// <remarks/>
        public AssertionSubject Subject
        {
            get
            {
                return subjectField;
            }
            set
            {
                subjectField = value;
            }
        }

        /// <remarks/>
        public AssertionConditions Conditions
        {
            get
            {
                return conditionsField;
            }
            set
            {
                conditionsField = value;
            }
        }

        /// <remarks/>
        public AssertionAuthnStatement AuthnStatement
        {
            get
            {
                return authnStatementField;
            }
            set
            {
                authnStatementField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string ID
        {
            get
            {
                return idField;
            }
            set
            {
                idField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public decimal Version
        {
            get
            {
                return versionField;
            }
            set
            {
                versionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime IssueInstant
        {
            get
            {
                return issueInstantField;
            }
            set
            {
                issueInstantField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionSubject
    {

        private string nameIDField;

        private AssertionSubjectSubjectConfirmation subjectConfirmationField;

        /// <remarks/>
        public string NameID
        {
            get
            {
                return nameIDField;
            }
            set
            {
                nameIDField = value;
            }
        }

        /// <remarks/>
        public AssertionSubjectSubjectConfirmation SubjectConfirmation
        {
            get
            {
                return subjectConfirmationField;
            }
            set
            {
                subjectConfirmationField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionSubjectSubjectConfirmation
    {

        private AssertionSubjectSubjectConfirmationSubjectConfirmationData subjectConfirmationDataField;

        private string methodField;

        /// <remarks/>
        public AssertionSubjectSubjectConfirmationSubjectConfirmationData SubjectConfirmationData
        {
            get
            {
                return subjectConfirmationDataField;
            }
            set
            {
                subjectConfirmationDataField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Method
        {
            get
            {
                return methodField;
            }
            set
            {
                methodField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionSubjectSubjectConfirmationSubjectConfirmationData
    {

        private DateTime notOnOrAfterField;

        private string recipientField;

        private string inResponseToField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime NotOnOrAfter
        {
            get
            {
                return notOnOrAfterField;
            }
            set
            {
                notOnOrAfterField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Recipient
        {
            get
            {
                return recipientField;
            }
            set
            {
                recipientField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string InResponseTo
        {
            get
            {
                return inResponseToField;
            }
            set
            {
                inResponseToField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionConditions
    {

        private AssertionConditionsAudienceRestriction audienceRestrictionField;

        private DateTime notBeforeField;

        private DateTime notOnOrAfterField;

        /// <remarks/>
        public AssertionConditionsAudienceRestriction AudienceRestriction
        {
            get
            {
                return audienceRestrictionField;
            }
            set
            {
                audienceRestrictionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime NotBefore
        {
            get
            {
                return notBeforeField;
            }
            set
            {
                notBeforeField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime NotOnOrAfter
        {
            get
            {
                return notOnOrAfterField;
            }
            set
            {
                notOnOrAfterField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionConditionsAudienceRestriction
    {

        private string audienceField;

        /// <remarks/>
        public string Audience
        {
            get
            {
                return audienceField;
            }
            set
            {
                audienceField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionAuthnStatement
    {

        private AssertionAuthnStatementSubjectLocality subjectLocalityField;

        private AssertionAuthnStatementAuthnContext authnContextField;

        private DateTime authnInstantField;

        private string sessionIndexField;

        /// <remarks/>
        public AssertionAuthnStatementSubjectLocality SubjectLocality
        {
            get
            {
                return subjectLocalityField;
            }
            set
            {
                subjectLocalityField = value;
            }
        }

        /// <remarks/>
        public AssertionAuthnStatementAuthnContext AuthnContext
        {
            get
            {
                return authnContextField;
            }
            set
            {
                authnContextField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public DateTime AuthnInstant
        {
            get
            {
                return authnInstantField;
            }
            set
            {
                authnInstantField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string SessionIndex
        {
            get
            {
                return sessionIndexField;
            }
            set
            {
                sessionIndexField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionAuthnStatementSubjectLocality
    {

        private string addressField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttribute]
        public string Address
        {
            get
            {
                return addressField;
            }
            set
            {
                addressField = value;
            }
        }
    }

    /// <remarks/>
    [Serializable]
    [System.ComponentModel.DesignerCategory("code")]
    [System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:assertion")]
    public partial class AssertionAuthnStatementAuthnContext
    {

        private string authnContextClassRefField;

        /// <remarks/>
        public string AuthnContextClassRef
        {
            get
            {
                return authnContextClassRefField;
            }
            set
            {
                authnContextClassRefField = value;
            }
        }
    }
}
