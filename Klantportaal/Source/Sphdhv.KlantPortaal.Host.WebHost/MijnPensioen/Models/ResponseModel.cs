using System;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models
{
    [Serializable]
    [DataContract]
    public class ResponseModel<T>
    {
        public ResponseModel(T response)
        {
            Response = response;
            StatusCode = 200;
        }

        public ResponseModel(int statusCode, string errorMessage)
        {
            StatusCode = statusCode;
            ErrorResponse = new ErrorResponse
            {
                Message = errorMessage
            };
        }

        [DataMember]
        public int StatusCode { get; }
        [DataMember]
        public T Response { get; }
        [DataMember]
        public ErrorResponse ErrorResponse { get; }
    }
}
