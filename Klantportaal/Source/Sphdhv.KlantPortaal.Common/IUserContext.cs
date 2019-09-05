using System;

namespace Sphdhv.KlantPortaal.Common
{
    public interface IUserContext
    {
        string DossierNummer { get; set; }
        string Bsn { get; set; }
        string Ip { get; set; }
    }

    public interface ILogIdentities
    {
        Guid? LogRequestId { get; set; }
        Guid? LogSessionId { get; set; }
    }

    public interface IWebRequest
    {
        Uri CurrentUrl { get;  }
    }
}