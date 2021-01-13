using System;
using System.Collections.Specialized;
using System.IO;
using System.Runtime.Serialization;
using System.Security.Principal;
using System.Web;
using System.Xml;
using Icatt.Security;
using Icatt.ServiceModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Engine.Notification.Contract;
using Sphdhv.KlantPortaal.Engine.Notification.Interface;

namespace Sphdhv.Test.KlantPortaal.Manager
{
    [TestClass]
    public class DeelnemerManagerTest
    {

        private static string emailVerificatieEndpoint = "/Deelnemer/VerifyEmail?";

        [TestMethod]
        public void UT_VraagAanvulling_returns_true_if_deelnemer_not_found()
        {
            //Setup
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = null
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VraagAanvulling();

            //Assert
            Assert.IsTrue(result);

        }

        [TestMethod]
        public void UT_VraagAanvulling_returns_true_if_deelnemer_has_status_none()
        {
            //Setup
            var testDeelnemer = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer() {
                Status = Sphdhv.KlantPortaal.Access.Deelnemer.Contract.DeelnemerStatus.None
            };
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = testDeelnemer
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory );
            
            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VraagAanvulling();

            //Assert
            Assert.IsTrue(result);

        }


        [TestMethod]
        public void UT_VraagAanvulling_returns_false_if_deelnemer_has_email()
        {
            //Setup
            var testDeelnemer = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer() {
                Email = "someemail@icatt.nl"
            };
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = testDeelnemer
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VraagAanvulling();

            //Assert
            Assert.IsFalse(result);

        }
        
        [TestMethod]
        public void UT_VraagAanvulling_returns_false_if_deelnemer_has_status_EmailOptOut()
        {
            //Setup
            var testDeelnemer = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer() {
                Status = Sphdhv.KlantPortaal.Access.Deelnemer.Contract.DeelnemerStatus.EmailOptOut
            };
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = testDeelnemer
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VraagAanvulling();

            //Assert
            Assert.IsFalse(result);

        }

        [TestMethod]
        public void UT_OpslaanAanvulling_deelnemer_met_email_and_status_None_raise_notification_event_en_de_email_wordt_geverifieerd_en_status_wordt_geupdate()
        {
            //Setup
            var verificationId = Guid.NewGuid();
            var uri = new Uri("http://some.dummy.url/");
            var testDeelnemer = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer()
            {
                Id = 1,
                Bsn = "1234567899",
                Email = "test@test.nl",
                Status = DeelnemerStatus.None,
                VerificationId = verificationId
            };
     
            var deelnemerUpdate = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.DeelnemerUpdate
            {
                Email = testDeelnemer.Email
            };

            var testProxyFactory = new TestProxyFactory()
            {
                DeelNemer = testDeelnemer
            };

            //Setup

            IIdentity identity = new GenericIdentity("dummyidentity");

            var context = new KlantPortaalContext(identity,null, uri);

            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);
            
            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            manager.OpslaanAanvulling(deelnemerUpdate.Email);
            
            Assert.AreEqual(deelnemerUpdate.Email, testProxyFactory.DeelnemerUpdate.Email);
            
            var verificationRequest = testProxyFactory.VerificationRequest as VerificationRequest;
            var arguments = testProxyFactory.NotificationArguments;

            //var notificatieRequestData = GetRequestData<VerificationRequest>(arguments);
            Assert.AreEqual(arguments[0].Name, "VerificatieRequest");

            Assert.AreEqual(testDeelnemer.Email, verificationRequest?.To);

            var result = manager.VerifyEmail(verificationId);
            Assert.IsTrue(result);
            
            Assert.AreEqual(DeelnemerStatus.EmailVerified, testDeelnemer.Status);

        }

        [TestMethod]
        public void UT_OpslaanAanvulling_deelnemer_met_kies_emailOptOut_deelnemer_toegevoegd_in_db_met_status_EmailOptOut()
        {
            //Setup
            var testProxyFactory = new TestProxyFactory();
            var context = new KlantPortaalContext();

            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            manager.OpslaanAanvulling("  ");

            var updatedDeelnemer = testProxyFactory.DeelnemerUpdate;
            Assert.AreEqual(DeelnemerStatus.EmailOptOut, updatedDeelnemer.Status);
        }

        [TestMethod]
        public void UT_VerifyEmail_returns_false_if_deelnemer_not_found()
        {
            //Setup
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = null
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VerifyEmail(Guid.NewGuid());

            //Assert
            Assert.IsFalse(result);

        }

        [TestMethod]
        public void UT_VerifyEmail_returns_false_if_verificationid_does_not_match()
        {
            //Setup
            var testDeelnemer = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer()
            {
                Status = Sphdhv.KlantPortaal.Access.Deelnemer.Contract.DeelnemerStatus.EmailOptOut,
                VerificationId = Guid.NewGuid()
            };
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = testDeelnemer
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VerifyEmail(Guid.NewGuid());

            //Assert
            Assert.IsFalse(result);

        }

        [TestMethod]
        public void UT_VerifyEmail_returns_true_if_verificationid_does_match()
        {
            //Setup
            var verificationId = Guid.NewGuid();
            var testDeelnemer = new Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer()
            {
                Status = Sphdhv.KlantPortaal.Access.Deelnemer.Contract.DeelnemerStatus.EmailOptOut,
                VerificationId = verificationId
            };
            var testProxyFactory = new TestProxyFactory
            {
                DeelNemer = testDeelnemer
            };

            var context = new KlantPortaalContext();
            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>(testProxyFactory);

            //Act
            var manager = new Sphdhv.Klantportaal.Manager.Deelnemer.Service.DeelnemerManager<KlantPortaalContext>(context, containerFactory, emailVerificatieEndpoint);
            var result = manager.VerifyEmail(verificationId);

            //Assert
            Assert.IsTrue(result);

        }

        [TestMethod]
        public void TestHash()
        {
            var secret = "the secret";
            var theId = "theId";

            //get signature
            var signatory = SigningUtility.CreateSignatoryWithSecret(secret, theId);

            var url = new Uri(new Uri("http://some.dummy.url/"), signatory.BuildQuerystring());

            var str = signatory.BuildQuerystring();


            var collection = HttpUtility.ParseQueryString(str);

            var validator = SigningUtility.CreateValidator(collection, secret: secret);


            var isval = validator.ValidateSignature();
            Assert.IsTrue(isval);
        }


        private static bool IsValidateHash(NameValueCollection values, string secret)
        {
            var validator = SigningUtility.CreateValidator(values, secret: secret);
            return validator.ValidateSignature();
        }

        private static string CreateHash(object[] values, string secret)
        {
            //get signature
            var signatory = SigningUtility.CreateSignatoryWithSecret(secret, values);
            return signatory.BuildQuerystring();
        }
        public class TestProxyFactory : ProxyFactoryBase<KlantPortaalContext>
        {
            public Sphdhv.KlantPortaal.Access.Deelnemer.Contract.Deelnemer DeelNemer { get; set; }
            public Sphdhv.KlantPortaal.Access.Deelnemer.Contract.DeelnemerUpdate DeelnemerUpdate { get; set; }
            public Sphdhv.KlantPortaal.Engine.Notification.Contract.Argument[] NotificationArguments { get; set; }
            public object VerificationRequest { get; set; }

            public override IService CreateProxy<IService>(KlantPortaalContext context)
            {
                var type = typeof(IService);

                if (type == typeof(IDeelnemerAccess))
                {
                    var mock = new Mock<IDeelnemerAccess>();
                    mock.Setup(s => s.Deelnemer()).Returns(DeelNemer);
                    mock.Setup(r => r.Update(It.IsAny<DeelnemerUpdate>()))
                        .Returns(1)
                        .Callback((DeelnemerUpdate c) => { DeelnemerUpdate = c; });
                    mock.Setup(r => r.UpdateEmailStatus(It.IsAny<DeelnemerStatus>()))
                        .Returns(1)
                        .Callback((DeelnemerStatus s) => {
                            DeelNemer.Status = s;
                        });

                    return mock.Object as IService;
                }

                if (type == typeof(INotification))
                {
                    var mock = new Mock<INotification>();
                    mock.Setup(i => i.SerializeToString(It.IsAny<object>()))
                        .Callback((object r) =>
                    {
                        VerificationRequest = r;
                    });
                    mock.Setup(
                        s =>
                            s.RaiseNotificationEvent(It.IsAny<ApplicationEnvironment>(), It.IsAny<EventType>(),
                                It.IsAny<Argument[]>())).Callback(
                                    (ApplicationEnvironment a, EventType e, Argument[] arg) =>
                                    {
                                        NotificationArguments = arg;
                                    });

                    return mock.Object as IService;
                }
                return null;

            }

        }

        private static TType GetRequestData<TType>(Argument[] arguments) where TType : VerificationRequest
        {
            using (StringReader reader = new StringReader(arguments[0].XmlSerialized))
            {
                using (XmlReader xmlReader = XmlReader.Create(reader))
                {
                    var serializer = new DataContractSerializer(typeof(TType));
                    return (TType)serializer.ReadObject(xmlReader);

                }
            }
        }
    }

}
