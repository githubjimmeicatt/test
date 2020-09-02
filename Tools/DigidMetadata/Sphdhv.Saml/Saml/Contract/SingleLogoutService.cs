﻿using System;
using System.Xml.Serialization;

namespace Icatt.Security.Saml2.Saml.Contract
{
    [Serializable()]
    [XmlType(AnonymousType = true, Namespace = "urn:oasis:names:tc:SAML:2.0:metadata")]
    public class SingleLogoutService
    {
        [XmlAttribute()]
        public string Binding { get; set; }

        [XmlAttribute()]
        public string Location { get; set; }

        [XmlAttribute()]
        public string ResponseLocation { get; set; }
    }
}