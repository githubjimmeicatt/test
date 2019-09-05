using System.Threading.Tasks;
using Icatt.ServiceModel;
using Icatt.Test.Stubbing;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Engine.Pensioen.Contract;

namespace Sphdhv.KlantPortaal.Engine.Pensioen.ServiceStub
{
    public class PensioenEngineStub<TContext> : ServiceBase<TContext>, Interface.IPensioenEngine  where TContext :class, IUserContext
    {
        public readonly StubManager<PensioenEngineDataCollection> StubManager = new StubManager<PensioenEngineDataCollection>();

        public PensioenEngineStub(TContext context) : base(context, null)
        {
        }


        public async  Task<ActueelPensioen> ActueelPensioen()
        {

            var dossierId = Context.DossierNummer;
            var actueelPensioenCollection = StubManager.DataCollection.ActueelPensioenCollection;

            Task<ActueelPensioen> tReturnValue;
            if (actueelPensioenCollection.ContainsKey(dossierId))
            {
                tReturnValue = Task.FromResult(actueelPensioenCollection[dossierId]);
            }
            else
            {
                tReturnValue = Task.FromResult((ActueelPensioen)null);
            }

            return await  StubManager.Interceptors.InterceptAsync(dossierId1 => ActueelPensioen(), dossierId,tReturnValue);


        }


    }
}