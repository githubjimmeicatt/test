﻿using System;
using System.Diagnostics;
using System.Linq;
using Icatt.Digid.Access.Interface;
using Icatt.Digid.Access.Proxy;
using Icatt.ServiceModel;
using Icatt.Time;
using Sphdhv.DeelnemerPortalApi.Interface;
using Sphdhv.DeelnemerPortalApi.Proxy;
using Sphdhv.KlantPortaal.Access.Pensioen.Interface;
using Sphdhv.KlantPortaal.Engine.Pensioen.Interface;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;
using Sphdhv.KlantPortaal.Manager.Authentication.Proxy;
using Sphdhv.KlantPortaal.Engine.Claims.Interface;
using Sphdhv.KlantPortaal.Engine.Claims.Proxy;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using Sphdhv.KlantPortaal.Access.AuthToken.Proxy;
using Icatt;
using Icatt.Membership.Access.User.Proxy;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Proxy;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Proxy;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.KlantPortaal.Manager.Session.Proxy;
using Sphdhv.Security.Environment;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Proxy;
using System.Collections.Generic;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Proxy;
using Icatt.Infrastructure;
using Icatt.Web.Infrastructure;
using Sphdhv.KlantPortaal.Engine.Notification.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Proxy;
using Icatt.Auditing.Access.AuditTrail.Interface;
using Icatt.Auditing.Access.AuditTrail.Proxy;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;
using Sphdhv.KlantPortaal.Access.Correspondentie.Proxy;
using Icatt.Azure.Access;
using System.Security.Cryptography.X509Certificates;
using Sphdhv.KlantPortaal.Host.WebHost.Properties;
using Serilog;
using Icatt.Logging.DataAccess;

namespace Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal
{
    public class KlantPortaalProxyFactory : ProxyFactoryBase<KlantPortaalContext>
    {
        IDictionary<Type, Func<KlantPortaalContext, object>> _mocks; 


        public KlantPortaalProxyFactory(IDictionary<Type,Func<KlantPortaalContext,object>> mocks = null) 
        {
            _mocks = mocks;
        }

        public override IService CreateProxy<IService>(KlantPortaalContext context)
        {

            ProxyBase<IService, KlantPortaalContext> proxy = null;
            var type = typeof(IService);

            Func<KlantPortaalContext, object> m;
            if (_mocks != null && _mocks.TryGetValue(type, out m)) {
                return m(context) as IService;
            }

            #region Managers

                if (type == typeof(IMijnPensioenManager))
            {
                proxy = new MijnPensioenManagerProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.OnAuthenticate += (_, __) =>
                {
                    var authContainer = new AuthenticationFactoryContainer<KlantPortaalContext>();
                    var p = authContainer.ProxyFactory.CreateProxy<IAuthenticationManager>(context);
                    return p.AuthenticateUser();
                };
               
                proxy.NoAuthorization();

                //werkt niet :( wordt nooit aangeroepen.
                // var x = proxy as IMijnPensioenManager;
                //proxy.OnAuthorizeInvokeAsync<string, Task<Document>>(x.DownloadDocumentAsync, async ( c,  documentId) => {

                //    var p = this.FactoryContainer.ProxyFactory.CreateProxy<IMijnPensioenManager>(context);

                //    var docs =   await  p.DocumentenAsync() ;
                //    var userOwnsDoc = docs.Items.Any(d => d.Id == documentId);

                //    return userOwnsDoc;

                //    //return Task.FromResult(userOwnsDoc);

                //} 
                //);


                LogExceptions(proxy, false);
            }
            else if (type == typeof(Manager.Authentication.Interface.IAuthenticationManager))
            {
                proxy = new AuthorizationManagerProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);

            }
            else if (type == typeof(IAspNetIdentityManager))
            {
                proxy = new AspNetIdentityManagerProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(ISessionManager))
            {
                proxy = new SessionManagerProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
           
            else if (type == typeof(IAuditTrailWriter))
            {
                proxy = new  AuditTrailWriterProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }

            #endregion

            #region Engines

            else if (type == typeof(IPensioenEngine))
            {
                proxy = new Engine.Pensioen.Proxy.PensioenEngineProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(IClaimsEngine))
            {
                proxy = new ClaimsEngineProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(ICryptographer))
            {
                proxy = new CryptographerProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(INotification))
            {
                proxy = new Engine.Notification.Proxy.NotificationEngineProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }


            #endregion

            #region Access

            else if (type == typeof(IPensioenAccess))
            {
                proxy = new Access.Pensioen.Proxy.PensioenAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                Debug.Assert(proxy != null);

                proxy.OnAuthenticate += (_, __) => true;
                proxy.OnAuthorize += (_, __) => true;
                LogExceptions(proxy, false);
            }
            else if (type == typeof(IDigidAccess))
            {
                proxy = new DigidAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(IAuthTokenAccess))
            {
                proxy = new AuthTokenAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(Icatt.Membership.Access.User.Contract.IUserAccess))
            {
                proxy = new UserAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(ISessionMarkerAccess))
            {
                proxy = new TerminatedSessionAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(IAuditTrailAccess))
            {
                proxy = new AuditTrailAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }
            else if (type == typeof(ICorrespondentieAccess))
            {
                proxy = new CorrespondentieAccessProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                proxy.NoAuth();
                LogExceptions(proxy, false);
            }


            

            #endregion

            #region Services

            else if (type == typeof(IDeelnemerPortalApi))
            {
                if (Settings.Default.StubDhvDeelnemerWebApi)
                {
                    //Stub deelnemer portal Api (As a Singleton -- read only access)
                    var stub = EnsureStub();
                    return stub as IService;
                    //Einde stub
                }
                else if (Settings.Default.StubDhvDocumentWebApi)
                {
                    //Stub deelnemer portal Api (As a Singleton -- read only access)
                    var stub = EnsureDocumentStub(context);
                    return stub as IService;
                    //Einde stub
                }

                proxy = new DeelnemerPortalApiProxy<KlantPortaalContext>(context, FactoryContainer) as ProxyBase<IService, KlantPortaalContext>;
                LogExceptions(proxy, true);

                if (Settings.Default.LogDeelnemerPortalApiCommunication)
                {
                    LogResponse(proxy);
                }

                proxy.NoAuth();
            }
            else if (type == typeof(ITimeMachine))
            {
                return new RealTime() as IService;
            }

            else if (type == typeof(IRandomizer))
            {
                return new ThreadSafeRandomizer() as IService;
            }
            else if (type == typeof(ITimeMachine))
            {
                return new RealTime() as IService;
            }
            else if (type == typeof(ISmtpClient))
            {
                return new SmtpClientWrapper() as IService;
            }


            if (type == typeof(IContextFactory))
            {
                return new HttpContextFactory() as IService;
            }

            if (type == typeof(ILoggingRepository))
            {
                var x = new LoggingRepositoryFactory("AuditDatabase");
                var loggingRepo = x.Create();
                return loggingRepo as IService;
            }          
            #endregion


            if (proxy == null)
                throw new InvalidOperationException($"Proxy requested for unknown interface type '{type.FullName}'");

            BindDefaultHandlers(proxy);

            return proxy as IService;

        }




        private X509Certificate2 FindCertificateByThumbprint(string findValue, StoreName storeName, StoreLocation storeLocation, bool validOnly = false)
        {
            X509Store store = new X509Store(storeName, storeLocation);
            try
            {
                store.Open(OpenFlags.ReadOnly);
                //tfs projects > ICATT packages / icatt.Certificate.Access
                //todo laatste param moet gezet kunne worden. storename 
                //en store location ook als params meegeven (overload).
                X509Certificate2Collection col = store.Certificates.Find(X509FindType.FindByThumbprint, findValue, validOnly); // Don't validate certs, since the test root isn't installed.
                if (col == null || col.Count == 0)
                    return null;
                return col[0];
            }
            finally
            {
                store.Close();
            }
        }




        private static volatile DeelnemerPortalApiStub<KlantPortaalContext> _stub;
        private static readonly object StubLock = new object();


 


        private static DeelnemerPortalApiStub<KlantPortaalContext> EnsureStub()
        {
            if (_stub != null) return _stub;

            lock (StubLock)
            {
                if (_stub != null) return _stub;

                //0000307943
                //0000307944
                //0000307949
                //0000307950
                //0000307957
                //0000307952
                //0000307959
                //0000307954
                //0000307974
                //0000308054
                //0000308218
                //0000308204
                //0000308219
                //0000308220
                //0000308221
                //0000308222
                var dossierNr = new[] { "0000307943", "0000307944", "0000307949" };
                var bsnNr = new[] { 676767676, 34563456, 34563456 };


                var localStub = new DeelnemerPortalApiStub<KlantPortaalContext>();


                localStub.StubManager.DataCollection.AddRandomPensioen(3);
                localStub.StubManager.DataCollection.AddRandomVerzekerden(3);
                localStub.StubManager.DataCollection.AddRandomPolissen(3);
                localStub.StubManager.DataCollection.AddRandomPensioenRechten(3);


                localStub.StubManager.DataCollection.Pensioenrechten.Add(dossierNr[1],
                    localStub.StubManager.DataCollection.Pensioenrechten.Values.Skip(1).First());
                localStub.StubManager.DataCollection.Pensioenrechten.Remove(localStub.StubManager.DataCollection.Pensioenrechten.Keys.Skip(1)
                    .First());
                localStub.StubManager.DataCollection.Pensioenen.Add(dossierNr[1],
                    localStub.StubManager.DataCollection.Pensioenen.Values.Skip(1).First());
                localStub.StubManager.DataCollection.Pensioenen.Remove(localStub.StubManager.DataCollection.Pensioenen.Keys.Skip(1).First());
                localStub.StubManager.DataCollection.Polissen[1].DossierId = dossierNr[1];
                localStub.StubManager.DataCollection.Verzekerden[1].Bsn = bsnNr[1];
                localStub.StubManager.DataCollection.Verzekerden[1].Id = dossierNr[1];
                localStub.StubManager.DataCollection.Verzekerden[1].Nummer = dossierNr[1];

                localStub.StubManager.DataCollection.Pensioenrechten.Add(dossierNr[2],
                    localStub.StubManager.DataCollection.Pensioenrechten.Values.Skip(2).First());
                localStub.StubManager.DataCollection.Pensioenrechten.Remove(localStub.StubManager.DataCollection.Pensioenrechten.Keys.Skip(2)
                    .First());
                localStub.StubManager.DataCollection.Pensioenen.Add(dossierNr[2],
                    localStub.StubManager.DataCollection.Pensioenen.Values.Skip(2).First());
                localStub.StubManager.DataCollection.Pensioenen.Remove(localStub.StubManager.DataCollection.Pensioenen.Keys.Skip(2).First());
                localStub.StubManager.DataCollection.Polissen[2].DossierId = dossierNr[2];
                localStub.StubManager.DataCollection.Verzekerden[2].Bsn = bsnNr[2];
                localStub.StubManager.DataCollection.Verzekerden[2].Id = dossierNr[2];
                localStub.StubManager.DataCollection.Verzekerden[2].Nummer = dossierNr[2];

                localStub.StubManager.DataCollection.Pensioenrechten.Add(dossierNr[0],
                    localStub.StubManager.DataCollection.Pensioenrechten.Values.First());
                localStub.StubManager.DataCollection.Pensioenrechten.Remove(localStub.StubManager.DataCollection.Pensioenrechten.Keys
                    .First());
                localStub.StubManager.DataCollection.Pensioenen.Add(dossierNr[0],
                    localStub.StubManager.DataCollection.Pensioenen.Values.First());
                localStub.StubManager.DataCollection.Pensioenen.Remove(localStub.StubManager.DataCollection.Pensioenen.Keys.First());
                localStub.StubManager.DataCollection.Polissen[0].DossierId = dossierNr[0];
                localStub.StubManager.DataCollection.Verzekerden[0].Bsn = bsnNr[0];
                localStub.StubManager.DataCollection.Verzekerden[0].Id = dossierNr[0];
                localStub.StubManager.DataCollection.Verzekerden[0].Nummer = dossierNr[0];

                _stub = localStub;

            }

            return _stub;


        }

        private static DeelnemerPortalApiStub<KlantPortaalContext> EnsureDocumentStub(KlantPortaalContext context)
        {
            if (_stub != null) return _stub;

            lock (StubLock)
            {
                if (_stub != null) return _stub;

                var dossierNr = "0000307943";//context.DossierNummer;

                var localStub = new DeelnemerPortalApiStub<KlantPortaalContext>();

                localStub.StubManager.DataCollection.AddDocument(dossierNr);
                localStub.StubManager.DataCollection.AddDocumentInfo(dossierNr);

                _stub = localStub;

            }

            return _stub;


        }

        private void BindDefaultHandlers<IService>(ProxyBase<IService, KlantPortaalContext> proxy) where IService : class
        {
            proxy.OnPreInvoke += Proxy_OnPreInvoke;
            //todo authenticate calls to managers

            //todo authorize calls to managers by checking the 

            //todo preinvoke logging at information level - only context and input

            //todo error logging at error level

            //todo postinvoke logging at information level - only context and result

        }

        private void Proxy_OnPreInvoke<IService>(object sender, ProxyBase<IService, KlantPortaalContext>.PreInvokeArgs e) where IService : class
        {
            e.Context.CallChain += sender.GetType().Name + ";";
        }



        public void LogExceptions<IService>(ProxyBase<IService, KlantPortaalContext> proxy, bool includeData, LogMessage message = LogMessage.Any)
         where IService : class
        {
            var area = ResolveArea<IService>();

            if (includeData)
            {
                proxy.OnError += (s, e) => { LogExceptionWithDataOnError(s, e, area, message); };

            }
            else
            {
                proxy.OnError += (s, e) => { LogExceptionOnError(s, e, area); };
            }
        }


        public void LogResponse<IService>(ProxyBase<IService, KlantPortaalContext> proxy, LogMessage message = LogMessage.Any)
 where IService : class
        {
            var area = ResolveArea<IService>();

        
                proxy.OnPostInvoke += (s, e) => { LogInfo(s, e, area, message); };

            
        }

        private ApplicationArea ResolveArea<IService>() where IService : class
        {
            var type = typeof(IService);

            #region managers
            if (type == typeof(IAuthenticationManager)) return ApplicationArea.AuthenticationManager;
            if (type == typeof(IMijnPensioenManager)) return ApplicationArea.IdentityManager;
            if (type == typeof(IMijnPensioenManager)) return ApplicationArea.PensioenManager;
            if (type == typeof(IMijnPensioenManager)) return ApplicationArea.SecureTokenManager;

            //etcetera

            #endregion

            #region access
            if (type == typeof(IMijnPensioenManager)) return ApplicationArea.AuthTokenAccess;

            //etcetra
            #endregion

            return ApplicationArea.Any;
        }

        private void LogExceptionWithDataOnError<IService>(object sender, ProxyBase<IService, KlantPortaalContext>.ErrorEventArgs e, ApplicationArea area, LogMessage message) where IService : class
        {
            Log.Error("Error in ApplicationArea {@ApplicationArea}", area, e.Input);
        }

        private void LogInfo<IService>(object sender, ProxyBase<IService, KlantPortaalContext>.PostInvokeArgs e, ApplicationArea area, LogMessage message) where IService : class
        {
            Log.Information(area.ToString(), e.Input);
        }

        private void LogExceptionOnError<IService>(object sender, ProxyBase<IService, KlantPortaalContext>.ErrorEventArgs e, ApplicationArea area) where IService : class
        {
            Log.Error(e.Exception, "Error in ApplicationArea {@ApplicationArea}", area);
        }

    }

    public static class ProxyExtensions
    {
        public static void NoAuth<TService, TContract>(this ProxyBase<TService, TContract> proxy) where TService : class where TContract : class
        {
            Debug.Assert(proxy != null);
            proxy.OnAuthenticate += (_, __) => true;
            proxy.OnAuthorize += (_, __) => true;
        }

        public static void NoAuthorization<TService, TContract>(this ProxyBase<TService, TContract> proxy) where TService : class where TContract : class
        {
            Debug.Assert(proxy != null);
            proxy.OnAuthorize += (_, __) => true;
        }





    }
}