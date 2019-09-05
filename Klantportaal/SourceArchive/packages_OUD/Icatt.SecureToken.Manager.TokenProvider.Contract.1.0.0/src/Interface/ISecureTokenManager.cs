using System.ServiceModel;
using Icatt.SecureToken.Manager.TokenProvider.Contract;

namespace Icatt.SecureToken.Manager.TokenProvider.Interface
{
    [ServiceContract]
    public interface ISecureTokenManager
    {
        [OperationContract]
        GetAuthenticationMethodResponse GetAuthenticationMethod(GetAuthenticationMethodRequest request);


        [OperationContract]
        VerifyAuthenticationTokenResponse VerifyAuthenticationToken(VerifyAuthenticationTokenRequest request);


        [OperationContract]
        RefreshTokenResponse RefreshToken(RefreshTokenRequest request);


    }
}
