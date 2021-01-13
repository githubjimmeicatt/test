using System;
using Icatt.ServiceModel;
using Sphdhv.Klantportaal.Manager.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Engine.Notification.Contract;
using Sphdhv.KlantPortaal.Engine.Notification.Interface;
using Sphdhv.DeelnemerPortalApi.Interface;

namespace Sphdhv.Klantportaal.Manager.Deelnemer.Service
{
    public class DeelnemerManager<TContext> : ServiceBase<TContext>, IDeelnemerManager
        where TContext : class, IWebRequest, IApplicationEnvironmentContext, IPiramideContext
    {
        private string _emailVerificatieEndpoint;

        public DeelnemerManager(TContext context, IFactoryContainer<TContext> factoryContainer, string emailVerificatieEndpoint)
            : base(context, factoryContainer)
        {
            _emailVerificatieEndpoint = emailVerificatieEndpoint;
        }

        public bool VraagAanvulling()
        {

            if (Context.ImpersonateMode)
            {
                return false;
            }
 
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerAccess>(Context);

            var deelnemer = proxy.Deelnemer();

            if (deelnemer == null)
            {
                //deze deelnemer is nog niet bekend. altijd vragen
                return true;
            }

            if (string.IsNullOrEmpty(deelnemer.Email) && deelnemer.Status != KlantPortaal.Access.Deelnemer.Contract.DeelnemerStatus.EmailOptOut)
            {
                //deze deelnemer heeft al een email adres opgegeven. niet meer lastig vallen. ongeacht de status
                return true;
            }

            return false;

        }

        public bool OpslaanAanvulling(string email)
        {

            //alleen verif mail versturen als email gevuld
            //opslaan in db
            var deelnemerupdate = new DeelnemerUpdate();
            var deelnemerAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerAccess>(Context);

            //email null of leeg als opt out verwerken
            if (string.IsNullOrWhiteSpace(email))
            {
                deelnemerupdate.Status = DeelnemerStatus.EmailOptOut;
                var result = deelnemerAccessProxy.Update(deelnemerupdate);
                return (0 < result);
            }
            else
            {
                deelnemerupdate.Status = DeelnemerStatus.None;
                deelnemerupdate.Email = email;
                deelnemerupdate.VerificationId = Guid.NewGuid();
                var result = deelnemerAccessProxy.Update(deelnemerupdate);
                if (result == 0) return false;

                //querystring verif mail zo opbouwen:
                var rootUrl = Properties.Settings.Default.DnnMijnOmgevingUrl;
                const string ActionPath = "#start$verifyemail$";
                var url = $"{rootUrl}{ActionPath}{deelnemerupdate.VerificationId.ToString("N")}";
                var prox = FactoryContainer.ProxyFactory.CreateProxy<INotification>(Context);

                //verst email
                var verifRequest = new VerificationRequest
                {
                    To = email,
                    VerificationLink = url
                };

                var arg = new Argument
                {
                    Name = "VerificatieRequest",
                    Type = typeof(VerificationRequest).FullName,
                    XmlSerialized = prox.SerializeToString(verifRequest)
                };
                prox.RaiseNotificationEvent(new ApplicationEnvironment { }, new EventType { OperationName = "VerifyEmail", SourceType = "IEmailManager" }, new[] { arg });
                return true;
            }
        }

        public bool VerifyEmail(Guid verificationid)
        {
            var deelnemerAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerAccess>(Context);
            var deelnemer = deelnemerAccessProxy.Deelnemer();
            if (null == deelnemer)
                return false;

            if (verificationid != deelnemer.VerificationId)
                return false;

            var result = deelnemerAccessProxy.UpdateEmailStatus(DeelnemerStatus.EmailVerified);

            return (0 < result);
        }


        public void WijzigingDoorDeelnemer(string Email, bool optOut)
        {
            throw new NotImplementedException();
        }


    }

}
