using System;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract
{
    public class Item
    {
        public string Id { get; set; }
        public string Titel { get; set; }
        public string Type { get; set; }
        public string Categorie { get; set; }
        public int Paginas { get; set; }
        public string Dossier { get; set; }
        public string MutatieDatum { get; set; }
        public DateTime AanmaakDatum { get; set; }
    }
}
