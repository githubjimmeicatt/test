using System.Linq.Expressions;
using System.Security.Cryptography.X509Certificates;
using Icatt.Test.Stubbing;
using System.Web;
using static Icatt.Test.Stubs.HttpResponseBaseStub;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Principal;
using System.Web.Caching;

namespace Icatt.Test.Stubs
{
    public class HttpContextBaseStub : HttpContextBase
    {
        public readonly StubManager<DataCollection> StubManager = new StubManager<DataCollection>();

        public override HttpRequestBase Request { get; } = new HttpRequestBaseStub();
        public override HttpResponseBase Response { get; } = new HttpResponseBaseStub();
        public override HttpSessionStateBase Session { get; } = new HttpSessionStaateBaseStub();
        public override IDictionary Items
        {
            get { return StubManager.DataCollection.Items; }
        }

        public override HttpServerUtilityBase Server { get; } = new HttpServerUtilityBaseStub();

        public override IPrincipal User
        {
            get { return StubManager.DataCollection.User; }
            // ReSharper disable once PossibleAssignmentToReadonlyField
            set { StubManager.DataCollection.User = value; }
        } 

        public class DataCollection
        {
            public IDictionary Items { get; set; } = new Dictionary<object,object>();
            public  IPrincipal User { get; set; }
        }
    }

    public class HttpServerUtilityBaseStub : HttpServerUtilityBase
    {
        public StubManager<DataCollection> StubManager { get; } = new StubManager<DataCollection>();

        public class DataCollection
        {

        }
    }
    public class HttpSessionStaateBaseStub : HttpSessionStateBase
    {
        public StubManager<DataCollection> StubManager { get; } = new StubManager<DataCollection>();

        public class DataCollection
        {

        }
    }
    public class HttpRequestBaseStub : HttpRequestBase
    {
        public StubManager<DataCollection> StubManager { get; } = new StubManager<DataCollection>();

        public override HttpBrowserCapabilitiesBase Browser { get; } = new HttpBrowserCapabilitiesBaseStub();

        public override HttpCookieCollection Cookies
        {
            get { return StubManager.DataCollection.Cookies; }
        }

        public override HttpFileCollectionBase Files { get; } = new HttpFileCollectionBaseStub();

        public class DataCollection
        {
            public HttpCookieCollection Cookies { get; set; } = new HttpCookieCollection();
        }
    }
    public class HttpFileCollectionBaseStub : HttpFileCollectionBase
    {
        public StubManager<DataCollection> StubManager { get; } = new StubManager<DataCollection>();

        public class DataCollection
        {

        }

    }
    public class HttpBrowserCapabilitiesBaseStub : HttpBrowserCapabilitiesBase
    {
        public StubManager<DataCollection> StubManager { get; } = new StubManager<DataCollection>();

        public class DataCollection
        {

        }
    }
    public class HttpResponseBaseStub : HttpResponseBase
    {
        public StubManager<DataCollection> StubManager { get; } = new StubManager<DataCollection>();

        public class DataCollection
        {

        }
    }


    
  

}
