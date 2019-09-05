using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Icatt.ServiceModel;
using System.Collections.Generic;
using Icatt.Auditing.Access.AuditTrail.Interface;

using Moq;

using System.Text;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Proxy;
using Icatt.Auditing.Access.AuditTrail.Service;
using Icatt.Security.Engine.Cryptographer.Service;
using Icatt.Logging.DataAccess;
using Icatt.Logging.Entities;
using Icatt.Azure.Access;


namespace Icatt.Auditing.Access.AuditTrail.ServiceTest
{
    [TestClass]
    public class AuditTrailServiceTest
    {
        [TestMethod]
        public void UT_WriteEntry()
        {
            object data = new AuditData() { Msg = "sgdfgdgf" };
            Enum EventType = TestEventTypes.Login;

            var AuditEntryCalls = new List<string>();
            var logEntryCalls = new List<LogEntry>();

            var testKey = Encoding.UTF8.GetBytes("012345678901234567890123012345678901234567890123");

            var proxyMocks = new Dictionary<Type, Func<TestContext, object>>
            {
                { typeof(ILoggingRepository), (ctx) => {

                    var mock = new Mock<ILoggingRepository>();
                    mock.Setup(s => s.Add(It.IsAny<LogEntry>())).Callback((LogEntry r) => {
                        logEntryCalls.Add(r);
                    });

                    return mock.Object;
                } },
                { typeof(IKeyVault), (ctx) => {
                    var keyVaultMock = new Mock<IKeyVault>();
                    keyVaultMock.Setup(s => s.GetSecret(It.IsAny<string>()))
                        .Returns(testKey)
                        .Callback((string r) => {
                        AuditEntryCalls.Add(r);
                    });
                    return keyVaultMock.Object;
                }}

            };


            var testContext = new TestContext();
            var testFactoryContainer = new TestFactoryContainer(new TestProxyFactory<TestContext>(proxyMocks), new TestServiceFactory<TestContext>());



            var x = new AuditTrailAccessService<TestContext>(testContext, testFactoryContainer);


            //Act
            x.WriteEntry(EventType, data, true);


            //Assert
            Assert.AreEqual(1, logEntryCalls.Count);

            Assert.AreEqual(null, logEntryCalls[0].Details);
            Assert.AreEqual(EventType.ToString(), logEntryCalls[0].Message);

            //het versleutelde bericht
            Assert.AreEqual("TQUKcuweOADh+qE3tk4vLqTAsQFBZVEERAzt4xVmrnc=", Convert.ToBase64String(logEntryCalls[0].DetailsEncrypted));
        }





        public class TestContext : IAuditContext
        {
            public string ApplicationName
            {
                get { return "testappname"; }
                set
                {
                    throw new NotImplementedException();
                }
            }
            public Guid? LogRequestId
            {
                get { return Guid.NewGuid(); }
                set
                {
                    throw new NotImplementedException();
                }
            }
            public Guid? LogSessionId
            {
                get { return Guid.NewGuid(); }
                set
                {
                    throw new NotImplementedException();
                }
            }
        }



        public class TestFactoryContainer : FactoryContainer<TestContext>
        {
            public TestFactoryContainer(
                IProxyFactory<TestContext> proxyFactory = null,
                IServiceFactory<TestContext> serviceFactory = null)
            {
                ProxyFactory = proxyFactory ?? new TestProxyFactory<TestContext>(); ;
                ServiceFactory = serviceFactory ?? new TestServiceFactory<TestContext>();
            }

        }




        public class TestProxyFactory<TContext> : ProxyFactoryBase<TContext> where TContext : class
        {
            IDictionary<Type, Func<TestContext, object>> _mocks;


            public TestProxyFactory(IDictionary<Type, Func<TestContext, object>> mocks = null)
            {
                _mocks = mocks;
            }



            public override IService CreateProxy<IService>(TContext context)
            {
                Func<TestContext, object> m;
                var type = typeof(IService);

                if (_mocks != null && _mocks.TryGetValue(type, out m))
                {
                    return m(context as TestContext) as IService;
                }

                if (type == typeof(ICryptographer))
                {
                    var proxy = new CryptographerEngine<TContext>(context, FactoryContainer) as IService; ;
                    // var proxy = new CryptographerProxy<TContext>(context, FactoryContainer) as ProxyBase<IService, TestContext>;
                    return proxy as IService;
                }

                return default(IService);
            }
        }


        public class TestServiceFactory<TContext> : ServiceFactoryBase<TContext> where TContext : class, IAuditContext
        {

            IDictionary<Type, Func<TContext, object>> _mocks;

            public TestServiceFactory(IDictionary<Type, Func<TContext, object>> mocks = null)
            {
                _mocks = mocks;
            }

            public override IService CreateService<IService>(TContext context)
            {
                var type = typeof(IService);

                Func<TContext, object> m;
                if (_mocks != null && _mocks.TryGetValue(type, out m))
                {
                    return m(context) as IService;
                }


                if (type == typeof(IAuditTrailAccess))
                {
                    return new AuditTrailAccessService<TContext>(context, FactoryContainer) as IService;
                }
                return null;

            }
        }



        public class AuditData
        {
            public string Msg { get; set; }
        }

        public enum TestEventTypes
        {
            Login,
            Logoff

        }


    }
}
