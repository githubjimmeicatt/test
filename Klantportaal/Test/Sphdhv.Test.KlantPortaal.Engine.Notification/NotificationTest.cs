using Microsoft.VisualStudio.TestTools.UnitTesting;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Engine.Notification.Contract;
using System.Net.Mail;
using Icatt;
using Moq;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Sphdhv.Test.KlantPortaal.Engine.Notification
{
    [TestClass]
    public class NotificationTest
    {


        [TestMethod]
        public void UT_NotificationEngine_sends_email_with_link()
        {
            //Setup 
            var testLink = "testLink";
            var testTo = "jgrmnbdvndgtjhgfb.tyjodfyuiiu46sjghhj@mbvsdfnmgwurerh3h45.fghjhj";
            var verificationRequestData = new VerificationRequest() { To = testTo, VerificationLink = testLink };

            //var testContext = new TestContext();
            var testContext = new KlantPortaalContext();
            var testProxyFactory = new TestProxyFactory();
            var factoryContainer = new FactoryContainer<KlantPortaalContext>(testProxyFactory);
            
            //Act
            var NoficiationEngine = new Sphdhv.KlantPortaal.Engine.Notification.Service.NotificationEngineService<KlantPortaalContext>(testContext, factoryContainer);
            var serializedVerificationRequest = NoficiationEngine.SerializeToString(verificationRequestData); ;

            var appEnv = new ApplicationEnvironment();
            var eventType = new EventType() { SourceType = "IEmailManager", OperationName = "VerifyEmail" }; // todo aanpassen als deze manager daadwerkelijk gemaakt is
            var args = new Argument[] { new Argument() { Name = "aaaaaa", Type = "bbbbb", XmlSerialized = serializedVerificationRequest } };

            NoficiationEngine.RaiseNotificationEvent(appEnv, eventType, args);

            //Assert

            //smtpclient is mocked and places the mail in testProxyFactory.Message
            //the mail must contain the testLink and must be addrssed to testTo
            Assert.IsTrue(testProxyFactory.Message.Body.Contains(testLink));
            Assert.AreEqual(1, testProxyFactory.Message.To.Count);
            Assert.AreEqual(testTo, testProxyFactory.Message.To[0].ToString());
        }


        public class TestProxyFactory : ProxyFactoryBase<KlantPortaalContext>
        {
            public MailMessage Message { get; set; }
            
            public override IService CreateProxy<IService>(KlantPortaalContext context)
            {
                var type = typeof(IService);

                if (type == typeof(ISmtpClient))
                {
                    var mock = new Mock<ISmtpClient>();
                    mock.Setup(s => s.Send(It.IsAny<MailMessage>())).Callback((MailMessage m) => Message = m);
                    return mock.Object as IService;
                }

                return null;

            }
            
        }

    }
}
