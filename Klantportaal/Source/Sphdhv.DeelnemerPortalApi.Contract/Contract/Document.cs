using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
public class Document
    {
        [DataMember]
public string Data { get; set; }
        [DataMember]
public string Extension { get; set; }
    }
}
