using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Service;
using Sphdhv.KlantPortaal.Data.TerminatedSession.DbContext;

namespace Sphdhv.Test.KlantPortaal.Access.TerminatedSession
{
    [TestClass]
    public class TerminatedSessionAccessServiceTest
    {
        private readonly string _connectionString;

        public TerminatedSessionAccessServiceTest()
        {
            _connectionString = GetType().FullName ; 
        }

        
        
        [TestMethod]
        public void IT_AccessService_SetMarker()
        {
            var context = new TestContext("testmarker");
            var service = new TerminatedSessionAccess<TestContext>(_connectionString, TerminatedSessionDbContext.DatabaseInitializationMode.CreateIfNotExists, context);

            //new marker
            service.SetMarker();
            Assert.IsTrue(service.HasMarker());

            //existing marker
            service.SetMarker();
            Assert.IsTrue(service.HasMarker());
        }

        [TestMethod]
        public void IT_AccessService_ClearMarker_and_HasMarker()
        {
            var context = new TestContext("testmarker");
            var service = new TerminatedSessionAccess<TestContext>(_connectionString, TerminatedSessionDbContext.DatabaseInitializationMode.CreateIfNotExists, context);

            //new marker
            service.ClearMarker();
            Assert.IsFalse(service.HasMarker());

            //existing marker
            service.SetMarker();
            Assert.IsTrue(service.HasMarker());
            service.ClearMarker();
            Assert.IsFalse(service.HasMarker());
        }
    }

    public class TestContext : ISessionMarkerContext
    {
        public TestContext(string marker)
        {
            Marker = marker;
        }

        public string Marker { get; set; }
    }
}
