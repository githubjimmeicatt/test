using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Access.Correspondentie.Contract
{

    [DataContract]
    public class CorrespondentieOverzicht
    {
        public List<Item> Items { get; set; }
    }
}
