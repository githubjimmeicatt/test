using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
public class Adressen
    {
        [DataMember]
public string CrmId { get; set; }
        [DataMember]
public int Huisnummer { get; set; }
        [DataMember]
public string HuisnummerToevoeging { get; set; }
        [DataMember]
public string HuisnummerSamengesteld { get; set; }
        [DataMember]
public string Land { get; set; }
        [DataMember]
public string Land2 { get; set; }
        [DataMember]
public string Plaats { get; set; }
        [DataMember]
public string Postcode { get; set; }
        [DataMember]
public string Straat { get; set; }
        [DataMember]
public string Straat2 { get; set; }
        [DataMember]
public string TypeAdres { get; set; }
    }

}
