using AutoFixture;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Manager.Authentication.Service.Mapping;
using System.Linq;
using EngineContract = Sphdhv.KlantPortaal.Engine.Claims.Contract;

namespace Sphdhv.KlantPortaal.Manager.Authentication.ServiceTest
{
    [TestClass]
    public class MappingExtensionsTest
    {
        [TestMethod]
        public void ExchangeTokenResponse()
        {
            var fixture = new Fixture();
            var input = fixture.Create<EngineContract.ExchangeTokenResponse>();
            var output = input.ToContract();

            Assert.AreEqual(input.Status.ToString(), output.Status.ToString());
            Assert.AreEqual(input.Claims.Length, output.Claims.Length);

            var inputClaim = input.Claims.First();
            var outputClaim = output.Claims.Single(x => x.Issuer == inputClaim.Issuer);
            Assert.AreEqual(inputClaim.Value, outputClaim.Value);
        }
    }
}
