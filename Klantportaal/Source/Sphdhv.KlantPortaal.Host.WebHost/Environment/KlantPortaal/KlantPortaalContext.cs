using System;
using System.Security.Principal;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.Security.Manager.Authentication.Interface;
using Icatt.Membership.Access.User.Contract.Interface;
using Sphdhv.DeelnemerPortalApi.Interface;
using Icatt.Auditing.Access.AuditTrail.Service;

namespace Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal
{
    public class KlantPortaalContext : 
        IUserContext, IApplicationEnvironmentContext, ISessionMarkerContext,
        IAuthenticationTicket, ILogIdentities, IMembershipAccessContext, IPiramideContext, IWebRequest, IAuditContext
    {
        public KlantPortaalContext() : this(null)
        {
        }

        public KlantPortaalContext(Uri currentUrl = null) : this(null, null, currentUrl)
        {
        }

        public KlantPortaalContext(IIdentity identity, string ticket = null, Uri currentUrl = null)
        {
            var name = identity?.Name;
            if (!string.IsNullOrWhiteSpace(name))
            {
                var parts = name.Split(';');

                var commonName = parts[0];
                var nameParts = commonName.Substring("CN=".Length).Split(new[] { ' ', ',' }, StringSplitOptions.RemoveEmptyEntries); //Skip CN= at start of Certificate Subject

                if (2 <= nameParts.Length && 2 <= parts.Length)
                {
                    Thumbprint = parts[parts.Length - 1]?.Trim();

                    ApplicationId = nameParts[0]?.Trim();
                    EnvironmentId = nameParts[1]?.Trim();
                }
            }
            this.Identity = identity;
            (this as IAuthenticationTicket).AuthenticationTicket = ticket;


            CurrentUrl = currentUrl;
        }

        public IIdentity Identity { get; private set; }
        public string SecurityToken { get; set; }
        public string DossierNummer { get; set; }
        public string Bsn { get; set; }
        public string CallChain { get; set; }
        string IAuthenticationTicket.AuthenticationTicket { get; set; }
        public string ApplicationId { get; set; }
        public string EnvironmentId { get; set; }
        string ISessionMarkerContext.Marker { get; set; }
        public string Thumbprint { get; }
        Guid? ILogIdentities.LogRequestId { get; set; }
        Guid? ILogIdentities.LogSessionId { get; set; }
        public bool ImpersonateMode { get; set; }

        public Uri CurrentUrl { get; }
        public string Ip { get; set; }
        public string ApplicationName { get { return $"{ ApplicationId} {EnvironmentId}"; } } 
        public Guid? LogRequestId { get; set; }
        public Guid? LogSessionId { get; set; }
    }
}
