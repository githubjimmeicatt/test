using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Pensioen.Contract;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Proxy
{
    public class PensioenAccessProxy<TContext> : ProxyBase<Interface.IPensioenAccess, TContext>, Interface.IPensioenAccess where TContext: class
    {
        public PensioenAccessProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public async Task<ActueelPensioen> ActueelPensioenAsync()
        {
            return await InvokeAsync(Service.ActueelPensioenAsync);
        }

        public async Task<DeelnemerProfiel> DeelnemerProfiel()
        {
            return await InvokeAsync(Service.DeelnemerProfiel);
        }

        public async Task<bool> VerifyDossierNr()
        {
            return await InvokeAsync(Service.VerifyDossierNr);
        }

      
    }
}
