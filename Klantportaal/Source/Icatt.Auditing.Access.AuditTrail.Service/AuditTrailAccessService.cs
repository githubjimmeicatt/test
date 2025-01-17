﻿using Icatt.ServiceModel;
using System;
using Icatt.Logging.DataAccess;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Diagnostics;

using Icatt.Security.Engine.Cryptographer.Interface;

using Icatt.Auditing.Access.AuditTrail.Service.Properties;
using Icatt.Azure.Access;

namespace Icatt.Auditing.Access.AuditTrail.Service
{




    public interface IAuditContext
    {
        string ApplicationName { get; }
        Guid? LogRequestId { get; }
        Guid? LogSessionId { get; }
    }

    public class AuditTrailAccessService<TContext> : ServiceBase<TContext>, Interface.IAuditTrailAccess
        where TContext : class, IAuditContext
    {

        private ICryptographer _cryptoEngine;



        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = FactoryContainer.ProxyFactory.CreateProxy<ICryptographer>(Context));


        public AuditTrailAccessService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {

        }



        public void WriteEntry(Enum eventType, object data, bool encryptData)
        {

            //get type
            var t = data.GetType();

            var tName = t.AssemblyQualifiedName;

            //Todo add type to DataTypes table
            //For now, only one specific type supported
            //With fixed type ID 1

            var typeId = 1;

            //serialize data

            var ser = new DataContractJsonSerializer(t);
            string json = string.Empty;
            using (var ms = new MemoryStream())
            {
                ser.WriteObject(ms, data);
                ms.Position = 0;
                using (var streamReader = new StreamReader(ms))
                {
                    json = streamReader.ReadToEnd();
                }
            }


            byte[] encryptedJson = null;
            if (encryptData)
            {

                var secret = Settings.Default.AuditKeyVaultAuditSecret;

                var keyVault = new KeyVault(Settings.Default.AuditKeyVaultCertificateThumbprint, Settings.Default.AuditKeyVaultClientId, Settings.Default.AuditKeyVaultTenantId, Settings.Default.AuditKeyVaultUrl);

                byte[] key = keyVault.GetSecret(secret);
                var cipherName = "Aes256With16ByteIvPrefix";

                encryptedJson = CryptoEngine.EncryptString(cipherName, key, json);

                using (var rep = FactoryContainer.ProxyFactory.CreateProxy<ILoggingRepository>(Context))
                {
                    var entry = new Logging.Entities.LogEntry
                    {
                        ApplicationName = Context.ApplicationName,
                        CreatedAtUtc = DateTime.UtcNow,
                        ApplicationArea = "AuditTrail",
                        Details = encryptData ? null : json,
                        DetailsEncrypted = encryptedJson,
                        DetailsTypeId = typeId,
                        LogLevel = 0,
                        Message = eventType.ToString(),
                        MessageId = Convert.ToInt32(eventType),
                        RequestId = Context.LogRequestId,
                        SessionId = Context.LogRequestId,
                        Timestamp = Stopwatch.GetTimestamp(),
                        Id = Guid.NewGuid(),
                    };

                    rep.Add(entry);
                }

            }
        }

    }
}
