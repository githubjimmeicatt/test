using System.Web;
using Moq;

namespace Icatt.Test.Moq.Builders
{
    /// <summary>
    /// HttpSessionStateBase mock builder
    /// </summary>
    public class HttpSessionStateBaseMockBuilder : MockBuilder<HttpSessionStateBase>
    {


        public HttpSessionStateBaseMockBuilder()
        {
            Constructor = () =>
            {
                var mock = new Mock<HttpSessionStateBase>(MockBehavior);
                return mock;
            };
        }



        /// <summary>
        /// Accept eny set and get on the session. Gets always return empty
        /// </summary>
        public HttpSessionStateBaseMockBuilder WithEmptyGetter()
        {
            Modifiers.Add(mock =>
            {
                mock.Setup(
                    m => m[It.IsAny<int>()]
                    ).Returns(string.Empty);
                mock.Setup(
                    m => m[It.IsAny<string>()]
                    ).Returns(string.Empty);
            });
            return this;
        }

        public HttpSessionStateBaseMockBuilder WithSessionValue(string key, object value)
        {
            WithMockModifier(m => m
                .Setup(s => s[key])
                .Returns(value));

            return this;
        }




        public HttpSessionStateBaseMockBuilder WithSessionItemRemove()
        {
            WithMockModifier(m => m
              .Setup(s => s.Remove(It.IsAny<string>())));
            return this;
        }
    }
}