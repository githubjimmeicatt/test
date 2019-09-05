using System;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models
{
    [Serializable]
    [DataContract]
    public class ErrorResponse
    {
        [DataMember]
        public string Message { get; set; }
    }
}
