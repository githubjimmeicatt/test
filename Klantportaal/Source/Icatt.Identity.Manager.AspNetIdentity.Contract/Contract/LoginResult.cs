using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
using System.Runtime.Serialization;

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
