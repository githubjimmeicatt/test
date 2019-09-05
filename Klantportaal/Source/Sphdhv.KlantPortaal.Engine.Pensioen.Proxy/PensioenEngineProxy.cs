using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Engine.Pensioen.Contract;
using Sphdhv.KlantPortaal.Engine.Pensioen.Interface;

namespace Sphdhv.KlantPortaal.Engine.Pensioen.Proxy
{
    public class PensioenEngineProxy<TContext> : ProxyBase<IPensioenEngine, TContext>, IPensioenEngine where TContext : class
    {
        public PensioenEngineProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public async Task<ActueelPensioen> ActueelPensioen()
        {
            return await InvokeAsync(Service.ActueelPensioen);
        }

      
    }
}
