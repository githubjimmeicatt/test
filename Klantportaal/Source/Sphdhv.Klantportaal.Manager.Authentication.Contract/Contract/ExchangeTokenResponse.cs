using Icatt.OAuth.Contract;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Manager.Authentication.Contract
{
    [DataContract]
    public class ExchangeTokenResponse
    {
        [DataMember]
        public Claim[] Claims { get; set; }
        [DataMember]
        public StatusCode Status { get; set; }
    }

    [DataContract]
    public enum StatusCode
    {
        [EnumMember]
        Success = 0,
        [EnumMember]
        CancelledByUser = 1,
        [EnumMember]
        ServiceFailure = 2,
        [EnumMember]
        UnknownDossier = 3,
    }
}
