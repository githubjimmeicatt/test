using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Reflection;
using System.Security.Principal;
using System.Web;
using Icatt.Test.Moq;
using System.Web.WebSockets;
using Moq;

namespace Icatt.Test.Moq
{

   


  

    public static class MoqHelper
    {
        public static Mock<HttpContextBase> CreateHttpContextMock(
            IDictionary itemStore = null,
            IEnumerable<string> supportedSessionKeys = null,
            SessionItemCollection sessionStore = null,
            NameValueCollection queryParams = null,
            NameValueCollection formParams = null,
            MockBehavior behaviour = MockBehavior.Default,
            Uri uri = null,
            IPrincipal user = null)
        {
            Mock<HttpRequestBase> requestMock = null;
             Mock<HttpResponseBase> responseMock= null;
             Mock<HttpSessionStateBase> sessionMock = null;

            return CreateHttpContextMock(
                ref requestMock,
                ref responseMock,
                ref sessionMock,
                itemStore,
                supportedSessionKeys,
                sessionStore,
                queryParams,
                formParams,
                behaviour,
                uri,
                user);

        }


        /// <summary>
        /// Helper for creating a hydrated HttpContextBase Mock.
        /// </summary>
        /// <param name="requestMock"></param>
        /// <param name="sessionMock"></param>
        /// <param name="itemStore">IDictionary to hold any items in the HttpContext.Items collection</param>
        /// <param name="supportedSessionKeys">MUST contain all keys used with the Session object in the current test, otherwhise the mock object does not execute the callback mapped for the indexer setter</param>
        /// <param name="sessionStore">Object to holde the items stored in session</param>
        /// <param name="queryParams">Ignored when <paramref name="uri"/> is passed. NameValueCollection containing the querystring paramters for the request. If null an empty collection is created</param>
        /// <param name="formParams">NameValueCollection containing the form paramters for the request</param>
        /// <param name="behaviour">Optional paramter. Default value is 'MockBehavior.Strict'  If Strict, mock throws when a member is accessed that is not explicitly mapped.</param>
        /// <param name="uri">If passed, any queryParams passed are ignored</param>
        /// <param name="user"></param>
        /// <param name="responseMock"></param>
        /// <returns></returns>
        public static Mock<HttpContextBase> CreateHttpContextMock(
            ref Mock<HttpRequestBase> requestMock ,
            ref Mock<HttpResponseBase> responseMock,
            ref Mock<HttpSessionStateBase> sessionMock,
            IDictionary itemStore = null,
            IEnumerable<string> supportedSessionKeys = null,
            SessionItemCollection sessionStore = null,
            NameValueCollection queryParams = null,
            NameValueCollection formParams = null,
            MockBehavior behaviour = MockBehavior.Default,
            Uri uri = null,
            IPrincipal user = null)
        {
            var mock = new Mock<HttpContextBase>(behaviour);

            itemStore = itemStore ?? new Dictionary<string, object>();
            user = user ?? new GenericPrincipal(new GenericIdentity(""), new string[] {});
            var userStore = new UserStore()
            {
                User = user
            };

            requestMock = requestMock ?? CreateHttpRequestMock(queryParams, formParams, null, uri, behaviour);
            responseMock = responseMock ?? CreateHttpResponseMock(behaviour);
            sessionMock = sessionMock ?? CreateHttpSessionStateMock(supportedSessionKeys, sessionStore, behaviour);

            mock
                .SetupGet(m => m.Request)
                .Returns(requestMock.Object);

            mock
                .SetupGet(m => m.Response)
                .Returns(responseMock.Object);

            mock
                .SetupGet(m => m.Session)
                .Returns(sessionMock.Object);

            mock
              .SetupGet(m => m.Items)
              .Returns(itemStore);

            mock
                .SetupSet(m => m.User = It.IsAny<IPrincipal>())
                .Callback<IPrincipal>(newUser => userStore.User = newUser);

            mock.SetupGet(m => m.User)
                .Returns(() => userStore.User);

            return mock;
        }

        public static HttpContextMocks CreateHttpContextMocks(
            IDictionary itemStore = null,
            IEnumerable<string> supportedSessionKeys = null,
            SessionItemCollection sessionStore = null,
            NameValueCollection queryParams = null,
            NameValueCollection formParams = null,
            MockBehavior behaviour = MockBehavior.Default,
            Uri uri = null,
            IPrincipal user = null)
        {
            Mock<HttpRequestBase> requestMock = null;
            Mock<HttpResponseBase> responseMock = null;
            Mock<HttpSessionStateBase> sessionMock = null;

            var httpContextMock = CreateHttpContextMock(
                ref requestMock,
                ref responseMock,
                ref sessionMock,
                itemStore,
                supportedSessionKeys,
                sessionStore,
                queryParams,
                formParams,
                behaviour,
                uri,
                user);

            return new HttpContextMocks
            {
                HttpContext = httpContextMock,
                HttpRequest = requestMock,
                HttpResponse = responseMock,
                Session = sessionMock,

            };
        }


        private class UserStore
        {
            private IPrincipal _user;

            public IPrincipal User
            {
                get { return _user; }
                set { _user = value; }
            }
        }


        /// <summary>
        /// Creates mock. Supports Querystring, Form, Cookies properties. Does not support indexer yet. Params only for Querystring and Form parameters
        /// </summary>
        /// <param name="requestParams">Are ignored when URI is passed</param>
        /// <param name="formParams"></param>
        /// <param name="cookies"></param>
        /// <param name="uri"></param>
        /// <param name="behaviour"></param>
        /// <returns></returns>
        public static Mock<HttpRequestBase> CreateHttpRequestMock(
            NameValueCollection requestParams = null,
            NameValueCollection formParams = null,
            HttpCookieCollection cookies = null,
            Uri uri = null,
            MockBehavior behaviour = MockBehavior.Default)
        {
            var mock = new Mock<HttpRequestBase>(behaviour);

            if (uri != null)
            {
                requestParams = HttpUtility.ParseQueryString(uri.Query);
            }

            requestParams = requestParams ?? new NameValueCollection();
            formParams = formParams ?? new NameValueCollection();
            cookies = cookies ?? new HttpCookieCollection();
            uri = uri ?? new Uri("http://dummyuri.icatt.nl");


            mock.Setup(m => m.QueryString)
                .Returns(requestParams);

            mock.Setup(m => m.Form)
                .Returns(formParams);

            mock.Setup(m => m.Params)
                .Returns(requestParams.Join(formParams));

            mock
                .Setup(m => m.Cookies)
                .Returns(cookies);

            mock
                .Setup(m => m.Url)
                .Returns(uri);

            return mock;
        }

        /// <summary>
        /// Local helper for joining to NameValueCollections
        /// </summary>
        private static NameValueCollection Join(this NameValueCollection coll1, NameValueCollection coll2)
        {
            var join = new NameValueCollection(coll1);
            join.Add(coll2);

            return join;
        }


        public static Mock<HttpResponseBase> CreateHttpResponseMock(
            MockBehavior behaviour,
            HttpCookieCollection cookies = null)
        {
            var mock = new Mock<HttpResponseBase>(behaviour);

            cookies = cookies ?? new HttpCookieCollection();

            mock
                .Setup(m => m.Cookies)
                .Returns(cookies);

            return mock;
        }

        /// <summary>
        /// Creates mock with functioning Session store. Supports indexer (set and get), Add, Remove, RemoveAll, Keys, Contents, GetEnumerator
        /// </summary>
        /// <param name="supportedSessionKeys"></param>
        /// <param name="sessionStore"></param>
        /// <param name="behaviour"></param>
        /// <returns></returns>
        /// <remarks>
        /// NB! ONLY KEYS LISTED IN <paramref name="supportedSessionKeys"/> ARE ACTUALLY STORED AND RETRIEVED. 
        /// </remarks>
        public static Mock<HttpSessionStateBase> CreateHttpSessionStateMock(
            IEnumerable<string> supportedSessionKeys,
            SessionItemCollection sessionStore,
            MockBehavior behaviour)
        {
            supportedSessionKeys = supportedSessionKeys ?? new string[] { };

            var mock = new Mock<HttpSessionStateBase>(behaviour);

            sessionStore = sessionStore ?? new SessionItemCollection();

            mock
                .Setup(m => m[It.IsAny<string>()])
                .Returns((string s) => sessionStore[s]);

            foreach (var key in supportedSessionKeys)
            {
                mock
                    .SetupSet(m => m[key] = It.IsAny<object>())
                    .Callback((string s, object value) => sessionStore[s] = value);
            }

            mock.Setup(m => m.Add(It.IsAny<string>(), It.IsAny<object>()))
                .Callback((string s, object value) => sessionStore[s] = value);

            mock.Setup(m => m.Remove(It.IsAny<string>()))
                .Callback((string s) => sessionStore.Remove(s));

            mock
                .Setup(m => m.Abandon())
                .Callback(sessionStore.Clear);

            mock
                .Setup(m => m.Clear())
                .Callback(sessionStore.Clear);

            mock.Setup(m => m.Keys)
                .Returns(sessionStore.Keys);

            mock.Setup(m => m.Contents)
                .Returns(mock.Object);

            mock.Setup(m => m.RemoveAll())
                .Callback(sessionStore.Clear);

            mock.Setup(m => m.GetEnumerator())
                .Returns(sessionStore.Keys.GetEnumerator());


            return mock;
        }


        public static Mock<HttpServerUtilityBase> CreateHttpServerUtilityMock(
            string physicalAppRoot = null,
            Func<string,string> pathMapper = null,
            string machineName = null,
            MockBehavior behaviour = MockBehavior.Default)
        {
            var mock = new Mock<HttpServerUtilityBase>(behaviour);

            var appRootAssembly = Assembly.GetEntryAssembly() ?? Assembly.GetExecutingAssembly();
            physicalAppRoot = physicalAppRoot ?? Path.GetDirectoryName( appRootAssembly.Location);

            pathMapper = pathMapper ?? ((string vp) =>
            {
                if (VirtualPathUtility.IsAppRelative(vp))
                    vp = VirtualPathUtility.ToAbsolute(vp,"/");
                vp = vp.Substring(1); //removes leading '/'
                var path = Path.Combine(physicalAppRoot, vp);
                return path.Replace(Path.AltDirectorySeparatorChar,Path.DirectorySeparatorChar);
            });

            machineName = machineName ?? "testmachine";

            mock.Setup(m => m.HtmlDecode(It.IsAny<string>()))
                .Returns<string>(HttpUtility.HtmlDecode);

            mock.Setup(m => m.HtmlEncode(It.IsAny<string>()))
                .Returns<string>(HttpUtility.HtmlEncode);

            mock.Setup(m => m.MachineName)
                .Returns(machineName);

            mock.Setup(m => m.MapPath(It.IsAny<string>()))
                .Returns(pathMapper);

            mock.Setup(m => m.UrlDecode(It.IsAny<string>()))
                .Returns<string>(HttpUtility.UrlDecode);

            mock.Setup(m => m.UrlEncode(It.IsAny<string>()))
                .Returns<string>(HttpUtility.UrlEncode);

            return mock;
        }
    }

    public class TestUserData
    {
        public string UserName { get; set; }
    }

    /// <summary>
    /// Custom collection object suitable as session store for stubbing HttpSessionStateBase
    /// </summary>
    public class SessionItemCollection : NameObjectCollectionBase
    {

        public object this[String key]
        {
            get
            {
                return BaseGet(key);
            }

            set
            {
                BaseSet(key, value);
            }
        }

        public void Remove(string key)
        {
            BaseRemove(key);
        }

        public void Clear()
        {
            BaseClear();
        }
    }

}
