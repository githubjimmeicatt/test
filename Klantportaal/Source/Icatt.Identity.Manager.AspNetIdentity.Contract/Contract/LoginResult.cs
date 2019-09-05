using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Identity.Manager.AspNetIdentity.Contract.Contract
{
    [DataContract]
    public class LoginResult
    {
        [DataMember]
        public TokenEntry Token { get; set; }

        [DataMember]
        public bool DossierNrValid { get; set; }
    }
}
