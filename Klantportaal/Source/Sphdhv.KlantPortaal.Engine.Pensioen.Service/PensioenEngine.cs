using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Engine.Pensioen.Contract;
using Sphdhv.KlantPortaal.Engine.Pensioen.Service.Mapping;

namespace Sphdhv.KlantPortaal.Engine.Pensioen.Service
{
    public class PensioenEngine<TContext> : ServiceBase<TContext> , Interface.IPensioenEngine
        where TContext : class
    {
        public PensioenEngine(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public async Task<ActueelPensioen> ActueelPensioen()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<Access.Pensioen.Interface.IPensioenAccess>(Context);

            var pensioenAccess = await proxy.ActueelPensioenAsync();
            var resultPensionEngine = pensioenAccess.Map<ActueelPensioen>();
           
            return resultPensionEngine;

        }
       
    }
}
