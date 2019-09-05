using System;
using System.Security.Cryptography;
using Icatt.Extensions;

namespace Icatt.Security.Engine.Cryptographer.Service.InternalCryptographers
{
    internal class AesCryptographer : ICryptographerInternal
    {
        private readonly AesManaged _aes;
        private readonly bool _isIvInKey;
        private readonly ThreadSafeRandomizer Randomizer;

        public AesCryptographer() : this(true)
        {
        }

        public AesCryptographer(bool isIvInKey)
        {
            _isIvInKey = isIvInKey;
            _aes = new AesManaged();
            Randomizer = new ThreadSafeRandomizer();
        }

        #region IInternalCryptographer implementation

        byte[] ICryptographerInternal.Encrypt(byte[] key, byte[] value)
        {
            byte[] keypart;
            byte[] ivpart;
            ValidateKey(key, out keypart, out ivpart);


            return Encrypt(value, keypart, ivpart, CipherMode.CBC);
        }



        byte[] ICryptographerInternal.Decrypt(byte[] key, byte[] encryptedValue)
        {
            byte[] keypart;
            byte[] ivpart;
            ValidateKey(key, out keypart, out ivpart);

            return Decrypt(encryptedValue, keypart, ivpart, CipherMode.CBC);
        }


        byte[] ICryptographerInternal.CreateKey()
        {
            var ivlen = 0;
            byte[] key;
            var keypart = new byte[32];
            Randomizer.NextBytes(keypart);

            if (_isIvInKey)
            {
                var ivpart = new byte[16];
                ivlen = ivpart.Length;
                Randomizer.NextBytes(ivpart);
                
                key = new byte[keypart.Length + ivpart.Length];
                ivpart.CopyTo(key, 0);
            } else
            {
                key = new byte[keypart.Length];
            }

            keypart.CopyTo(key, ivlen);

            return key;
        }
        void IDisposable.Dispose()
        {
            _aes?.Dispose();
        }


        #endregion



        #region private AES worker implementations

        private byte[] Encrypt(byte[] value, byte[] key, byte[] iv, CipherMode cipherMode)
        {
            ValidateInput(value, key,ref iv);

            _aes.Key = key;
            _aes.IV = iv;
            _aes.Mode = cipherMode;
            var crypto = _aes.CreateEncryptor(_aes.Key, _aes.IV);
            return crypto.TransformFinalBlock(value, 0, value.Length);
        }


        private byte[] Decrypt(byte[] encryptedValue, byte[] key, byte[] iv, CipherMode cipherMode)
        {
            ValidateInput(encryptedValue, key,ref iv);

            _aes.Key = key;
            _aes.IV = iv;
            _aes.Mode = cipherMode;

            var crypto = _aes.CreateDecryptor(_aes.Key, _aes.IV);

            var decryptedValue = crypto.TransformFinalBlock(encryptedValue, 0, encryptedValue.Length);

            return decryptedValue;

        }

        #endregion

        #region private helpers


        private void ValidateKey(byte[] key, out byte[] keypart, out byte[] ivpart)
        {
            if (key == null) throw new ArgumentNullException(nameof(key));

            if (!_isIvInKey)
            {
                keypart = key;
                ivpart = null;
                return;
            }

            if (key.Length != 48)
                throw new ArgumentOutOfRangeException(nameof(key), $"The byte array must be exactly 48 bytes long composed of a 16 byte IV and a 32 byte key");

            ivpart = key.Slice(0, 15);
            keypart = key.Slice(16);

        }

        private static void ValidateInput(byte[] value, byte[] key,ref byte[] iv)
        {
            if (value == null) throw new ArgumentNullException(nameof(value));

            if (key == null) throw new ArgumentNullException(nameof(key));

            if (iv == null)
                iv = new byte[] { 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};

            if (iv.Length != 16)
                throw new ArgumentOutOfRangeException(nameof(iv), $"The '{nameof(iv)}' must be exactly 16 bytes  long.");
            if (key.Length != 32)
                throw new ArgumentOutOfRangeException(nameof(iv), $"The '{nameof(key)}' must be exactly 32 bytes long.");
        }



        #endregion




    }
}
