namespace Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection
{
    public class ResponseMessage
    {
        public ResponseMessage(int statusCode, string errorMessage)
        {
            StatusCode = statusCode;
            ErrorResponse = new ErrorResponseMessage() {
                Message = errorMessage
            };
        }

        public int StatusCode { get; set; }
        public ErrorResponseMessage ErrorResponse { get; set; }

        public class ErrorResponseMessage
        {
            public string Message { get; set; }
        }
    }
}