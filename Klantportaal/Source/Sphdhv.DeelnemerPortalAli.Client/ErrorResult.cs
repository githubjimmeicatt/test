using System.Collections.Generic;

namespace Sphdhv.DeelnemerPortalApi.Client
{
    public class Error
    {
        public string errorLevel { get; set; }
        public string code { get; set; }
        public string message { get; set; }
    }

    public class ErrorData
    {
        public List<Error> errors { get; set; }
    }
}