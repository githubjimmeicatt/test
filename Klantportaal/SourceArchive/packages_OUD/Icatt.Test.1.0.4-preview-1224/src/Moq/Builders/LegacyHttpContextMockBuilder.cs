using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Principal;
using System.Web;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace Icatt.Test.Moq.Builders
{

    /// <summary>
    /// Concept.. not ready for use
    /// </summary>
    [Obsolete("Use HttpContextBaseMockBuilder")]
    public class LegacyHttpContextMockBuilder : MockBuilder<HttpContextBase>
    {
        HttpRequestBaseMockBuilder _requestBuilder = new HttpRequestBaseMockBuilder();
        HttpResponseBaseMockBuilder _responseBuilder = new HttpResponseBaseMockBuilder();
        HttpSessionStateBaseMockBuilder _sessionBuilder = new HttpSessionStateBaseMockBuilder();
        HttpServerUtilityBaseMockBuilder _serverBuilder = new HttpServerUtilityBaseMockBuilder();


        public LegacyHttpContextMockBuilder()
        {
            Constructor = () =>
            {
                var httpContextMock = new Mock<HttpContextBase>(MockBehavior);

                var requestMock = _requestBuilder
                    .WithMockBehaviour(MockBehavior)
                    .Build();

                var responseMock = _responseBuilder
                    .WithMockBehaviour(MockBehavior)
                    .Build();

                var sessionMock = _sessionBuilder
                    .WithMockBehaviour(MockBehavior)
                    .Build();

                var serverMock = _serverBuilder
                    .WithMockBehaviour(MockBehavior)
                    .Build();


                httpContextMock
                    .Setup(m => m.Request)
                    .Returns(requestMock.Object);

                httpContextMock
                    .Setup(m => m.Response)
                    .Returns(responseMock.Object);

                httpContextMock
                    .Setup(m => m.Session)
                    .Returns(sessionMock.Object);

                httpContextMock
                 .Setup(m => m.Server)
                 .Returns(serverMock.Object);

                return httpContextMock;
            };
        }


        public LegacyHttpContextMockBuilder UseRequest(HttpRequestBaseMockBuilder requestBaseBuilder)
        {
            _requestBuilder = requestBaseBuilder;

            return this;
        }

        public LegacyHttpContextMockBuilder SetupRequest(Action<HttpRequestBaseMockBuilder> builderAction)
        {
            builderAction(_requestBuilder);

            return this;
        }

        public LegacyHttpContextMockBuilder FromHttpContext(HttpContextBase httpContext)
        {
            Constructor = () =>
            {
                var httpContextMock = new Mock<HttpContextBase>(MockBehavior);

                httpContextMock
                  .Setup(m => m.Request)
                  .Returns(httpContext.Request);

                httpContextMock
                    .Setup(m => m.Response)
                    .Returns(httpContext.Response);

                httpContextMock
                    .Setup(m => m.Session)
                    .Returns(httpContext.Session);

                httpContextMock
                    .Setup(m => m.Server)
                    .Returns(httpContext.Server);

                httpContextMock
                    .Setup(m => m.Items)
                    .Returns(httpContext.Items);

                return httpContextMock;
            };

            return this;
        }

        public LegacyHttpContextMockBuilder WithItemsCollection(IDictionary itemCollection)
        {
            Modifiers.Add((Mock<HttpContextBase> mock) =>
            {
                mock
                .Setup(m => m.Items)
                .Returns(itemCollection);
            });


            return this;
        }





    }

}
