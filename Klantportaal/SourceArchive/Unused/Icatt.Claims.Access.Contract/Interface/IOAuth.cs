
namespace Icatt.OAuth.Interface
{
    /// <summary>
    /// 
    /// </summary>
    public interface IOAuth
    {
        Contract.AuthenticationMethod AuthenticationMethod(string appId, string envId,string returnUrl, string relayState);
        Contract.Claim[] ExchangeToken(string authToken);

    }
}
