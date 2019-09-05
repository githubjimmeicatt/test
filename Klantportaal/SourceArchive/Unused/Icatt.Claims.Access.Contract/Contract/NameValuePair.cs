using System.Runtime.Serialization;

namespace Icatt.OAuth.Contract
{
    [DataContract]
    public class NameValuePair
    {
        [DataMember]
        public string Name { get; set; }
        public string Value { get; set; }
    }

}
