using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Correspondentie.Contract;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;

namespace Sphdhv.KlantPortaal.Access.Correspondentie.Proxy
{
    public class CorrespondentieAccessProxy<TContext> : ProxyBase<ICorrespondentieAccess, TContext>, ICorrespondentieAccess where TContext : class
    {
        public CorrespondentieAccessProxy(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public async Task<Document> CorrespondentieItem(string documentId = null)
        {
            return await InvokeAsync(documentId, Service.CorrespondentieItem);
        }

        public async Task<CorrespondentieOverzicht> Overzicht()
        {
            return await Invoke(Service.Overzicht);
        }
    }
}
