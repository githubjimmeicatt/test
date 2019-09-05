using System.Collections;
using System.Web;
using Moq;

namespace Icatt.Test.Moq
{
    public class HttpContextMocks
    {
        public Mock<HttpContextBase> HttpContext { get; set; }
        public Mock<HttpRequestBase> HttpRequest { get; set; }
        public Mock<HttpResponseBase> HttpResponse { get; set; }
        public Mock<HttpSessionStateBase> Session { get; set; }
    }
}