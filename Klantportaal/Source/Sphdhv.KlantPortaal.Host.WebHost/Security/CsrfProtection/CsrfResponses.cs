namespace Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection
{
    public static class CsrfResponses
    {
        public static ResponseMessage ViolationResponse
        {
            get
            {
                return new ResponseMessage(400, "Cross Site Request Violation");
            }
        }
    }
}