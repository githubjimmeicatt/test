using System;
using System.Web;
using Moq;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Web.Caching;
using Icatt.Test.Stubs;

namespace Icatt.Test.Moq.Builders
{
    /// <summary>
    /// 
    /// </summary>
    public class HttpResponseBaseMockBuilder : MockBuilder<HttpResponseBase>
    {
        private HttpCookiesCollectionBuilder _cookiesBuilder;

        public HttpResponseBaseMockBuilder()
        {
            Constructor = () =>
            {
                var mock = new Mock<HttpResponseBase>(MockBehavior);
                _cookiesBuilder = _cookiesBuilder ?? new HttpCookiesCollectionBuilder();

                mock
                    .Setup(m => m.Cookies)
                    .Returns(() => _cookiesBuilder.Build());

                return mock;
            };
        }


        public HttpResponseBaseMockBuilder WithCookies(HttpCookieCollection cookieCollection)
        {
            var builder = UseCookiesCollectionBuilder();
            for (var index = 0; index < cookieCollection.Count; index++)
            {
                builder.WithCookie(cookieCollection[index]);
            }

            return this;
        }

        public HttpCookiesCollectionBuilder UseCookiesCollectionBuilder()
        {
            _cookiesBuilder = new HttpCookiesCollectionBuilder();
            return _cookiesBuilder;
        }


        /// <summary>
        /// Records all assignments to the Response.Status property and sets the Status getter to return the last assigne status
        /// </summary>
        public HttpResponseBaseMockBuilder WithSetStatusRecorder(out IList<string> setStatusRecordings)
        {
            var localRecordings = new List<string>();

            setStatusRecordings = localRecordings;

            WithMockModifier(m => {

                m
                .SetupSet(resp => resp.Status = It.IsAny<string>())
                .Callback((string status) => { localRecordings.Add(status); });

                m
                .SetupGet(r => r.Status)
                .Returns(localRecordings.Count == 0 ? null : localRecordings[localRecordings.Count - 1]);
            });

            return this;
        }

        /// <summary>
        /// Records all assignments to the Response.Status property and sets the Status getter to return the last assigne status
        /// </summary>
        public HttpResponseBaseMockBuilder WithSetStatusCodeRecorder(out IList<int> setStatusCodeRecordings)
        {
            var localRecordings = new List<int>();

            setStatusCodeRecordings = localRecordings;

            WithMockModifier(m => {

                m
                .SetupSet(r => r.StatusCode = It.IsAny<int>())
                .Callback((int statusCode) => { localRecordings.Add(statusCode); });
            });

            return this;
        }

        /// <summary>
        /// Sets up the Response mock to write alle Response.Write input to <paramref name="writeRecordings"/>
        /// </summary>
       public HttpResponseBaseMockBuilder WithWriteRecording(out StringBuilder writeRecordings)
        {
            var recorder = new StringBuilder();

            writeRecordings = recorder;

            WithMockModifier(m => {
                m.Setup(resp => resp.Write(It.IsAny<string>()))
                .Callback((string s) => recorder.Append(s));

                m.Setup(resp => resp.Write(It.IsAny<char>()))
                .Callback((char s) => recorder.Append(s));

                m.Setup(resp => resp.Write(It.IsAny<char[]>(),It.IsAny<int>(),It.IsAny<int>()))
                .Callback((char[] buffer,int index, int count) => recorder.Append(buffer, index, count));

                m.Setup(resp => resp.Write(It.IsAny<object>()))
                .Callback((object s) => recorder.Append(s));
            });

            return this;
            
        }

        public HttpResponseBaseMockBuilder WithEndCounter(out int nrOfEndCalls)
        {
            var localCounter = 0;

            nrOfEndCalls = localCounter;

            WithMockModifier(m => {
                m.Setup(resp => resp.End())
                .Callback(() => { localCounter++; } );
            });

            return this;
        }

        public HttpResponseBaseMockBuilder WithHeaders(NameValueCollection headers)
        {
            WithMockModifier(
                m => m.Setup(
                    r => r.Headers
                ).Returns(headers)
            );

            WithMockModifier(
                m => m.Setup(
                    r => r.AppendHeader(It.IsAny<string>(), It.IsAny<string>())
                ).Callback<string,string>(headers.Add)
            );



            return this;
        }

        public HttpResponseBaseMockBuilder WithHeaders()
        {
            return WithHeaders(new NameValueCollection());
        }

        public HttpResponseBaseMockBuilder WithNullCache()
        {
            WithMockModifier(
                m => m.Setup(
                    r => r.Cache
                ).Returns(new NullHttpCachePolicy())
            );
            return this;
        }
    }
}

