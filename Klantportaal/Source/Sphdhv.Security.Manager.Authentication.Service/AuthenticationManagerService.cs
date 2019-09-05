using System;
using System.Web.Security;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.TerminatedSession.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Manager.Session.Contract.Interface;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.DeelnemerPortalApi.Interface;

namespace Sphdhv.Security.Manager.Authentication.Service
{
    public class AuthenticationManagerService<TContext> : ServiceBase<TContext>, Interface.IAuthenticationManager
        where TContext : class, IAuthenticationTicket, IUserContext, ISessionMarkerContext, IPiramideContext
    {
        public AuthenticationManagerService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        bool IAuthenticationManager.AuthenticateUser()
        {
            if (string.IsNullOrEmpty(Context.AuthenticationTicket)) return false;


            try
            {
                var aa = FormsAuthentication.Decrypt(Context.AuthenticationTicket);
            }
            catch (Exception e)
            {

            }
            var ticket = FormsAuthentication.Decrypt(Context.AuthenticationTicket);

            if (ticket == null) return false;

            if (ticket.Expired) return false;

            var userData = ticket.UserData;

            if (string.IsNullOrWhiteSpace(userData)) return false;

            var claims = userData.Split('|'); // Expecting roles to be in format "bsn|dossier"
            if (claims.Length <= 1) return false;

            var bsnClaim = claims[0];
            var dossierClaim = claims[1];
            if (
                string.IsNullOrWhiteSpace(bsnClaim)
                ||
                string.IsNullOrWhiteSpace(dossierClaim)
            )
            {
                return false;
            }

            if(claims.Length >= 4 && claims[3] == "impersonate")
            {
                Context.ImpersonateMode = true;
            }

            using (var provider1 = new System.Security.Cryptography.SHA512Managed())
            {
                (Context as ISessionMarkerContext).Marker = Convert.ToBase64String(provider1.ComputeHash(System.Text.Encoding.UTF8.GetBytes(dossierClaim)));
            }

            var proxy = FactoryContainer.ProxyFactory.CreateProxy<ISessionManager>(Context);
            if (!proxy.IsActiveSession()) return false;
            Context.DossierNummer = dossierClaim;
            Context.Bsn = bsnClaim;
            return true;
        }
    }
}
