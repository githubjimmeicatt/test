using System.Web;

namespace Icatt.Test.Stubs
{
    public  class NullHttpCachePolicy : HttpCachePolicyBase
    {
        public override void SetCacheability(HttpCacheability cacheability)
        {
        }

        public override void AppendCacheExtension(string extension)
        {
             
        }
    }
}