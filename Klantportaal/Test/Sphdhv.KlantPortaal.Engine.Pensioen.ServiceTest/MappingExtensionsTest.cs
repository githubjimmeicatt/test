using AutoFixture;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Engine.Pensioen.Service.Mapping;
using System.Linq;
using AccessContract = Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using EngineContract = Sphdhv.KlantPortaal.Engine.Pensioen.Contract;

namespace Sphdhv.KlantPortaal.Engine.Pensioen.ServiceTest
{
    [TestClass]
    public class MappingExtensionsTest
    {
        [TestMethod]
        public void ActueelPensioen()
        {
            var fixture = new Fixture();

            var input = fixture.Create<AccessContract.ActueelPensioen>();
            var output = input.Map<EngineContract.ActueelPensioen>();

            Assert.AreEqual(input.IsBlocked, output.IsBlocked);
            Assert.AreEqual(input.Polissen.Count, output.Polissen.Count);
            Assert.AreEqual(input.Pensioen.IngegaanAow, output.Pensioen.IngegaanAow);
            Assert.AreEqual(input.DeelnemerProfiel.Bsn, output.DeelnemerProfiel.Bsn);

            var inputAdres1 = input.Polissen[0];
            var outputAdres1 = output.Polissen.Single(x => x.StatusPolisNaam == inputAdres1.StatusPolisNaam);

            Assert.AreEqual(inputAdres1.Reglement, outputAdres1.Reglement);
        }
    }
}
