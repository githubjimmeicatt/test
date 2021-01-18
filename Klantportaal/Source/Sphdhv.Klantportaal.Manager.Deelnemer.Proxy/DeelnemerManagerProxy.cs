using System;
using Icatt.ServiceModel;
using Sphdhv.Klantportaal.Manager.Deelnemer.Interface;

namespace Sphdhv.Klantportaal.Manager.Deelnemer.Proxy
{
    public class DeelnemerManagerProxy<TContext> : ProxyBase<IDeelnemerManager, TContext>, IDeelnemerManager where TContext : class
    {
        public DeelnemerManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public bool VraagAanvulling()
        {
            return Invoke(Service.VraagAanvulling);
        }

        public bool OpslaanAanvulling(string Email)
        {
            return Invoke(Email, Service.OpslaanAanvulling);
        }

        public bool VerifyEmail(Guid verificationid)
        {
            return Invoke(verificationid, Service.VerifyEmail);
        }

        public void WijzigingDoorDeelnemer(string email, bool optOut)
        {
            Invoke(email, optOut, Service.WijzigingDoorDeelnemer);
        }
    }
}
