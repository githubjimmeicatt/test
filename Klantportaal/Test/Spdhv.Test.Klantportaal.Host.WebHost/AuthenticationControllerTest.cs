using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Spdhv.Test.Klantportaal.Host.WebHost
{
    [TestClass]
    public class AuthenticationControllerTest
    {
        [TestMethod]
        public void Create_a_valid_DigidSamlRequestMessage()
        {
            Assert.Inconclusive("Alleen voor on the fly genereren certificaat. Nodig om het saml bericht te kunnen testen");
            //Setup
            //var destination = "https://preprod1.digid.nl/saml/idp/request_authentication";
            //var controller = new Sphdhv.KlantPortaal.Host.WebHost.Controllers.AuthenticationController();

            ////Act
            //var message = controller.CreateDigidSamlRequestMessage(destination);

            ////Assert
            //Assert.AreEqual("", message);

        }

    }
}
