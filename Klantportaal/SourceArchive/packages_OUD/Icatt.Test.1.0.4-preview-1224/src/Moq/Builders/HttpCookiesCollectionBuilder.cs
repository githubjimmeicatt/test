using System.Web;

namespace Icatt.Test.Moq.Builders
{
    public class HttpCookiesCollectionBuilder : Builder<HttpCookieCollection>
    {
        public HttpCookiesCollectionBuilder()
        {
            Constructor = () =>
            {
                var cookies = new HttpCookieCollection();

                return cookies;
            };

        }

        public HttpCookiesCollectionBuilder WithCookie(HttpCookie cookie)
        {
            WithModifier(
                collection => 
                collection.Add(cookie)
            );
            return this;
        }

        public HttpCookiesCollectionBuilder WithCookies(HttpCookieCollection cookieCollection)
        {
            for (var index = 0; index < cookieCollection.Count; index++)
            {
                WithCookie(cookieCollection[index]);
            }

            return this;
        }

        public HttpCookiesCollectionBuilder WithCookie(string name, string value)
        {
            WithModifier(
                collection =>
                collection.Add(new HttpCookie(name, value))
            );
            return this;
        }
    }
}