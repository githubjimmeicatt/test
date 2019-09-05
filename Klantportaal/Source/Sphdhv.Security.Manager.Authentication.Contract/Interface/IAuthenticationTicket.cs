namespace Sphdhv.Security.Manager.Authentication.Interface
{
    public interface IAuthenticationTicket
    {
        string AuthenticationTicket { get; set; }
    }

    public interface ICrossSiteRequestForgery
    {
        string CsrfTokenFromCookie { get; set; }
        string CsrfTokenFromRequest { get; set; }
    }
}