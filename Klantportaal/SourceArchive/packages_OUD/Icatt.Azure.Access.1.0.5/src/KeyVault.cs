using Microsoft.Azure.KeyVault;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Azure.Access
{
    public class KeyVault : IKeyVault
    {


        private readonly System.Security.Cryptography.X509Certificates.X509Certificate2 _cert;
        private readonly string _applicationId;
        private static readonly Dictionary<string, byte[]> _cachedSecrets = new Dictionary<string, byte[]>();
        private static readonly object _locker = new object();

        /// <summary>
        /// 
        /// </summary>
        /// <param name="cert">use the same certificate that is installed in the 'app registration' that is used to access the keyvault </param>
        /// <param name="applicationId">applicationid of the azure 'application regsitration'</param>
        public KeyVault(System.Security.Cryptography.X509Certificates.X509Certificate2 cert, string applicationId)
        {
            _cert = cert;
            _applicationId = applicationId;
        }


        /// <summary>
        /// returns a secret form the Azure Kay Vault
        /// </summary>
        /// <param name="secretUrl">
        /// De volledige url van de secret in azure key vault.
        /// Er wordt ervan uitgegaan dat het secret een base64 encode bytearray is!
        /// Voorbeeld aanmaken secret value: Convert.ToBase64String(Encoding.Default.GetBytes("hetgeheim"))
        /// Hetgeheim moet een veelvoudv van 16 characters lang zijn
        /// </param>
        /// <returns></returns>
        public byte[] GetSecret(string secretUrl)
        {

            //is het opgevraagde secret beschikbaar in de cache?
            if (!_cachedSecrets.ContainsKey(secretUrl))
            {
                lock (_locker)
                {
                    //na het plaatsen van de lock kan een ander hem al opgehaald hebben. dus toch nog een keer checken of hij nu in de cache zit
                    if (!_cachedSecrets.ContainsKey(secretUrl))
                    {

                        var kv = new KeyVaultClient(new KeyVaultClient.AuthenticationCallback(GetToken));

                        var sec = kv.GetSecretAsync($"{secretUrl}").Result;

                        var secretValue = Convert.FromBase64String(sec.Value);

                        //the secret will be encryted before storing in the cache.
                        //do this with a copy of the secret. not the secret itself because otherwise the encrypted value will be returned from this function. 
                        byte[] copyOfSecretValue = new byte[secretValue.Length];
                        secretValue.CopyTo(copyOfSecretValue, 0);

                        ProtectedMemory.Protect(secretValue, MemoryProtectionScope.SameProcess);
                        _cachedSecrets[secretUrl] = secretValue;

                        return copyOfSecretValue;
                    }
                }
            }


            //get secret from cache to prevent redundand calls to the azure key vault 
            var cachedProtectedSecret = _cachedSecrets[secretUrl];

            //the secret is stored in protected memeory and therefore needs to be unencrypted first.
            //unencrypt a copy,not the secret in the cache itself
            byte[] cachedBytes = new byte[cachedProtectedSecret.Length];
            cachedProtectedSecret.CopyTo(cachedBytes, 0);
            ProtectedMemory.Unprotect(cachedBytes, MemoryProtectionScope.SameProcess);

            return cachedBytes;


        }



        private async Task<string> GetToken(string authority, string resource, string scope)
        {
            var authContext = new AuthenticationContext(authority);

            var assertionCert = new ClientAssertionCertificate(_applicationId, _cert);

            AuthenticationResult result = await authContext.AcquireTokenAsync(resource, assertionCert);

            if (result == null)
            {
                throw new InvalidOperationException("Failed to obtain the token");
            }

            return result.AccessToken;
        }



    }

}

