using System.Security.Cryptography;
using System.Text;

namespace Icatt.Security
{
    public static class Encrypter
    {
        public static byte[] AesEncrypter(string password, string iv, CipherMode cipherMode, string inputString)
        {
            using (var aes = new AesManaged())
            {
                aes.Key = Encoding.UTF8.GetBytes(password);
                aes.IV = Encoding.UTF8.GetBytes(iv);
                aes.Mode = cipherMode;

                var crypto = aes.CreateEncryptor(aes.Key, aes.IV);
                var input = Encoding.UTF8.GetBytes(inputString);

                return crypto.TransformFinalBlock(input, 0, input.Length);
                
            }
        }

        public static byte[] AesEncrypter(byte[] password, byte[] iv, CipherMode cipherMode, byte[] input)
        {
            using (var aes = new AesManaged())
            {
                aes.Key = password;
                aes.IV = iv;
                aes.Mode = cipherMode;
                var crypto = aes.CreateEncryptor(aes.Key, aes.IV);
                return crypto.TransformFinalBlock(input, 0, input.Length);
            }
        }

        /// <summary>
        /// Decrypts an array of bytes using <see cref="AesManaged"/> as implementation of the Advanced Encryption Standard (AES) symmetric algorithm.
        /// </summary>
        /// <param name="password">Key</param>
        /// <param name="iv">Initialization factor</param>
        /// <param name="cipherMode"></param>
        /// <param name="input">Encrypted byte array</param>
        /// <param name="encoding">Encoding used to convert the decrypted bytes to string and also the <paramref name="password"/> and <paramref name="iv"/> strings to bytes. UTF8 is used if omitted</param>
        /// <returns>Decrypted byte array</returns>
        public static string AesDecrypter(string password, string iv, CipherMode cipherMode, byte[] input, Encoding encoding= null)
        {
            encoding = encoding ?? Encoding.UTF8;

            using (var aes = new AesManaged())
            {
                aes.Key = encoding.GetBytes(password);
                aes.IV = encoding.GetBytes(iv);
                aes.Mode = cipherMode;

                var crypto = aes.CreateDecryptor(aes.Key, aes.IV);

                var resultBytes = crypto.TransformFinalBlock(input, 0, input.Length);

                return encoding.GetString(resultBytes);

            }
        }

        public static string AesDecrypter(byte[] password, byte[] iv, CipherMode cipherMode, byte[] input, Encoding encoding = null)
        {
            encoding = encoding ?? Encoding.UTF8;

            using (var aes = new AesManaged())
            {
                aes.Key = password;
                aes.IV = iv;
                aes.Mode = cipherMode;

                var crypto = aes.CreateDecryptor(aes.Key, aes.IV);

                var resultBytes = crypto.TransformFinalBlock(input, 0, input.Length);

                return encoding.GetString(resultBytes);

            }
        }


    }
}
