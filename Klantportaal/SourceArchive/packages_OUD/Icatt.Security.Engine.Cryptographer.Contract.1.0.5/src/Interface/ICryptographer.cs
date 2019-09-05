using System.Collections;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Icatt.Security.Engine.Cryptographer.Contract;

namespace Icatt.Security.Engine.Cryptographer.Interface
{
    [ServiceContract]
    public interface ICryptographer
    {
        [OperationContract]
        byte[] Encrypt(string cipher, byte[] key, byte[] value);

        [OperationContract]
        byte[] Decrypt(string cipher, byte[] key, byte[] encryptedValue);

        [OperationContract]
        byte[] EncryptString(string cipher, byte[] key, string value, string encoding = null);

        [OperationContract]
        string DecryptString(string cipher, byte[] key,  byte[] encryptedValue, string encoding = null);

        [OperationContract]
        byte[] CreateKey(string cipher);

    }



    [ServiceContract]
    public interface ICryptographerAdmin
    {
        [OperationContract]
        IList<SupportedCipher> SupportedCiphers();

    }
}

