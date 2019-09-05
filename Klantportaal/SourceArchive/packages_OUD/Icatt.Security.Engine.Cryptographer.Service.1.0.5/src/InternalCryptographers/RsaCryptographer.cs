using System;
using System.Security.Cryptography;

namespace Icatt.Security.Engine.Cryptographer.Service.InternalCryptographers
{
     internal class RsaCryptographer : ICryptographerInternal
     {

         public RsaCryptographer()
         {
         }


        /// <summary>
        /// Encrypt with the PUBLIC key, so only the owner of the PRIVATE key kan decrypt it...
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        byte[] ICryptographerInternal.Encrypt(byte[] key, byte[] value)
        {
            throw new NotImplementedException();
        }

        byte[] ICryptographerInternal.Decrypt(byte[] key, byte[] encryptedValue)
        {
            throw new NotImplementedException();
        }

        byte[] ICryptographerInternal.CreateKey()
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
