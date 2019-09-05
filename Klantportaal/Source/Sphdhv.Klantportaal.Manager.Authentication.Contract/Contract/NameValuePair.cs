using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Manager.Authentication.Contract
{
    [DataContract]
    public class NameValuePair
    {
        [DataMember]
        public string Name { get; set; }
        public string Value { get; set; }
    }
}