using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using Moq;

namespace Icatt.Test.Moq.Builders
{
    /// <summary>
    /// Concept.. not ready for use
    /// </summary>
    public class HttpRequestBaseMockBuilder : MockBuilder<HttpRequestBase>
    {

        private HttpCookiesCollectionBuilder _cookiesBuilder;
        private HttpFileCollectionBaseMockBuilder _fileCollection;

        public HttpRequestBaseMockBuilder()
        {
            Constructor = () =>
            {
                var mock = new Mock<HttpRequestBase>(MockBehavior);
                _cookiesBuilder = _cookiesBuilder ?? new HttpCookiesCollectionBuilder();
                
                mock
                    .Setup(m => m.Cookies)
                    .Returns(()=> _cookiesBuilder.Build());

                return mock;
            };
        }

        public HttpRequestBaseMockBuilder WithPhysicalApplicationPath(string physicalPath)
        {
            WithMockModifier(m =>
            {
                m
                    .Setup(r => r.PhysicalApplicationPath)
                    .Returns(physicalPath);

            });

            return this;
        }

        public HttpRequestBaseMockBuilder WithFiles(IEnumerable<HttpPostedFileBaseStub> files )
        {
            _fileCollection = new HttpFileCollectionBaseMockBuilder();
            _fileCollection
                .WithFiles(files);

            WithMockModifier(m =>
            {
                m
                    .Setup(r => r.Files)
                    .Returns(() => _fileCollection.Build().Object);
            });

            return this;
        }
       
        public HttpCookiesCollectionBuilder UseCookiesCollection()
        {
            _cookiesBuilder = new HttpCookiesCollectionBuilder();
            return _cookiesBuilder;
        }

        public HttpRequestBaseMockBuilder WithUrl(Uri uri = null)
        {
            uri = uri ?? new Uri("http://some.random.url");

            WithMockModifier(m =>
            {
                m
                    .Setup(r => r.Url)
                    .Returns(uri);

                m
                    .Setup(r => r.QueryString)
                    .Returns(HttpUtility.ParseQueryString(uri.Query));
            });

            return this;
        }

        public HttpRequestBaseMockBuilder WithQuerystring(NameValueCollection querystring)
        {
            WithMockModifier(m => m
                .Setup(r => r.QueryString)
                .Returns(querystring));
            return this;
        }

        public RequestContextBuilder UseRequestContextBuilder()
        {
            var requestContextBuilder = new RequestContextBuilder();
            
            WithMockModifier(m => m.Setup(s => s.RequestContext).Returns(() => requestContextBuilder.Build()));

            return requestContextBuilder;
        }

        public HttpRequestBaseMockBuilder WithHeaders(NameValueCollection headers)
        {
            WithMockModifier(
                m=>m.Setup(
                    r=>r.Headers
                ).Returns(headers)
            );
            return this;
        }

        public HttpRequestBaseMockBuilder WithHeaders()
        {
            return WithHeaders(new NameValueCollection());
        }

        #region Obsolete Members

        [Obsolete("Use UseCookiesCollection and call WithCookie or WithCookies")]
        public HttpRequestBaseMockBuilder WithCookies(HttpCookieCollection cookieCollection)
        {
            var builder = UseCookiesCollectionBuilder();
            for (var index = 0; index < cookieCollection.Count; index++)
            {
                builder.WithCookie(cookieCollection[index]);
            }

            return this;
        }

        [Obsolete("Use UseCookiesCollection")]
        public HttpCookiesCollectionBuilder UseCookiesCollectionBuilder()
        {
            return UseCookiesCollection();
        }

        #endregion

    }

    internal class HttpFileCollectionBaseMockBuilder: MockBuilder<HttpFileCollectionBase>
    {
        private List<HttpPostedFileBaseStub> _postedFile;

        public HttpFileCollectionBaseMockBuilder()
        {
            Constructor = () =>
            {
                var mock = new Mock<HttpFileCollectionBase>();

                mock.Setup(m => m[It.IsAny<int>()])
                    .Returns((int i) => _postedFile[i] );

                mock.Setup(m => m.Count)
                    .Returns(_postedFile == null ? 0 : _postedFile.Count);

                return mock;
            };
        }

        public HttpFileCollectionBaseMockBuilder WithFiles(IEnumerable<HttpPostedFileBaseStub> files)
        {
            _postedFile = new List<HttpPostedFileBaseStub>(files);

            return this;
        }

    }


    public class HttpPostedFileBaseStub : HttpPostedFileBase
    {
        private int _length;
        private Stream _stream;
        private string _contentType;
        private string _fileName;

        public HttpPostedFileBaseStub(int length, Stream stream, string contentType, string fileName)
        {
            _length = length;
            _stream = stream;
            _contentType = contentType;
            _fileName = fileName;
        }

        public override int ContentLength { get { return _length; } }
        public override string ContentType { get { return _contentType; } }
        public override string FileName { get { return _fileName; } }
        public override Stream InputStream { get { return _stream; } }
    }

}