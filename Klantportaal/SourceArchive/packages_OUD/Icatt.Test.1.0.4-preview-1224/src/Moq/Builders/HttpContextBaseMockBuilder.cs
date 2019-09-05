using System;
using System.Security.Principal;
using System.Web;
using Moq;
using System.Collections.Generic;
using System.Collections;

namespace Icatt.Test.Moq.Builders
{
    /// <summary>
    /// Concept.. not ready for use
    /// </summary>
    public class HttpContextBaseMockBuilder : MockBuilder<HttpContextBase>
    {
        private HttpRequestBaseMockBuilder _requestBuilder;
        private HttpResponseBaseMockBuilder _responseBuilder;
        private HttpSessionStateBaseMockBuilder _sessionBuilder;
        private HttpServerUtilityBaseMockBuilder _serverBuilder;

        public HttpContextBaseMockBuilder()
        {

            Modifiers.Add(m => m
                .Setup(c => c.User)
                .Returns((IPrincipal)null));
            
          
        }

        public HttpContextBaseMockBuilder WithDefaultPriciple()
        {

            Modifiers.Add(m => m
                .Setup(c => c.User)
                .Returns(new GenericPrincipal(new GenericIdentity("DummyUserName"),new string[] {})));

            return this;
        }

        public HttpContextBaseMockBuilder WithPriciple(IPrincipal principal)
        {

            Modifiers.Add(m => m
                .Setup(c => c.User)
                .Returns(principal));

            return this;
        }

        public HttpRequestBaseMockBuilder UseHttpRequest()
        {
            _requestBuilder = new HttpRequestBaseMockBuilder();


            WithMockModifier(m =>
            {
                m.Setup(context => context.Request)
                    .Returns(_requestBuilder.Build().Object);
            });

            return _requestBuilder;
        }

        public HttpContextBaseMockBuilder FromHttpContextMock(Mock<HttpContextBase> httpContextMock)
        {
            Constructor = () => httpContextMock;

            return this;
        }

        public HttpResponseBaseMockBuilder UseResponseBuilder()
        {
            _responseBuilder = new HttpResponseBaseMockBuilder();

            Modifiers.Add(mock => mock.Setup(s => s.Response).Returns(_responseBuilder.Build().Object));

            return _responseBuilder;
        }

        public HttpServerUtilityBaseMockBuilder UseServerUtility()
        {
            _serverBuilder = new HttpServerUtilityBaseMockBuilder();

            return _serverBuilder;
        }

        public HttpSessionStateBaseMockBuilder UseSessionState()
        {
            _sessionBuilder = new HttpSessionStateBaseMockBuilder();

            Modifiers.Add(mock =>
            {
                mock.Setup(
                    c => c.Session
                    ).Returns( _sessionBuilder.Build().Object);
            });
            
            return _sessionBuilder;
        }

        public HttpContextBaseMockBuilder WithRewritePathRecorder(out IList<RewritePathWith3ArgsRecording> rewritePathRecordings)
        {

            rewritePathRecordings = new List<RewritePathWith3ArgsRecording>();

            var recordings = rewritePathRecordings;

            WithMockModifier(m => {
                m
                    .Setup(c => c.RewritePath(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>()))
                    .Callback((string filePath, string pathInfo, string queryString) => recordings.Add(new RewritePathWith3ArgsRecording(filePath, pathInfo, queryString)));
            });

            return this;
        }

        public HttpContextBaseMockBuilder WithRewritePathRecorder(out IList<RewritePathWith2ArgsRecording> rewritePathRecordings)
        {

            rewritePathRecordings = new List<RewritePathWith2ArgsRecording>();

            var recordings = rewritePathRecordings;

            WithMockModifier(m => {
                m
                    .Setup(c => c.RewritePath(It.IsAny<string>(), It.IsAny<bool>()))
                    .Callback((string path, bool rebaseClient) => recordings.Add(new RewritePathWith2ArgsRecording(path, rebaseClient)));
            });

            return this;
        }

        public HttpContextBaseMockBuilder WithItemStore(out Hashtable itemStore)
        {
            var localStore = new Hashtable();

            itemStore = localStore;

            WithMockModifier(m =>
            {
                m
                .Setup(c => c.Items)
                .Returns(localStore);
            });

            return this;
        }

        public HttpContextBaseMockBuilder WithItems(IDictionary items)
        {
            WithMockModifier(m =>
            {
                m
                .Setup(c => c.Items)
                .Returns(items);
            });

            return this;
        }

        public HttpContextBaseMockBuilder WithItems()
        {
            return WithItems(new Dictionary<object, object>());
        }

        public HttpResponseBaseMockBuilder UseHttpResponse()
        {
            _responseBuilder = new HttpResponseBaseMockBuilder();

            WithMockModifier(m => {
                m.Setup(c => c.Response).Returns(_responseBuilder.Build().Object);
            });

            return _responseBuilder;
        }

        public HttpContextBaseMockBuilder WithRewritePathRecorder(out IList<string> rewritePathRecordings)
        {

            rewritePathRecordings = new List<string>();

            var recordings = rewritePathRecordings;

            WithMockModifier(m => {
                m
                    .Setup(c => c.RewritePath(It.IsAny<string>()))
                    .Callback((string path) => recordings.Add(path));
            });

            return this;
        }

        public class RewritePathWith3ArgsRecording
        {
            public RewritePathWith3ArgsRecording(string filePath, string pathInfo, string queryString)
            {
                FilePath = filePath;
                PathInfo = pathInfo;
                QueryString = queryString;
            }

            public string FilePath { get; private set; }
            public string PathInfo { get; private set; }
            public string QueryString { get; private set; }
        }

        public class RewritePathWith2ArgsRecording
        {
            public string Path { get; private set; }
            public bool RebaseClientPath { get; private set; }

            public RewritePathWith2ArgsRecording(string path, bool rebaseClientPath)
            {
                Path = path;
                RebaseClientPath = rebaseClientPath;
            }

        }

        #region Obsolte Members

        [Obsolete("Use UseServerUtility")]
        public HttpServerUtilityBaseMockBuilder WithServerUtility()
        {
            return UseServerUtility();
        }

        [Obsolete("Use UseSessionState")]
        public HttpSessionStateBaseMockBuilder WithSessionState()
        {
            return UseSessionState();
        }

        [Obsolete("Use UseResponseBuilder")]
        public HttpResponseBaseMockBuilder WithResponseBuilder()
        {
            return UseHttpResponse();
        }

        [Obsolete("Use UseHttpRequest")]
        public HttpRequestBaseMockBuilder UseHttpRequestBuilder()
        {
            _requestBuilder = new HttpRequestBaseMockBuilder();


            WithMockModifier(m =>
            {
                m.Setup(context => context.Request)
                    .Returns(_requestBuilder.Build().Object);
            });

            return _requestBuilder;
        }

        [Obsolete("Use UseHttpRequest")]
        public HttpRequestBaseMockBuilder WithHttpRequest()
        {
            return UseHttpRequest();
        }

        #endregion
    }
}