using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sphdhv.KlantPortaal.Host.WebHost.Environment
{
    public enum ApplicationArea
    {
        AuthTokenAccess,
        CorresponsentieAccess,
        DeelnemerAccess,
        PensioenAccess,
        TerminatedSessionAccess,
        ClaimsEngine,
        NotificationEngine,
        PensioenEngine,
        PensioenManager,
        IdentityManager,
        SessionManager,
        AuthenticationManager,
        Any,
        SecureTokenManager
    }

}