using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Collections.Generic;
using Icatt.ServiceModel;
using Microsoft.AspNet.Identity;
using Icatt.Membership.Access.User.Service;
using System.Linq;
using Microsoft.Owin.Security.DataProtection;
using Microsoft.AspNet.Identity.Owin;
using Moq;
using System.Net.Mail;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Icatt.Membership.Access.User.ServiceTest
{
    [TestClass]
    public class IT_MembershipAccessServiceTest
    {
        

        private static readonly string _connectionString;

        static IT_MembershipAccessServiceTest()
        {
            //This connectionsstring is resolved to a catalog with the FullName of this test class
            //on (localdb)\mssqllocaldb if no connectionstring by that name exists
            //Thus a localdb is created whose name reflects is intended use, specific for this test class
            _connectionString = typeof(IT_MembershipAccessServiceTest).FullName;

            //NB code  used to create OTAP databases
            //_connectionString = @"Data Source=OTA-DB;Initial Catalog=HaskoningDHV.Klantportaal.DEV.AspNetMembership;User ID=HaskoningDHV.Klantportaal.DEV.AspNetMembership;Password=dsg*9hsdKJH785w3))123GbdfgdfgbnHSHDHSDFHJ345dfg345";
        }


        [ClassInitialize]
        public static  void ClassInit(TestContext testContext)
        {
            if (_connectionString != typeof(IT_MembershipAccessServiceTest).FullName)
            {
                //alleen de locale test db mag gedelete worden
                return;
            }

           if (Database.Exists(_connectionString))
                Database.Delete(_connectionString);            
        }


        //assert that a user can only login with the right password
        [TestMethod]
        public async Task IT_VerifyUserTest()
        {
            //Setup

            var userName = "IT_VerifyUserTest";
            var correctPassword = "password";
            var incorrectPassword = "ongeldigpassword";

            //seed de database emt een test user
            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionString, Data.UserStore.DbContext.IdentityDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {              
                var store = new UserStore<IdentityUser>(context);
                var mngr = new UserManager<IdentityUser>(store);

                var memberApp = new IdentityUser
                {
                    UserName = userName
                };

                var newMemberResult = await mngr.CreateAsync(memberApp);

                var user = await context.Users.SingleAsync(u => u.UserName == userName);
                Assert.AreEqual(userName, user.UserName);

                await mngr.AddPasswordAsync(user.Id, correctPassword);
            }
                        
            //Act

            var factoryContainer = new FactoryContainer<KlantPortaalContext> {   };
            var service = new UserAccessService<KlantPortaalContext>(_connectionString, new KlantPortaalContext(), factoryContainer);
            
            //Assert

            var isNotValiduser = service.VerifyUser(userName, incorrectPassword);
            Assert.IsFalse(isNotValiduser);

            var isValiduser = service.VerifyUser(userName, correctPassword);
            Assert.IsTrue(isValiduser); 
             
        }



        //Let op de ze 'test' wordt  gebruikt worden om echte users aan te maken.
        //deze user heeft geen wachtwoord. dat moet via de site ingesteld worden
        [TestMethod]
        public async Task IT_CreateTestUser()
        {

            Assert.Inconclusive("Let op de ze 'test' wordt  gebruikt worden om echte users aan te maken.");

            var userName = "sphdhv1";
            var email = "icatttest+spdhv1@gmail.com";


            var connectionString = "";

            //dev
            //connectionString = @"Data Source=OTA-DB;Initial Catalog=HaskoningDHV.Klantportaal.DEV.AspNetMembership;User ID=HaskoningDHV.Klantportaal.DEV.AspNetMembership;Password=dsg*9hsdKJH785w3))123GbdfgdfgbnHSHDHSDFHJ345dfg345";

            //accept
            //connectionString = @"Data Source=CHEETAH;Initial Catalog=HaskoningDHV.Klantportaal.ACCEPT.AspNetMembership;User ID=HaskoningDHV.Klantportaal.ACCEPT.AspNetMembership;Password=*^*VB#c6598769nmurwt9g4gfj84yuthgpds87elhs874e9j57g467UVIY%FR;MultipleActiveResultSets=True";

            //seed de database emt een test user
            using (var context = new Data.UserStore.DbContext.IdentityDbContext(connectionString, Data.UserStore.DbContext.IdentityDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {


                var store = new UserStore<IdentityUser>(context);
                var mngr = new UserManager<IdentityUser>(store);

                var memberApp = new IdentityUser
                {
                    UserName = userName,
                    Email = email
                };

                var newMemberResult = await mngr.CreateAsync(memberApp);

                var task = await context.Users.ToListAsync();
                Assert.AreEqual(1, task.Count);
                Assert.AreEqual(userName, task[0].UserName);

            }

        }


        //verstuur een wachtwoord reset link naar een user obv zijn username.
        //controleert dat de mailclient wordt aangeroepen met het juiste mailadres
        [TestMethod]
        public async Task IT_SendResetPasswordEmail()
        {
            //Setup
            var userName = "IT_SendResetPasswordEmail";
            var email = "icatttest+123@gmail.com";
            var sendToAdres = ""; 
            
            //seed de database emt een test user
            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionString, Data.UserStore.DbContext.IdentityDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {
                var store = new UserStore<IdentityUser>(context);
                var mngr = new UserManager<IdentityUser>(store);

                var memberApp = new IdentityUser
                {
                    UserName = userName,
                    Email = email
                };

                var newMemberResult = await mngr.CreateAsync(memberApp);

                var user = await context.Users.SingleAsync(u => u.UserName == userName);
                Assert.AreEqual(userName, user.UserName);

            }

            IFactoryContainer<KlantPortaalContext> containerFactory = new FactoryContainer<KlantPortaalContext>();
            

            Dictionary<Type, Func<KlantPortaalContext, object>> mocks = new Dictionary<Type, Func<KlantPortaalContext, object>>
            {
                {typeof(ISmtpClient),c => {
                    var mock = new Mock<ISmtpClient>();

                    mock
                    .Setup(s => s.SendMailAsync(It.IsAny<MailMessage>())).Returns(Task.FromResult(0) )                     
                    .Callback<MailMessage>( ( m ) => {
                        sendToAdres = m.To.Single().ToString();
             
                    } );

                    return mock.Object;
                } }

            };

            containerFactory.ProxyFactory = new DummyProxyFactory<KlantPortaalContext>(mocks);
            
            var service = new UserAccessService<KlantPortaalContext>(_connectionString, new KlantPortaalContext() { ApplicationId = "KlantportaalTest" }, containerFactory);
            service.SendResetPassWordToken(userName);

            //Assert
            Assert.AreEqual(email, sendToAdres);
        }


        //dit test eigenlijk niets. alleen een probeersel voor het werken met aspnetidentit. maar zonde om weg te gooien :)
        [TestMethod]
        public async Task IT_ResetPassword()
        {
            
            var userName = "IT_ResetPassword";
            var password = "password";
            string resetToken;

            //seed de database met een test user
            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionString, Data.UserStore.DbContext.IdentityDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {

                var store = new UserStore<IdentityUser>(context);
                var mngr = new UserManager<IdentityUser>(store);

                var memberApp = new IdentityUser
                {
                    UserName = userName
                };

                var newMemberResult = await mngr.CreateAsync(memberApp);

                var user = await context.Users.SingleAsync( u => u.UserName == userName );
                Assert.AreEqual(userName, user.UserName);

               await mngr.AddPasswordAsync(user.Id, password);

            }
                       
            using (var context = new Data.UserStore.DbContext.IdentityDbContext(_connectionString, Data.UserStore.DbContext.IdentityDbContext.DatabaseInitializationMode.CreateIfNotExists))
            {
                
                var store = new UserStore<IdentityUser>(context);

                var user = store.Users.FirstOrDefault(u => u.UserName == userName);

                var mngr = new UserManager<IdentityUser>(store);
                
                //create password reset token
                var provider = new DpapiDataProtectionProvider("AppName");
                mngr.UserTokenProvider = new DataProtectorTokenProvider<IdentityUser>(provider.Create("PasswordReset")) as IUserTokenProvider<IdentityUser, string>; 
                
                resetToken = await mngr.GeneratePasswordResetTokenAsync(user.Id);
                
                //insert new password with reset token
                IdentityResult result =  mngr.ResetPassword(user.Id, resetToken, "newpassword");
                            
                //assert

                //get user again from db
                user = store.Users.FirstOrDefault(u => u.UserName == userName);

                //get the hashed password from the user
                var pwHash = user.PasswordHash;

                //check if the hash of the stored pw is the hash of the new password
                var pwResult = mngr.PasswordHasher.VerifyHashedPassword(pwHash, "newpassword");

                Assert.AreEqual(PasswordVerificationResult.Success, pwResult);
               
            }
            
        }
             
    }
}
