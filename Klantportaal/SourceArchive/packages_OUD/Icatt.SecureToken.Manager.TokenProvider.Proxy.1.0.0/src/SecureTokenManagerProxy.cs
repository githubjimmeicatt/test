using Icatt.SecureToken.Manager.TokenProvider.Contract;
using Icatt.SecureToken.Manager.TokenProvider.Interface;
using Icatt.ServiceModel;

namespace Icatt.SecureToken.Manager.TokenProvider.Proxy
{
    public class SecureTokenManagerProxy<TContext>:ProxyBase<ISecureTokenManager, TContext>, ISecureTokenManager where TContext: class
    {
        public SecureTokenManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public GetAuthenticationMethodResponse GetAuthenticationMethod(GetAuthenticationMethodRequest request)
        {
            return Invoke(request,(r) => Service.GetAuthenticationMethod(r));
        }


        public VerifyAuthenticationTokenResponse VerifyAuthenticationToken(VerifyAuthenticationTokenRequest request)
        {
            return Invoke(request,(r) => Service.VerifyAuthenticationToken(r));
        }

        public RefreshTokenResponse RefreshToken(RefreshTokenRequest request)
        {
            return Invoke(request,(r) => Service.RefreshToken(r));
        }
    }
}
