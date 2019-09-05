using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.OAuth.Contract;

namespace Sphdhv.KlantPortaal.Engine.Claims.Contract
{
    public class ExchangeTokenResponse
    {
        public Claim[] Claims { get; set; }
        public StatusCode Status { get; set; }

    }

    public enum StatusCode
    {
        Success = 0,
        CancelledByUser  = 1,
        ServiceFailure = 2,
        UnknownDossier = 3,
    }
}
