using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Xml;

namespace Icatt.Security.Saml2Test
{
    [TestClass]
    public class SamlSignatureEngineTest
    {
        [TestMethod]
        public void SamlSignatureEngine_ValidateSamlResponse()
        {
            var xml = Test.Utilities.ResourceUtility.GetString("Icatt.Security.Saml2Test.TestData.DigiD_response_successful_login.xml", this.GetType());

            var doc = new XmlDocument();
            doc.LoadXml(xml);

            var root = doc.DocumentElement;

            var eng = new Saml2.Engine.Signing.SamlSignatureEngine();

            Assert.IsTrue(eng.ValidateSamlSignatures(root));



            xml = Test.Utilities.ResourceUtility.GetString("Icatt.Security.Saml2Test.TestData.DigiD_tampered_response_successful_login.xml", this.GetType());

            doc = new XmlDocument();
            doc.LoadXml(xml);

            root = doc.DocumentElement;

            eng = new Saml2.Engine.Signing.SamlSignatureEngine();

            Assert.IsFalse( eng.ValidateSamlSignatures(root));

        }
    }
}
