using System;
using System.Diagnostics;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Host.WebHost;
using System.Runtime.Serialization;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Spdhv.Test.Klantportaal.Host.WebHost
{
    [TestClass]
    public class DigidSettingsTest
    {
        [TestMethod]
        public void SerializeDigidSettings()
        {

            var settings = new KlantportaalDigidSettings
            {
                RequestAuthenticationEndpoint = "authentpoint",
                CertificateIssuer = "certissuer",
                CertificateSubjectDistinguishedName = "certsubject",
                ResolveArtifactEndpoint = "artifactendpoint",
                AssertionConsumerServiceEndPointIndex = (KlantportaalDigidAssertionEndpoint)((byte) 5)
            };

            Assert.AreEqual(KlantportaalDigidAssertionEndpoint.AaDhvKlantportaalAccept, settings.AssertionConsumerServiceEndPointIndex);

            settings.AssertionConsumerServiceEndPointIndex = (KlantportaalDigidAssertionEndpoint) Properties.Settings.Default.EntpointIndexTestValue;

            Assert.AreEqual(KlantportaalDigidAssertionEndpoint.DhvKlantportaalAccept, settings.AssertionConsumerServiceEndPointIndex);


            var ser = new DataContractSerializer(typeof(KlantportaalDigidSettings));

            using (var txtWriter = new StringWriter())
            {
                using (var xmlWriter = new System.Xml.XmlTextWriter(txtWriter))
                {
                    ser.WriteObject(xmlWriter,settings);

                    var xml = txtWriter.ToString();
                    Trace.Write(xml);
                }
            }
        }
    }
}
