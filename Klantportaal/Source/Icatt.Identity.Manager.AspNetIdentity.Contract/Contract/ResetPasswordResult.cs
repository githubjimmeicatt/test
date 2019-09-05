using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
