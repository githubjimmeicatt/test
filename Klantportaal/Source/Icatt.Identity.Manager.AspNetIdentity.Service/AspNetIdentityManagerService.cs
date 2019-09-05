using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract;
using Icatt.Membership.Access.User.Contract;

using Icatt.OAuth.Contract;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using System;
using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
using System.Collections.Generic;
using Sphdhv.KlantPortaal.Access.Pensioen.Interface;
using Icatt.Identity.Manager.AspNetIdentity.Contract.Contract;
using System.Threading.Tasks;
using Sphdhv.DeelnemerPortalApi.Interface;

namespace Sphdhv.KlantPortaal.Manager.AspNetIdentity.Service
{
    public class AspNetIdentityManagerService<TContext> : ServiceBase<TContext>, IAspNetIdentityManager where TContext : class, IApplicationEnvironmentContext, IPiramideContext
    {

        public AspNetIdentityManagerService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public Claim[] ExchangeToken(string authToken, string relayState)
        {

            var tokenPair = authToken.Split(new[] { "." }, StringSplitOptions.None);

            if (tokenPair.Length == 2)
            {
                var tokenAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IAuthTokenAccess>(Context);
                var claims = tokenAccessProxy.RedeemToken(tokenPair[0], tokenPair[1]);
                return claims;
            }

            return null;

        }

        public async Task<LoginResult> Login(string username, string password)
        {



            var accessProxy = FactoryContainer.ProxyFactory.CreateProxy<IUserAccess>(Context);
            var isValidUser = accessProxy.VerifyUser(username, password);

            if (!isValidUser)
            {
                return new LoginResult() { Token = null, DossierNrValid = false };
            }

            TokenEntry token = null;



            Context.ImpersonateMode = true;

            var pensioenAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IPensioenAccess>(Context);
            var isValidDossierNr =  pensioenAccessProxy.VerifyDossierNr();

            var claims = new[] {
                    new Claim
                        {
                            OriginalIssuer = "SPHDHV",
                            Issuer = "SPHDHV",
                            Type = "pensioenfondshakoningdhv.nl/username",
                            Value = username,
                            ValueType = "string"
                        }
                };

            var tokenAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IAuthTokenAccess>(Context);

            token = tokenAccessProxy.IssueToken(claims, TimeSpan.FromSeconds(30));



            return new LoginResult() { Token = token, DossierNrValid = await isValidDossierNr };
        }

        public ResetPasswordResult ResetPassword(ResetPassword resetPassword)
        {
            if (resetPassword.NewPassword != resetPassword.NewPasswordConfirm)
            {
                return new ResetPasswordResult() { Succes = false, Errors = new List<string>() { "De wachtwoorden zijn  niet gelijk" } };
            }

            var accessProxy = FactoryContainer.ProxyFactory.CreateProxy<IUserAccess>(Context);
            var resetPasswordResult = accessProxy.ResetPassword(new User() { PasswordResetToken = resetPassword.Token, Id = resetPassword.UserId, NewPassword = resetPassword.NewPassword });

            return new ResetPasswordResult() { Succes = resetPasswordResult.Succes, Errors = resetPasswordResult.Errors };
        }

        public void SendPasswordResetToken(string username)
        {
            var accessProxy = FactoryContainer.ProxyFactory.CreateProxy<IUserAccess>(Context);
            accessProxy.SendResetPassWordToken(username);

        }


    }
}
