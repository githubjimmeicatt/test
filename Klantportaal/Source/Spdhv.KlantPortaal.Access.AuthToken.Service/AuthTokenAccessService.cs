using Icatt;
using Icatt.OAuth.Contract;
using Icatt.ServiceModel;
using Icatt.Time;
using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using System;
using System.Linq;

namespace Sphdhv.KlantPortaal.Access.AuthToken.Service
{
    public class AuthTokenAccessService<TContext> : TokenEntryMemoryStore, IAuthTokenAccess where TContext : class

    {
        private readonly IFactoryContainer<TContext> _factoryContainer;
        public TContext Context { get;  }

        public AuthTokenAccessService(TContext context, IFactoryContainer<TContext> factoryContainer)
        {
            Context = context;
            _factoryContainer = factoryContainer;
        }

        public TokenEntry IssueToken(Claim[] claims, TimeSpan expiresInTimeSpan)
        {
            var r = _factoryContainer.ProxyFactory.CreateProxy<IRandomizer>(null);
            var t = _factoryContainer.ProxyFactory.CreateProxy<ITimeMachine>(null);

            TokenEntry entry;
            lock (InMemoryStoreLock)
            {
                string token;
                byte[] tokenBytes;
                do
                {
                    tokenBytes = new byte[64];

                    r.NextBytes(tokenBytes);

                    token = Convert.ToBase64String(tokenBytes);
                } while (InMemoryStore.ContainsKey(token));

                var secretBytes = new byte[64];
                r.NextBytes(secretBytes);


                var issuedAt = t.UtcNow;

                var issuedAtBytes = BitConverter.GetBytes(issuedAt.ToBinary());

                entry = new TokenEntry
                {
                    Token = token,

                    Claims = claims,
                    ExpiresInTimeSpan = expiresInTimeSpan,
                    IssuedAtUtc = issuedAt,
                    Secret = secretBytes,
                    Signature = GetSignature(tokenBytes, issuedAtBytes, secretBytes)
                };

                InMemoryStore[token] = entry;

                if (InMemoryStore.Count > 1000) //TODO make threshold setting
                {
                    var now = t.UtcNow;
                    foreach (var tokenEntry in InMemoryStore.Values.ToList()) //NB ToList MOET, niet weghalen. Omdat ..Values collectie binnen loop wordt aangepast
                    {
                        if (tokenEntry.IssuedAtUtc.Add(entry.ExpiresInTimeSpan) < now)
                        {
                            InMemoryStore.Remove(tokenEntry.Token);
                        }
                    }
                }

            }


            return entry;
        }

        public Claim[] RedeemToken(string token, string signature)
        {
            var t = _factoryContainer.ProxyFactory.CreateProxy<ITimeMachine>(null);

            Claim[] claims = null;
            lock (InMemoryStoreLock)
            {
                TokenEntry tokenEntry;
                if (InMemoryStore.TryGetValue(token, out tokenEntry))
                {
                    if (tokenEntry.IssuedAtUtc.Add(tokenEntry.ExpiresInTimeSpan) >= t.UtcNow)
                    {
                        if (ValidateSignature(tokenEntry, signature))
                        {
                            InMemoryStore.Remove(token);

                            claims = tokenEntry.Claims;
                        }
                    }
                }

            }

            return claims;
        }

        private bool ValidateSignature(TokenEntry tokenEntry, string signature)
        {
            return signature.Equals(Convert.ToBase64String(tokenEntry.Signature), StringComparison.Ordinal);
        }

        private byte[] GetSignature(byte[] tokenBytes, byte[] issuedAtBytes, byte[] secretBytes)
        {
            //Concatenate array's
            //Hashitup
            //Return hash

            return tokenBytes;
        }


    }
}
