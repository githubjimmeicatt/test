using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Engine.Notification.Contract
{
    [DataContract]
    public class EventType
    {
        /// <summary>
        /// The fullname of the
        /// </summary>
        [DataMember]
        public string SourceType { get; set; }

        [DataMember]
        public string OperationName { get; set; }

    }
}
