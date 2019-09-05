using System;
using Icatt.OAuth.Contract;

namespace Sphdhv.KlantPortaal.Access.AuthToken.Contract
{
    public class TokenEntry
    {
        public string Token { get; set; }
        public DateTime IssuedAtUtc { get; set; }

        public TimeSpan ExpiresInTimeSpan { get; set; }

        public Claim[] Claims { get; set; }
        public byte[] Secret { get; set; }
        public byte[] Signature { get; set; }

        public override string ToString()
        {
            return string.Concat(Token, ".", Convert.ToBase64String(Signature));
        }
    }
}
