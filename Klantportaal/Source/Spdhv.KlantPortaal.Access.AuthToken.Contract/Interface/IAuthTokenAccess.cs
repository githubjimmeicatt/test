using Icatt.OAuth.Contract;
using System;

namespace Sphdhv.KlantPortaal.Access.AuthToken.Interface
{
    public interface IAuthTokenAccess
    {
        Contract.TokenEntry IssueToken(Claim[] claims, TimeSpan expiresInTimeSpan);
        Claim[] RedeemToken(string token, string signature);
    }
}
