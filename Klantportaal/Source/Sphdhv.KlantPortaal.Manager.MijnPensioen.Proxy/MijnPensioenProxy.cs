using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using Icatt.ServiceModel;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Proxy
{
    public class MijnPensioenManagerProxy<TContext> : ProxyBase<Interface.IMijnPensioenManager, TContext> , Interface.IMijnPensioenManager where TContext:class
    {
        public MijnPensioenManagerProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public async Task<ActueelPensioen> ActueelPensioenAsync()
        {
            return await InvokeAsync(Service.ActueelPensioenAsync);
        }

        public async Task<DeelnemerProfiel> DeelnemerProfielAsync()
        {
            return await InvokeAsync(Service.DeelnemerProfielAsync);
        }

        public async Task<CorrespondentieOverzicht> DocumentenAsync()
        {
            return await Invoke(Service.DocumentenAsync);
        }

        public async Task<Document> DownloadDocumentAsync(string documentId)
        {
            return await Invoke(documentId, Service.DownloadDocumentAsync);
        }
    }

}
