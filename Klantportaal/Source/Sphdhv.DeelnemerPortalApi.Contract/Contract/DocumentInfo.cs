using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
    public class DocumentInfo
    {
        [DataMember]
        public string AanmaakDatum { get; set; }
        [DataMember]
        public string Categorie { get; set; }
        [DataMember]
        public int? CategorieId { get; set; }
        [DataMember]
        public string DocumentId { get; set; }
        [DataMember]
        public string DocumentNaam { get; set; }
        [DataMember]
        public string DossierGuid { get; set; }
        [DataMember]
        public int? DossierId { get; set; }
        [DataMember]
        public string MutatieDatum { get; set; }
        [DataMember]
        public int? Paginas { get; set; }
        [DataMember]
        public string Type { get; set; }
        [DataMember]
        public int? TypeId { get; set; }
    }
}
