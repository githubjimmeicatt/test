using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
public class Bereikbaarheden
    {
        [DataMember]
public string CrmId { get; set; }
        [DataMember]
public string Type { get; set; }
        [DataMember]
public string Waarde { get; set; }
    }
}