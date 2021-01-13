using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract
{
    [DataContract]
    public class ResetPasswordResult
    {
        [DataMember]
        public bool Succes { get; set; }

        [DataMember]
        public IEnumerable<string> Errors { get; set; }

    }
}
