using System;

namespace Icatt.Security.Saml2.Saml.Contract
{
    public class SectorInfo
    {
        private readonly string _sectorCodeEnNummer;

        public string Sofi
        {
            get
            {
                var sectorInfo = _sectorCodeEnNummer.Split(':');
                return sectorInfo.Length == 2 && "S00000001".Equals(sectorInfo[0],StringComparison.OrdinalIgnoreCase) ? sectorInfo[1] : string.Empty;
            }
        }

        public string Bsn
        {
            get
            {
                var sectorInfo = _sectorCodeEnNummer.Split(':');
                return sectorInfo.Length == 2 && "S00000000".Equals(sectorInfo[0], StringComparison.OrdinalIgnoreCase) ? sectorInfo[1] : string.Empty;
            }
        }

        public string Issuer { get; set; }
        public string InResponseTo { get; set; }
        public string Id { get; set; }
        public DateTime IssuedAt { get; set; }

        public SectorInfo(string sectorCodeEnNummer)
        {
            _sectorCodeEnNummer = sectorCodeEnNummer;
        }
    }
}
