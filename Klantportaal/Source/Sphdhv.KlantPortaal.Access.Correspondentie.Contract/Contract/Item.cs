using System;
using System.Runtime.Serialization;

namespace Sphdhv.KlantPortaal.Access.Correspondentie.Contract
{
    [DataContract]
    public class Item
    {
        public string Id { get; set; }
        public string Titel { get; set; }
        public string Type { get; set; }
        public string Categorie { get; set; }
        public int Paginas { get; set; }
        public string Dossier { get; set; }
        public DateTime? MutatieDatum { get; set; }
        public DateTime? AanmaakDatum { get; set; }
    }
}
