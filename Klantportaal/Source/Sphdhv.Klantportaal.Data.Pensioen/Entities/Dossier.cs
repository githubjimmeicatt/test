using Icatt.Data.Entity;
using System;

namespace Sphdhv.Klantportaal.Data.Pensioen.Entities
{
    public class Dossier : IObjectWithState
    {
        public string Nummer { get; set; }
        public bool Blocked { get; set; }
        public DateTime CreatedAtUtc { get; set; }
        public DateTime ModifiedAtUtc { get; set; }
        public ObjectState State { get; set; }
    }
}
