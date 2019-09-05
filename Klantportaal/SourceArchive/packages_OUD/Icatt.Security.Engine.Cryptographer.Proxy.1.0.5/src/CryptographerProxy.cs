using System;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.ServiceModel;

namespace Icatt.Security.Engine.Cryptographer.Proxy
{
    public class CryptographerProxy<TContext> : ProxyBase<ICryptographer,TContext>, ICryptographer where TContext : class
    {
        public CryptographerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        byte[] ICryptographer.Encrypt(string cipher, byte[] key, byte[] value)
        {
            return Invoke(cipher, key, value,Service.Encrypt);
        }

        byte[] ICryptographer.Decrypt(string cipher, byte[] key, byte[] encryptedValue)
        {
            return Invoke(cipher, key, encryptedValue, Service.Decrypt);
        }

        byte[] ICryptographer.EncryptString(string cipher, byte[] key, string value, string encoding)
        {
            return Invoke(cipher, key, value, encoding, Service.EncryptString);
        }

        string ICryptographer.DecryptString(string cipher, byte[] key, byte[] encryptedValue, string encoding)
        {
            return Invoke(cipher, key, encryptedValue, encoding, Service.DecryptString);
        }

        byte[] ICryptographer.CreateKey(string cipher)
        {
            return Invoke(cipher, Service.CreateKey);
        }
    }
}
