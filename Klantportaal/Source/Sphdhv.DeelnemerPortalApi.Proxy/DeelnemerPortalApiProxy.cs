using System.Collections.Generic;
using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.DeelnemerPortalApi.Contract;
using Sphdhv.DeelnemerPortalApi.Interface;

namespace Sphdhv.DeelnemerPortalApi.Proxy
{
    public class DeelnemerPortalApiProxy<TContext> : ProxyBase<IDeelnemerPortalApi, TContext>, IDeelnemerPortalApi where TContext : class
    {

        public DeelnemerPortalApiProxy(TContext context, IFactoryContainer<TContext> env) : base(context, env)
        {
        }

        async Task<List<Polis>> IDeelnemerPortalApi.Polissen(string dossierId)
        {
            return await InvokeAsync(dossierId, Service.Polissen);
        }

        async Task<Verzekerde> IDeelnemerPortalApi.Verzekerde(string dossierId)
        {
            return await InvokeAsync(dossierId, Service.Verzekerde);
        }

        async Task<Verzekerde> IDeelnemerPortalApi.VerzekerdeByBsn(string bsn)
        {
            return await InvokeAsync(bsn, Service.VerzekerdeByBsn);
        }

        async Task<List<Pensioenrecht>> IDeelnemerPortalApi.Pensioenrechten(string dossierId)
        {
            return await InvokeAsync(dossierId, Service.Pensioenrechten);
        }

        async Task<Pensioen> IDeelnemerPortalApi.Pensioen(string dossierId)
        {
            return await InvokeAsync(dossierId, Service.Pensioen);
        }

        async Task<Document> IDeelnemerPortalApi.Document(string documentId, string dossierGuid)
        {
            return await InvokeAsync(documentId, dossierGuid, Service.Document);
        }

        async Task<List<DocumentInfo>> IDeelnemerPortalApi.DocumentInfo(string dossierGuid, string documentId = null)
        {
            return await InvokeAsync(dossierGuid, documentId, Service.DocumentInfo);
        }
    }
}