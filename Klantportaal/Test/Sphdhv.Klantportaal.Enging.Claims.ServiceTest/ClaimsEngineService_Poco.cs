using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.KlantPortaal.Engine.Claims.Service;
using Sphdhv.KlantPortaal.Common;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Engine.Claims.Interface;
using System.Collections.Generic;
using Icatt.Digid.Access.Interface;
using Moq;
using System.Threading.Tasks;
using Icatt.Digid.Access.Contract;
using Sphdhv.KlantPortaal.Access.Pensioen.Interface;
using Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using System.Linq;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
using Icatt.OAuth.Contract;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Sphdhv.KlantPortaal.Engine.Notification.Contract;

namespace Sphdhv.KlantPortaal.Enging.Claims.ServiceTest
{
    [TestClass]
    public class ClaimsEngineService_Poco
    {
        [TestMethod]
        public void ClaimsEngineService_ExchangeToken()
        {
            DummyContext context = new DummyContext();
            IFactoryContainer<DummyContext> containerFactory = new FactoryContainer<DummyContext>();

            var issuedAt = DateTime.Now;
            var issuer = "issuer know name";
            var id = "some kind of ID";
            var bsn = 98098098;
            var dossierNr = "123123";
            var auditTrailWriterCalls = 0; 

            Dictionary<Type, Func<DummyContext, object>> mocks = new Dictionary<Type, Func<DummyContext, object>>
            {
                {typeof(IDigidAccess),c => {
                    var mock = new Mock<IDigidAccess>();

                    mock
                    .Setup(s => s.VerifyTokenAsync(It.IsAny<string>()))
                    .Returns(Task.FromResult(new VerifyTokenResponse{
                        Bsn = bsn.ToString("000000000"),
                        Id = id,
                        InResponseTo = "testrequest",
                        IssuedAt = issuedAt,
                        Issuer = issuer
                    }));

                    return mock.Object;
                } },
                {typeof(IPensioenAccess),c => {
                     var mock = new Mock<IPensioenAccess>();
                    mock
                    .Setup(s => s.DeelnemerProfiel())
                    .Returns(Task.FromResult(new DeelnemerProfiel
                    {
                        Bsn = bsn,
                        Nummer = dossierNr

                    }));
                    return mock.Object;

                } },
                {typeof(IAuthTokenAccess),c => {
                     var mock = new Mock<IAuthTokenAccess>();
                    mock
                    .Setup(s => s.IssueToken(It.IsAny<Claim[]>(),It.IsAny<TimeSpan>()))
                    .Returns(new TokenEntry                   {
                        Claims = new []{new Claim
                            {
                                Value="asdfs",
                            },
                        },
                        Token = "adsfasdf",
                        Signature =new byte[]{0x23,0x23}
                        }
                    );

                    return mock.Object;

                } },

                {typeof(IAuditTrailWriter), c =>
                {
                    var mock = new Mock<IAuditTrailWriter>();
                    mock.Setup(s => s.WriteEntryEncrypted(It.IsAny< Icatt.Auditing.Manager.AuditTrailWriter.Contract.EventType>(), It.IsAny<object>() ) )
                        .Callback(() => auditTrailWriterCalls++);
                     return mock.Object;
                } }
            };
            containerFactory.ProxyFactory = new DummyProxyFactory<DummyContext>(mocks);

            IClaimsEngine serv = new ClaimsEngineService<DummyContext>(context, containerFactory);

            var tsk = serv.ExchangeTokenAsync("Sphdhv.KlantPortaal.Host.WebHost", "PROD", "dummytoken", "dummyRelayState");
            tsk.Wait(1000);

            var result = tsk.Result;
            var claims = result?.Claims;

            Assert.IsNotNull(result);

            var bsnClaim = claims?.SingleOrDefault(clm => clm.Type.EndsWith("bsn", StringComparison.OrdinalIgnoreCase));
            var dossierNrClaim = claims?.SingleOrDefault(clm => clm.Type.EndsWith("dossiernummer", StringComparison.OrdinalIgnoreCase));
             
            //var csrfClaim = 
            Assert.IsNotNull(bsnClaim);
            Assert.IsNotNull(dossierNrClaim);
  

            Assert.AreEqual(1, auditTrailWriterCalls);

        }


    }

    internal class DummyProxyFactory<TContext> : IProxyFactory<TContext> where TContext : class, IUserContext
    {
        Dictionary<Type, Func<TContext, object>> _mocks;

        public DummyProxyFactory(Dictionary<Type, Func<TContext, object>> mocks)
        {
            _mocks = mocks;
        }
        IFactoryContainer<TContext> IProxyFactory<TContext>.FactoryContainer { get; set; }

        IService IProxyFactory<TContext>.CreateProxy<IService>(TContext context)
        {
            var t = typeof(IService);
            if (_mocks.ContainsKey(t))
            {
                return _mocks[t](context) as IService;
            }

            throw new InvalidOperationException();
        }
    }

    internal class DummyContext : IUserContext
    {
        public string DossierNummer { get; set; }
        public string Bsn { get; set; }
        public string Ip { get; set; }
    }
}
