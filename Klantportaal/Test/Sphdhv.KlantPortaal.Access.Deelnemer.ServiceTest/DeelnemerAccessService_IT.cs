using System.Text;
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using Sphdhv.KlantPortaal.Data.Deelnemer.DbContext;
using System.Linq;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.KlantPortaal.Access.Deelnemer.Service;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Common;
using Icatt.Security.Engine.Cryptographer.Interface;
using Moq;
using System.Collections.Generic;
using System.Collections.Specialized;
using Icatt.Digid.Access.Contract;
using Icatt.Security.Engine.Cryptographer.Service;
using Sphdhv.DeelnemerPortalApi.ProxyStub;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using Icatt.Azure.Access;

namespace Sphdhv.KlantPortaal.Access.Deelnemer.ServiceTest
{
    [TestClass]
    public class DeelnemerAccessService_IT
    {
        private const string KeyChainName = "keyChainName";
        private static readonly byte[] TestKey = Encoding.UTF8.GetBytes("012345678901234567890123012345678901234567890123");
        private const string TestCypher = "Aes256With16ByteIvPrefix";

        private static string LocalTestDbName { get { return typeof(DeelnemerAccessService_IT).FullName; } }


        [ClassInitialize]
        public static void ClassInitialize(TestContext context)
        {

            //Delete the database here to make sure it is recreated
            if (Database.Exists(LocalTestDbName))
            {
                Database.Delete(LocalTestDbName);
            }

            //Create a localdb
            using (var dbc = new DeelnemerDbContext(LocalTestDbName, DeelnemerDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {
                var dlnmr = dbc.Deelnemers.FirstOrDefault();
            }

        }




        [TestMethod]
        public void IT_DeelnemerAccessService_Insert_Get_And_UpdateEmailStatus()
        {
            var testEmail = "sdfgdfbdhdfg@dfgety.fgh";
            var testBsn = "123123123";
            var testGuid = Guid.NewGuid();

            var context = new KlantPortaalContext() { Bsn = testBsn };
            
            var proxyMocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(IKeyVault), (ctx) => {
                    var mock = new Mock<IKeyVault>();
                    mock.Setup(s => s.GetSecret(It.IsAny<string>()))
                    .Returns(
                        new byte[48]
                    );

                    return mock.Object;
                } }

            };

            var fc = new KlantPortaalFactoryContainer(proxyMocks, null);
            var service = new DeelnemerAccessService<KlantPortaalContext>(context, LocalTestDbName, fc);

            var newDeelnemer = new Contract.DeelnemerUpdate { Email = testEmail, Status = DeelnemerStatus.None, VerificationId = testGuid };


            //Act : create deelnemer         
            var deelnemerId = service.Update(newDeelnemer);
            //Assert
            Assert.IsNotNull(deelnemerId);
            Assert.AreNotEqual(0, deelnemerId);


            //Act: get deelnemer
            var savedDeelnemer = service.Deelnemer();
            //Assert
            Assert.AreEqual(testBsn, savedDeelnemer.Bsn);
            Assert.AreEqual(testEmail, savedDeelnemer.Email);
            Assert.AreEqual(DeelnemerStatus.None, savedDeelnemer.Status);


            //Act: update deelnemer            
            var updatedDeelnemerId = service.UpdateEmailStatus(DeelnemerStatus.EmailVerified);
            //Assert
            Assert.AreEqual(deelnemerId, updatedDeelnemerId);


            //Act: get deelnemer again to check updated state
            var verifiedDeelnemer = service.Deelnemer();
            //Assert
            Assert.AreEqual(testBsn, verifiedDeelnemer.Bsn);
            Assert.AreEqual(testEmail, verifiedDeelnemer.Email);
            Assert.AreEqual(DeelnemerStatus.EmailVerified, verifiedDeelnemer.Status);




        }




        [TestMethod]
        public void DeelnemerAccessService_Update_ThrowsOnError()
        {
            //FORCE ERROR BY PROVIDING EMPTY BSN
        }

        [TestMethod]
        public void DeelnemerAccessService_Delete_ThrowsOnError()
        {
            //FORCE ERROR BY PROVIDING EMPTY BSN
        }

    }

}
