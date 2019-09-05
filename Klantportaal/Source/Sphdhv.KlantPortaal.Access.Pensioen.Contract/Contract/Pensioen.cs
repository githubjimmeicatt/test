using System;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Contract
{
    public class Pensioen
    {
        public DateTime? PensioenDatum { get; set; }
        public DateTime? StandDatum { get; set; }
        public DateTime? ExpiratieTopDatum { get; set; }
        public DateTime? ExpiratieTop2Datum { get; set; }
        public float? OpgebouwdOp { get; set; }
        public float? BereikbaarOp { get; set; }
        public float? IngegaanOp { get; set; }
        public float? OpgebouwdNbp { get; set; }
        public float? BereikbaarNbp { get; set; }
        public float? IngegaanNbp { get; set; }
        public float? OpgebouwdWzp { get; set; }
        public float? BereikbaarWzp { get; set; }
        public float? OpgebouwdTop { get; set; }
        public float? BereikbaarTop { get; set; }
        public float? IngegaanTop { get; set; }
        public float? OpgebouwdTop2 { get; set; }
        public float? BereikbaarTop2 { get; set; }
        public float? IngegaanTop2 { get; set; }
        public float? IngegaanAow { get; set; }
    }
}