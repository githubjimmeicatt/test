using System;
using System.Linq;
using Icatt.Data.Entity;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Common;
using Icatt.Security.Engine.Cryptographer.Interface;
using Sphdhv.KlantPortaal.Data.Deelnemer.DbContext;
using Sphdhv.KlantPortaal.Data.Deelnemer.Entities;
using Icatt.Azure.Access;
using System.Collections.Generic;

namespace Sphdhv.KlantPortaal.Access.Deelnemer.Service
{
    public class DeelnemerAccessService<TContext> : ServiceBase<TContext>, IDeelnemerAccess where TContext : class, IUserContext
    {
        private ICryptographer _cryptoEngine;
        private string _connectionStringOrName;

        private ICryptographer CryptoEngine => _cryptoEngine ?? (_cryptoEngine = FactoryContainer.ProxyFactory.CreateProxy<ICryptographer>(Context));


        public DeelnemerAccessService(TContext context, string connectionStringOrName) : this(context, connectionStringOrName, null)
        {
        }


        public DeelnemerAccessService(TContext context, IFactoryContainer<TContext> factoryContainer) : this(context, null, factoryContainer)
        {
        }

        public DeelnemerAccessService(TContext context, string connectionStringOrName, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
            _connectionStringOrName = connectionStringOrName;
        }


        public List<Contract.Deelnemer> Deelnemers()
        {
            using (var context = new DeelnemerDbContext(_connectionStringOrName))
            {
                return context.Deelnemers
                    .ToList()
                    .Select(deelnemerEntity => new Contract.Deelnemer
                    {
                        Id = deelnemerEntity.Id,
                        Email = DecryptWithKeyVault(deelnemerEntity.Email),
                        Status = (Contract.DeelnemerStatus)deelnemerEntity.Status,
                        ModifiedAtUtc = deelnemerEntity.ModifiedAtUtc,
                        Bsn = DecryptWithKeyVault(deelnemerEntity.Bsn)
                    })
                    .ToList();
            }
        }

        public Contract.Deelnemer Deelnemer()
        {

            var bsnHash = GetHashedBsn();

            using (var context = new DeelnemerDbContext(_connectionStringOrName))
            {
                var deelnemerEntity = context.Deelnemers.SingleOrDefault(d => d.BsnHash == bsnHash);

                if (deelnemerEntity == null)
                    return null;

                var deelnemer = new Contract.Deelnemer
                {
                    Id = deelnemerEntity.Id,
                    Email = DecryptWithKeyVault(deelnemerEntity.Email),
                    Status = (Contract.DeelnemerStatus)deelnemerEntity.Status,
                    ModifiedAtUtc = deelnemerEntity.ModifiedAtUtc,
                    VerificationId = deelnemerEntity.VerificationId,
                    Bsn = DecryptWithKeyVault(deelnemerEntity.Bsn)
                };

                return deelnemer;

            }

        }

        public int Update(DeelnemerUpdate deelnemer)
        {

            var bsnHash = GetHashedBsn();

            //using dbcontext 
            using (var context = new DeelnemerDbContext(_connectionStringOrName))
            {
                var deelnemerEntity = context.Deelnemers.SingleOrDefault(d => d.BsnHash == bsnHash);

                var lastMod = deelnemerEntity?.ModifiedAtUtc ?? DateTime.UtcNow;

                // encrypten bsn en email
                var bsnEncrypted = EncryptWithKeyVault(Context.Bsn);
                var emailEncrypted = EncryptWithKeyVault(deelnemer.Email ?? "");

                var withKeyVaultBsn = EncryptWithKeyVault(Context.Bsn);
                var withKeyVaultEmail = EncryptWithKeyVault(deelnemer.Email ?? "");

                var b64Bsn = Convert.ToBase64String(bsnEncrypted);
                var b64Email = Convert.ToBase64String(emailEncrypted);
                var b64BsnVault = Convert.ToBase64String(withKeyVaultBsn);
                var b64EmailVault = Convert.ToBase64String(withKeyVaultEmail);


                // als deelnemer al bestaat...
                // map naar deelnamer entity - alleen unenctrypted velden
                // ophalen uit db
                // update of create met 
                var objectState = ObjectState.Modified;
                if (deelnemerEntity == null)
                {
                    deelnemerEntity = new Data.Deelnemer.Entities.Deelnemer
                    {
                        CreatedAtUtc = DateTime.UtcNow
                    };
                    objectState = ObjectState.Added;
                }

                deelnemerEntity.BsnHash = bsnHash;
                deelnemerEntity.Bsn = bsnEncrypted;
                deelnemerEntity.Email = emailEncrypted;
                deelnemerEntity.ModifiedAtUtc = DateTime.UtcNow;
                deelnemerEntity.Status = (Data.Deelnemer.Entities.DeelnemerStatus)deelnemer.Status;
                deelnemerEntity.State = objectState;
                deelnemerEntity.VerificationId = deelnemer.VerificationId;

                context.Deelnemers.Add(deelnemerEntity);

                context.Save();

                return deelnemerEntity.Id;
            }
        }

        private string DecryptWithKeyVault(byte[] value)
        {
            var keyVault = FactoryContainer.ProxyFactory.CreateProxy<IKeyVault>(Context);

            var secret = Properties.Settings.Default.KeyVaultSecrect;
            byte[] key = keyVault.GetSecret(secret);

            var cipherName = "Aes256With16ByteIvPrefix";

            return CryptoEngine.DecryptString(cipherName, key, value);
        }

        private byte[] EncryptWithKeyVault(string value)
        {
            var keyVault = FactoryContainer.ProxyFactory.CreateProxy<IKeyVault>(Context);

            var secret = Properties.Settings.Default.KeyVaultSecrect;
            byte[] key = keyVault.GetSecret(secret);

            var cipherName = "Aes256With16ByteIvPrefix";

            return CryptoEngine.EncryptString(cipherName, key, value);
        }

        public int UpdateEmailStatus(Contract.DeelnemerStatus status)
        {
            var hashedBsn = GetHashedBsn();

            using (var context = new DeelnemerDbContext(_connectionStringOrName))
            {
                var deelnemer = context.Deelnemers.SingleOrDefault(d => d.BsnHash == hashedBsn);

                if (null == deelnemer)
                    return 0;

                deelnemer.Status = (Data.Deelnemer.Entities.DeelnemerStatus)status;
                deelnemer.State = ObjectState.Modified;

                context.Save();
                return deelnemer.Id;
            }

        }

        private byte[] GetHashedBsn()
        {
            using (var crypto = new System.Security.Cryptography.SHA512Managed())
            {
                return crypto.ComputeHash(System.Text.Encoding.UTF8.GetBytes(Context.Bsn));
            }
        }


    }


    internal class Decryptor
    {
        private string cipherName;
        private byte[] keyValue;
        private ICryptographer cryptoEngine;

        public Decryptor(string cipherName, byte[] keyValue, ICryptographer cryptoEngine)
        {
            this.cipherName = cipherName;
            this.keyValue = keyValue;
            this.cryptoEngine = cryptoEngine;
        }

        public string Decrypt(byte[] encrypted, string plainText = null)
        {
            if (encrypted == null)
            {
                return plainText;
            }

            return cryptoEngine.DecryptString(cipherName, keyValue, encrypted);
        }
    }
}
