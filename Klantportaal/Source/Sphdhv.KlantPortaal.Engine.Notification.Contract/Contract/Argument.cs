using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Engine.Notification.Contract
{
    [DataContract]
    public class Argument
    {
        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public string Type { get; set; }

        [DataMember]
        public string XmlSerialized { get; set; }
    }
}
