using System;
using System.Collections.Generic;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Sphdhv.DeelnemerPortalApi.Contract;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.Test.KlantPortaal.Host;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;
using System.Data.Entity;
using Sphdhv.KlantPortaal.Data.Pensioen.DbContext;
using System.Linq;

namespace Sphdhv.Test.KlantPortaal.Access.Pensioen
{
    [TestClass]
    public class PensioenAccessServiceTest_IT
    {


        private static string LocalTestDbName { get { return typeof(PensioenAccessServiceTest_IT).FullName; } }


        [ClassInitialize]
        public static void ClassInitialize(TestContext context)
        {

            //Delete the database here to make sure it is recreated
            if (Database.Exists(LocalTestDbName))
            {
                Database.Delete(LocalTestDbName);
            }

            //Create a localdb
            using (var dbc = new PensioenDbContext(LocalTestDbName, PensioenDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {
                var dossier = dbc.Dossiers.FirstOrDefault();
                dbc.Dossiers.Add(new Klantportaal.Data.Pensioen.Entities.Dossier {
                    Blocked = true,
                    Nummer = "1234567",
                    CreatedAtUtc = DateTime.UtcNow,
                    ModifiedAtUtc = DateTime.UtcNow
                    //State = Icatt.Data.Entity.
                });
                dbc.SaveChanges();
            }
        }


        [TestMethod]
        public void DataRandomizertest()
        {
            var stub = new DeelnemerPortalApiStub<object>();
            var datacoll = stub.StubManager.DataCollection;
            datacoll.AddRandomVerzekerden(3);
            datacoll.AddRandomPensioen(3);
            datacoll.AddRandomPensioenRechten(3);
            datacoll.AddRandomPolissen(3);
            datacoll.AddDocumentInfo("123");
            datacoll.AddDocument("123");

            Assert.AreEqual(3, datacoll.Verzekerden.Count);
            foreach (var verzekerde in datacoll.Verzekerden)
            {
                Assert.IsNotNull(verzekerde);
                Assert.IsNotNull(verzekerde.Bsn);
                Assert.IsNotNull(verzekerde.Id);
                Assert.IsNotNull(verzekerde.Nummer);
                Assert.IsNotNull(verzekerde.AchternaamVolledig);
                Assert.IsNotNull(verzekerde.Adressen);
                Assert.IsNotNull(verzekerde.Bereikbaarheden);
                Assert.IsNotNull(verzekerde.HuidigePartner);

                DumpObject(verzekerde);
            }
            Assert.AreEqual(3, datacoll.Polissen.Count);
            foreach (var polis in datacoll.Polissen)
            {
                Assert.IsNotNull(polis);
                Assert.IsNotNull(polis.ArbeidsgegevensVariabel);
                Assert.IsNotNull(polis.DatumToetredingWao);
                Assert.IsNotNull(polis.ArbeidsgegevensVast);
                Assert.IsNotNull(polis.BedragFranchise);
                Assert.IsNotNull(polis.Reglement);

                DumpObject(polis);
            }

        }

        private static void DumpObject(object record,int indent = -1)
        {
            indent++;
            var tab = Tab(indent);

            Trace.WriteLine($"{tab}=============================");
            Trace.WriteLine($"{tab}{record.GetType().Name}");
            Trace.WriteLine($"{tab}vvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
            foreach (var propertyInfo in record.GetType().GetProperties())
            {
                if (propertyInfo.PropertyType.IsArray)
                {
                    var arrayType = propertyInfo.PropertyType;
                    var array = propertyInfo.GetValue(record);
                    var length = (int) (arrayType.GetProperty("Length")?.GetValue(array) ?? 0);
                    var getter = arrayType.GetMethod("Get");
                    for (int i = 0; i < length; i++)
                    {
                        Trace.WriteLine($"{tab}{propertyInfo.Name}[{i}]: ");
                        var r = getter.Invoke(array, new object[] {i});
                        DumpObject(r,indent);

                    }
                }
                else
                {
                    var value = propertyInfo.GetValue(record);
                    var dmp = value.ToString();
                    if (propertyInfo.PropertyType.FullName != dmp)
                    {
                        Trace.WriteLine($"{tab}{propertyInfo.Name}: {dmp}");
                    }
                    else
                    {
                        Trace.WriteLine($"{tab}{propertyInfo.Name}:");
                        DumpObject(propertyInfo.GetValue(record),indent);
                    }
                }
            }
            Trace.WriteLine($"{tab}^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        }

        private static string Tab(int indent)
        {
            var tab = "";
            for (int i = 0; i < indent; i++)
            {
                tab += "    ";
            }
            return tab;
        }

        [TestMethod]
        public void UT_PensioenAccessService_ActueelPensioen_with_all_stubs()
        {
             

            //de klantportssl.access.pensioen.service combineert de data die door de piramide webservice (stub) wordt geretourneerd in een ActueelPensioen object
            var stub = new DeelnemerPortalApiStub<TestContext>();
            var dossierNr = "testDossierID";
            stub.StubManager.DataCollection.Verzekerden.Add(new Verzekerde()
            {
                AchternaamVolledig = "testAchternaam",
                Nummer = dossierNr,
            });

            stub.StubManager.DataCollection.Polissen.Add(new Polis() { DossierId = dossierNr });

            var stubs = new Dictionary<string, Func<object>>
            {
                ["IDeelnemerPortalApi"] = () => stub,
            };

            var factoryContainer = new TestKlantPortaalFactoryContainer(stubs);

            var context = new KlantPortaalContext
            {
                DossierNummer = dossierNr
            };

            var service = new Sphdhv.KlantPortaal.Access.Pensioen.Service.PensioenAccess<KlantPortaalContext>(context, LocalTestDbName, factoryContainer);

            var resultTask = service.ActueelPensioenAsync();
            resultTask.Wait(TimeSpan.FromSeconds(2));

            Assert.IsNotNull(resultTask);
            Assert.IsNotNull(resultTask.Result);
            Assert.IsTrue(resultTask.IsCompleted);
            Assert.AreEqual("testAchternaam", resultTask.Result.DeelnemerProfiel.AchternaamVolledig);
            Assert.IsTrue(resultTask.Result.Polissen.Count > 0);
            Assert.AreEqual("testDossierID", resultTask.Result.Polissen[0].DossierId);

        }

        [TestMethod]
        public void UT_PensioenAccessService_ActueelPensioen_Deelnemerprofiel_is_null_wanneer_de_webservice_geen_verzekerde_retourneerd_with_all_stubs()
        {
            //NB. deze test is een beetje dubieus. het is nog niet helemaal duidelijk wat we willen dat er gebeurt als verzekerde null is ( en of dat wel kan, waarschijnlijk krijg je nooit null, maar een 404 response oid, waardoor er al een exceptie optreedt

            //de klantportssl.access.pensioen.service combineert de data die door de piramide webservice (stub) wordt geretourneerd in een ActueelPensioen object
            var stub = new DeelnemerPortalApiStub<TestContext>();

            var stubs = new Dictionary<string, Func<object>>
            {
                ["IDeelnemerPortalApi"] = () => stub,
            };

            var factoryContainer = new TestKlantPortaalFactoryContainer(stubs);

            var context = new KlantPortaalContext();

            var service = new Sphdhv.KlantPortaal.Access.Pensioen.Service.PensioenAccess<KlantPortaalContext>(context, LocalTestDbName, factoryContainer);

            var task = service.ActueelPensioenAsync();

            task.Wait();


            Assert.IsNull(task.Result.DeelnemerProfiel);
        }

        [TestMethod]
        public void UT_PensioenAccessService_ActueelPensioen_Polis_is_null_wanneer_de_webservice_geen_Dossier_retourneerd_with_all_stubs()
        {
            //NB. deze test is een beetje dubieus. het is nog niet helemaal duidelijk wat we willen dat er gebeurt als polis null is ( en of dat wel kan, waarschijnlijk krijg je nooit null, maar een 404 response oid, waardoor er al een exceptie optreedt

            //de klantportssl.access.pensioen.service combineert de data die door de piramide webservice (stub) wordt geretourneerd in een ActueelPensioen object
            var stub = new DeelnemerPortalApiStub<TestContext>();

            var stubs = new Dictionary<string, Func<object>>
            {
                ["IDeelnemerPortalApi"] = () => stub,
            };

            var factoryContainer = new TestKlantPortaalFactoryContainer(stubs);

            var context = new KlantPortaalContext();

            var service = new Sphdhv.KlantPortaal.Access.Pensioen.Service.PensioenAccess<KlantPortaalContext>(context, LocalTestDbName, factoryContainer);

            var result = service.ActueelPensioenAsync();

            Assert.IsTrue(result.Result.Polissen.Count == 0);


        }

        [TestMethod]
        public void UT_PensioenAccessService_DeelnemerProfiel_with_all_stubs()
        {

            //de klantportal.access.pensioen.service combineert de data die door de piramide webservice (stub) wordt geretourneerd in een DeelnemerProfiel object
            var stub = new DeelnemerPortalApiStub<TestContext>();
            var dossierNr = "afdslkj435325";
            stub.StubManager.DataCollection.Verzekerden.Add(new Verzekerde()
            {
                AchternaamVolledig = "testAchternaam",
                Nummer = dossierNr
            });

            var stubs = new Dictionary<string, Func<object>>
            {
                ["IDeelnemerPortalApi"] = () => stub,
            };

            var factoryContainer = new TestKlantPortaalFactoryContainer(stubs);

            var context = new KlantPortaalContext
            {
                DossierNummer = dossierNr
            };

            var service = new Sphdhv.KlantPortaal.Access.Pensioen.Service.PensioenAccess<KlantPortaalContext>(context, factoryContainer);

            var result = service.DeelnemerProfiel();

            Assert.AreEqual("testAchternaam", result.Result.AchternaamVolledig);

        }

        [TestMethod]
        public void UT_PensioenAccessService_Documenten_with_all_stubs()
        {
            var stub = new DeelnemerPortalApiStub<TestContext>();
            var dossierNr = "afdslkj435325";
            stub.StubManager.DataCollection.AddDocument(dossierNr);
            stub.StubManager.DataCollection.AddDocumentInfo(dossierNr);


            var stubs = new Dictionary<string, Func<object>>
            {
                ["IDeelnemerPortalApi"] = () => stub,
            };

            var factoryContainer = new TestKlantPortaalFactoryContainer(stubs);

            var context = new KlantPortaalContext
            {
                DossierNummer = dossierNr
            };

            ICorrespondentieAccess service = new Sphdhv.KlantPortaal.Access.Correspondentie.Service.CorrespondentieAccess<KlantPortaalContext>(context, factoryContainer);

            var result = service.Overzicht().Result;

            foreach (var item in result.Items)
            {
                Assert.IsNotNull(item.Dossier);
                Assert.IsNotNull(item.Id);
                Assert.IsNotNull(item.Titel);

                var result2 = service.CorrespondentieItem(item.Id).Result;
                Assert.IsNotNull(result2.Properties);
                Assert.IsNotNull(result2.Bytes);
                Assert.AreEqual(result2.Properties.Titel, item.Titel);
            }

        }

    }

   
}
