using System;
using System.Linq;
using Icatt.Data.Entity;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Common;
using Icatt.Security.Engine.Cryptographer.Interface;
using Sphdhv.KlantPortaal.Data.Deelnemer.DbContext;
using Icatt.Azure.Access;
using System.Collections.Generic;
using Azure.Identity;
using System.Security.Cryptography.X509Certificates;
using Azure.Security.KeyVault.Keys;

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



    }


    //internal class Decryptor
    //{
    //    private string cipherName;
    //    private byte[] keyValue;
    //    private ICryptographer cryptoEngine;

    //    public Decryptor(string cipherName, byte[] keyValue, ICryptographer cryptoEngine)
    //    {
    //        this.cipherName = cipherName;
    //        this.keyValue = keyValue;
    //        this.cryptoEngine = cryptoEngine;
    //    }

    //    public string Decrypt(byte[] encrypted, string plainText = null)
    //    {
    //        if (encrypted == null)
    //        {
    //            return plainText;
    //        }

    //        return cryptoEngine.DecryptString(cipherName, keyValue, encrypted);
    //    }
    //}
}
