using Icatt.Membership.Access.User.Contract;
using Icatt.Membership.Access.User.Contract.Contract;
using Icatt.Membership.Access.User.Contract.Interface;
using Icatt.Membership.Data.UserStore.DbContext;
using Icatt.ServiceModel;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security.DataProtection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Membership.Access.User.Service
{    
    public class UserAccessService<TContext> : ServiceBase<TContext>, IUserAccess where TContext : class, IMembershipAccessContext
    {
        private  string dataProtoctorPurpose = "PasswordReset";

        private readonly string _connectionstringOrName;


        public UserAccessService(TContext context, IFactoryContainer<TContext> env) : base(context, env)
        {
        }


        public UserAccessService(string connectionstringOrName, TContext requestContext = null, IFactoryContainer<TContext> env = null) : base(requestContext, env)
        {
            _connectionstringOrName = connectionstringOrName;
        }



        public bool VerifyUser(string userName, string password)
        {

            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionstringOrName))
            {
                var store = new UserStore<IdentityUser>(context);
                var user = store.Users.FirstOrDefault(u => u.UserName == userName);
                var mngr = new UserManager<IdentityUser>(store);

                return  mngr.CheckPassword(user, password);
            }

        }



        public void SendResetPassWordToken(string username)
        {
            var mailClient = FactoryContainer.ProxyFactory.CreateProxy<ISmtpClient>(Context);

            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionstringOrName))
            {
 

                var store = new UserStore<IdentityUser>(context);
                var mngr = new UserManager<IdentityUser>(store);

                var provider = new DpapiDataProtectionProvider(Context.ApplicationId);
 
                mngr.UserTokenProvider = new DataProtectorTokenProvider<IdentityUser>(provider.Create(dataProtoctorPurpose)) { TokenLifespan = TimeSpan.FromHours(4)  } as IUserTokenProvider<IdentityUser, string>; 
                mngr.EmailService = new SendEmailService(mailClient);
       
              var user = store.Users.FirstOrDefault(u => u.UserName == username);

                var resetToken = mngr.GeneratePasswordResetToken(user.Id);
              

                     //dit werkt niet: 
                     // mngr.SendEmailAsync(user.Id, "spdhv wachtwoord reset", $"userid = {user.Id}, token = {resetToken}");
                     //dit werkt wel, maar roept dezelfde SendAsync aan in dezelfde emailservice?!?!?!?!?!?!

                     var body = $@"<p>Je hebt voor de acceptatieomgeving van mijnpensioen een verzoek ingediend om je wachtwoord (opnieuw) in te stellen.</p>
                                        <p><a href='{Properties.Settings.Default.PasswordResetUrl}?token={resetToken}&userid={user.Id}'>Stel je wachtwoord in</a></p>
                                        <p>Deze link is 4 uur geldig. Mocht je dit verzoek niet hebben ingediend neem dan contact op met pensioenfonds@rhdhv.com.</p>
                                        <p>met vriendelijke groet,<br/>Pensioenfonds HaskoningDHV</p>";

                mngr.SendEmail<IdentityUser, string>(user.Id, "Pensioenfonds HaskoningDHV wachtwoord acceptatie instellen", body);
                

            }
        }

        

        public ResetPasswordResult ResetPassword(Contract.User user)
        {
            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionstringOrName))
            {
        
        
                var store = new UserStore<IdentityUser>(context);

                var mngr = new UserManager<IdentityUser>(store)
                {
                    PasswordValidator = new DutchPasswordValidator
                    {
                        RequiredLength = 8,
                        RequireNonLetterOrDigit = true,
                        RequireDigit = true,
                        RequireLowercase = false,
                        RequireUppercase = true,
                    }
                };
                var provider = new DpapiDataProtectionProvider(Context.ApplicationId);
                mngr.UserTokenProvider = new DataProtectorTokenProvider<IdentityUser>(provider.Create(dataProtoctorPurpose)) as IUserTokenProvider<IdentityUser, string>; ;

                IdentityResult result = mngr.ResetPassword(user.Id, user.PasswordResetToken, user.NewPassword);

                return new ResetPasswordResult() { Succes = result.Succeeded, Errors = result.Errors };
            }
        }


        private class SendEmailService : IIdentityMessageService
        {
            private ISmtpClient _mailClient;

            public SendEmailService(ISmtpClient mailClient)
            {
                this._mailClient = mailClient;
            }

            public async Task SendAsync(IdentityMessage message)
            {
                var mail = new MailMessage();

                mail.To.Add(message.Destination);
                mail.Subject = message.Subject;
                mail.IsBodyHtml = true;
                mail.Body = message.Body;
                mail.From = new MailAddress(Properties.Settings.Default.ResetPasswordFrom);
                mail.Sender = new MailAddress(Properties.Settings.Default.ResetPasswordSender);
                mail.ReplyToList.Add(new MailAddress(Properties.Settings.Default.ResetPasswordReplyTo));

                await _mailClient.SendMailAsync(mail);
            }

        }

        private class DutchPasswordValidator : PasswordValidator
        {
            public override Task<IdentityResult> ValidateAsync(string item)
            {
                if (item == null)
                {
                    throw new ArgumentNullException("item");
                }
                var errors = new List<string>();
                if (string.IsNullOrWhiteSpace(item) || item.Length < RequiredLength)
                {
                   errors.Add( $"het wachtwoord moet minimaal {RequiredLength} karakters bevatten" );
                }
                if (RequireNonLetterOrDigit && item.All(IsLetterOrDigit))
                {
                    errors.Add($"het wachtwoord moet een speciaal karakter bevatten");
                }
                if (RequireDigit && item.All(c => !IsDigit(c)))
                {
                    errors.Add($"het wachtwoord moet een cijfer bevatten");
                }
                if (RequireLowercase && item.All(c => !IsLower(c)))
                {
                    errors.Add($"het wachtwoord mag niet alleen hoofdletters bevatten");
                }
                if (RequireUppercase && item.All(c => !IsUpper(c)))
                {
                    errors.Add($"het wachtwoord moet een hoofdletter bevatten");
                }
                if (errors.Count == 0)
                {
                     return Task.FromResult(IdentityResult.Success);
                }
                return Task.FromResult(IdentityResult.Failed(String.Join(", ", errors)));
            }
        }



    }
}
