using System;
using Icatt.OAuth.Contract;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using Sphdhv.KlantPortaal.Access.AuthToken.Contract;

namespace Sphdhv.KlantPortaal.Access.AuthToken.Proxy
{
    public class AuthTokenAccessProxy<TContext> : ProxyBase<IAuthTokenAccess, TContext>, IAuthTokenAccess where TContext : class
    {
        public AuthTokenAccessProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        TokenEntry IAuthTokenAccess.IssueToken(Claim[] claims, TimeSpan expiresInTimeSpan)
        {
            return Invoke(claims, expiresInTimeSpan, Service.IssueToken);
        }

        Claim[] IAuthTokenAccess.RedeemToken(string token, string signature)
        {
            return Invoke(token, signature, Service.RedeemToken);
        }
    }
}
