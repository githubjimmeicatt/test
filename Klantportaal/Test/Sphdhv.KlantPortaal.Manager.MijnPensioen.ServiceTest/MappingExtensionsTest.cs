using AutoFixture;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.Mapping;
using System.Linq;
using AccessContract = Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using EngineContract = Sphdhv.KlantPortaal.Engine.Pensioen.Contract;
using ManagerContract = Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.ServiceTest
{
    [TestClass]
    public class MappingExtensionsTest
    {
        [TestMethod]
        public void DeelnemerProfiel()
        {
            var fixture = new Fixture();

            var input = fixture.Create<AccessContract.DeelnemerProfiel>();
            var output = input.Map<ManagerContract.DeelnemerProfiel>();

            Assert.AreEqual(input.IdentificatieVerzekerde, output.IdentificatieVerzekerde);
            Assert.AreEqual(input.Adressen.Count, output.Adressen.Count);

            var inputAdres1 = input.Adressen[0];
            var outputAdres1 = output.Adressen.Single(x => x.CrmId == inputAdres1.CrmId);

            Assert.AreEqual(inputAdres1.Land, outputAdres1.Land);
        }

        [TestMethod]
        public void ActueelPensioen()
        {
            var fixture = new Fixture();

            var input = fixture.Create<EngineContract.ActueelPensioen>();
            var output = input.Map<ManagerContract.ActueelPensioen>();

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
