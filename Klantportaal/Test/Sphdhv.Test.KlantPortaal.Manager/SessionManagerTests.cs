using System;
using System.Collections.Generic;
using System.Data.Entity;
using Icatt.ServiceModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.KlantPortaal.Manager.Session.Service;
using Sphdhv.Test.KlantPortaal.Host;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Service;
using Sphdhv.KlantPortaal.Data.TerminatedSession.DbContext;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Contract;

namespace Sphdhv.Test.KlantPortaal.Manager
{
    [TestClass]
    public class SessionManagerTests
    {
        private static readonly string _connectionString;

        static  SessionManagerTests()
        {
            _connectionString = typeof(SessionManagerTests).FullName;
        }


        [ClassInitialize]
        public static void ClassInit(TestContext testContext)
        {
            if (_connectionString != typeof(SessionManagerTests).FullName)
            {
                //alleen de locale test db mag gedelete worden
                return;
            }

            if (Database.Exists(_connectionString))
                Database.Delete(_connectionString);
        }

        [TestMethod]
        public void UT_SessionManager()
        {
            var context = new KlantPortaalContext() { Bsn = "123", Ip = "123" };
            (context as ISessionMarkerContext).Marker = "testMarker";

            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>();
            int clearCalls=0;
            int setCall = 0;
            int hasMarkerCall = 0;
            var hasmarkerValue = false;
            int auditTrailWriterCalls = 0;
            var mocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                {typeof(ISessionMarkerAccess), c =>
                {
                    var mock = new Mock<ISessionMarkerAccess>();
                    mock.Setup(s => s.ClearMarker())
                        .Callback(() => clearCalls++);
                    mock.Setup(s => s.SetMarker())
                        .Callback(() => setCall++);
                    mock.Setup(s => s.HasMarker())
                        .Callback(() =>
                        {
                            hasmarkerValue = !hasmarkerValue;
                            hasMarkerCall++;
                        })
                        .Returns(hasmarkerValue);
                     return mock.Object;
                } },

                
                  {typeof(IAuditTrailWriter), c =>
                {
                    var mock = new Mock<IAuditTrailWriter>();
                    mock.Setup(s => s.WriteEntryEncrypted(It.IsAny<EventType>(), It.IsAny<object>() ) )
                        .Callback(() => auditTrailWriterCalls++);                
                     return mock.Object;
                } }

            };

            containerFactory.ProxyFactory = new DummyProxyFactory<KlantPortaalContext>(mocks);
            var manager = new SessionManager<KlantPortaalContext>(context, containerFactory);

            manager.StartSession();
            Assert.AreEqual(1,clearCalls);

            Assert.AreEqual(!hasmarkerValue, manager.IsActiveSession());
            Assert.AreEqual(1, hasMarkerCall);

            manager.EndSession();
            Assert.AreEqual(1, setCall);
            Assert.IsFalse(manager.IsActiveSession());
            Assert.AreEqual(2, hasMarkerCall);
            Assert.AreEqual(1, auditTrailWriterCalls);
        }

        [TestMethod]
        public void IT_SessionManager()
        {
            var context = new KlantPortaalContext();
            (context as ISessionMarkerContext).Marker = "testMarker";

            var alternativeServiceFactory = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                { typeof(ISessionMarkerAccess), (ctx) => {

                    var service = new TerminatedSessionAccess<KlantPortaalContext>(_connectionString, TerminatedSessionDbContext.DatabaseInitializationMode.CreateIfNotExists, context);
                    return service;
                } }

            };

            var factoryContainer = new KlantPortaalFactoryContainer(null, alternativeServiceFactory);
            var manager = new SessionManager<KlantPortaalContext>(context, factoryContainer);

            manager.StartSession();
            Assert.IsTrue(manager.IsActiveSession());

            manager.EndSession();
            Assert.IsFalse(manager.IsActiveSession());
        }
    }

    public class DummyContext : IUserContext, IApplicationEnvironmentContext, ISessionMarkerContext
    {
        public string SessionId { get; set; }
        public string Marker { get; set; }
        public string DossierNummer { get; set; }
        public string Bsn { get; set; }
        public string ApplicationId { get; }
        public string EnvironmentId { get; }
        public string Ip { get; set; }
    }

    internal class DummyProxyFactory<TContext> : ProxyFactoryBase<TContext> where TContext : class, IUserContext, ISessionMarkerContext
    {
        Dictionary<Type, Func<TContext, object>> _mocks;

        public DummyProxyFactory(Dictionary<Type, Func<TContext, object>> mocks)
        {
            _mocks = mocks;
        }
       // IFactoryContainer<TContext> IProxyFactory<TContext>.FactoryContainer { get; set; }

        public override IService CreateProxy<IService>(TContext context)
        {
            //var t = typeof(ISessionMarkerAccess);
            //if (_mocks.ContainsKey(t))
            //{
            //    return _mocks[t](context) as IService;
            //}

            Func<TContext, object> m;
            var type = typeof(IService);

            if (_mocks != null && _mocks.TryGetValue(type, out m))
            {
                return m(context as TContext) as IService;
            }



            throw new InvalidOperationException();
        }
    }
}
