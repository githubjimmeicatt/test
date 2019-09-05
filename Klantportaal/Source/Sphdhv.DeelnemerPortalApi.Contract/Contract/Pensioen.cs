using System;
using System.Runtime.Serialization;

namespace Sphdhv.DeelnemerPortalApi.Contract
{
    [DataContract]
    public class Pensioen
    {
        [DataMember]
        public DateTime? PensioenDatum { get; set; }
        [DataMember]
        public DateTime? StandDatum { get; set; }
        [DataMember]
        public DateTime? ExpiratieTopDatum { get; set; }
        [DataMember]
        public DateTime? ExpiratieTop2Datum { get; set; }
        [DataMember]
        public float? OpgebouwdOp { get; set; }
        [DataMember]
        public float? BereikbaarOp { get; set; }
        [DataMember]
        public float? IngegaanOp { get; set; }
        [DataMember]
        public float? OpgebouwdNbp { get; set; }
        [DataMember]
        public float? BereikbaarNbp { get; set; }
        [DataMember]
        public float? IngegaanNbp { get; set; }
        [DataMember]
        public float? OpgebouwdWzp { get; set; }
        [DataMember]
        public float? BereikbaarWzp { get; set; }
        [DataMember]
        public float? OpgebouwdTop { get; set; }
        [DataMember]
        public float? BereikbaarTop { get; set; }
        [DataMember]
        public float? IngegaanTop { get; set; }
        [DataMember]
        public float? OpgebouwdTop2 { get; set; }
        [DataMember]
        public float? BereikbaarTop2 { get; set; }
        [DataMember]
        public float? IngegaanTop2 { get; set; }
        [DataMember]
        public float? IngegaanAow { get; set; }
    }
}