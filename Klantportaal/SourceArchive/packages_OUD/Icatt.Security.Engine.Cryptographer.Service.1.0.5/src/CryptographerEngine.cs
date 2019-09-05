using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using Icatt.Security.Engine.Cryptographer.Contract;
using Icatt.Security.Engine.Cryptographer.Interface;
using Icatt.Security.Engine.Cryptographer.Service.InternalCryptographers;
using Icatt.ServiceModel;

namespace Icatt.Security.Engine.Cryptographer.Service
{
    public class CryptographerEngine<TContext> : ServiceBase<TContext>, ICryptographer, ICryptographerAdmin where TContext : class
    {
        public CryptographerEngine(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {


        }

        #region ICryptograhper implementation

        byte[] ICryptographer.Encrypt(string cipherName, byte[] key, byte[] value)
        {
            var cipher = ParseCipherName(cipherName);

            using (var cryptographer = CreateCryptographer(cipher))
            {
                return cryptographer.Encrypt(key, value);
            }


        }

        byte[] ICryptographer.Decrypt(string cipherName, byte[] key, byte[] encryptedValue)
        {
            if (key == null || key.Length == 0)
                return null;

            var cipher = ParseCipherName(cipherName);

            using (var cryptographer = CreateCryptographer(cipher))
            {
                try
                {
                    return cryptographer.Decrypt(key, encryptedValue);
                }
                catch (CryptographicException)
                {
                    //Just return null value if the key does not match
                    return null;
                }
            }
        }


        byte[] ICryptographer.EncryptString(string cipherName, byte[] key, string value, string encodingName)
        {
            var cipher = ParseCipherName(cipherName);

            using (var cryptographer = CreateCryptographer(cipher))
            {
                var encoding = ParseEncoding(encodingName);

                var valueBytes = encoding.GetBytes(value);

                return cryptographer.Encrypt(key, valueBytes);
            }
        }


        string ICryptographer.DecryptString(string cipherName, byte[] key, byte[] encryptedValue, string encodingName)
        {
            var cipher = ParseCipherName(cipherName);

            using (var cryptographer = CreateCryptographer(cipher))
            {
                try
                {
                    var decryptedBytes = cryptographer.Decrypt(key, encryptedValue);

                    var encoding = ParseEncoding(encodingName);

                    return encoding.GetString(decryptedBytes);
                }
                catch (CryptographicException)
                {
                    //Just return NULL when the key does not match
                    return null;
                }
            }
        }

        byte[] ICryptographer.CreateKey(string cipherName)
        {
            var cipher = ParseCipherName(cipherName);

            using (var cryptographer = CreateCryptographer(cipher))
            {
                return cryptographer.CreateKey();
            }
        }

        #endregion

        #region ICryptographerAdmin implementation

        IList<SupportedCipher> ICryptographerAdmin.SupportedCiphers()
        {

            return new List<SupportedCipher>
            {
                new SupportedCipher
                {
                    Id = SupportedCipherName.Aes256With16ByteIvPrefix.ToString(),
                    Description = "Uses the System.Security.Cryptography.AesManager class with CipherMode.CBC and a byte array composed of a 16 byte initialization vector prefixed to a 32 byte internal key as external key"
                },
                new SupportedCipher
                {
                    Id = SupportedCipherName.Aes256WithoutIv.ToString(),
                    Description = "Uses the System.Security.Cryptography.AesManager class with CipherMode.CBC, a 32 byte array as key and null as initialization vector"
                },
            };
        }

        #endregion

        #region private helper methods

        private static ICryptographerInternal CreateCryptographer(SupportedCipherName cipher)
        {
            switch (cipher)
            {
                case SupportedCipherName.Aes256With16ByteIvPrefix:
                    return new AesCryptographer();
                case SupportedCipherName.Aes256WithoutIv:
                    return new AesCryptographer(false);
                default:
                    throw new InvalidOperationException($"Unsupported cipher '{cipher:G}' requested.");
            }
        }

        private static SupportedCipherName ParseCipherName(string cipherName)
        {
            SupportedCipherName cipher;
            if (!Enum.TryParse(cipherName, true, out cipher))
            {
                throw new ArgumentException($"Unknown cipher name: '{cipherName}'", nameof(cipherName));
            }
            return cipher;
        }

        /// <summary>
        /// Resolves the encoding name using UTF-8 if no name is specified
        /// </summary>
        /// <exception cref="ArgumentException">thrown if nameEncoding is not a valide or supported encoding WebName </exception>
        private static Encoding ParseEncoding(string nameEncoding)
        {
            if (string.IsNullOrEmpty(nameEncoding))
                return Encoding.UTF8;

            return Encoding.GetEncoding(nameEncoding);

        }

      


        #endregion

    } //class
} //namespace
