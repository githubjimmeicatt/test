using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Data.Deelnemer.Entities;

namespace Sphdhv.KlantPortaal.Access.Deelnemer.Proxy
{
    public class DeelnemerAccessProxy<TContext> : ProxyBase<Interface.IDeelnemerAccess, TContext>, Interface.IDeelnemerAccess where TContext : class
    {
        public DeelnemerAccessProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public Contract.Deelnemer Deelnemer()
        {
            return Invoke(Service.Deelnemer);
        }

        public int Update(DeelnemerUpdate deelnemer)
        {
            return Invoke(deelnemer, Service.Update);
        }
 

        public int UpdateEmailStatus(Contract.DeelnemerStatus status)
        {
            return Invoke(status, Service.UpdateEmailStatus);
        }

 
    }
}