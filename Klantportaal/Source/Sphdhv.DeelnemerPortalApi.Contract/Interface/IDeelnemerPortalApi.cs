using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Sphdhv.DeelnemerPortalApi.Contract;

namespace Sphdhv.DeelnemerPortalApi.Interface
{
    [ServiceContract]
    public interface IDeelnemerPortalApi
    {
        [OperationContract]
        Task<List<Polis>> Polissen(string dossierId);
        [OperationContract]
        Task<Verzekerde> Verzekerde(string dossierId);
        [OperationContract]
        Task<Verzekerde> VerzekerdeByBsn(string bsn);
        [OperationContract]
        Task<List<Pensioenrecht>> Pensioenrechten(string dossierId);
        [OperationContract]
        Task<Pensioen> Pensioen(string dossierId);
        [OperationContract]
        Task<Document> Document(string documentId, string dossierGuid);
        [OperationContract]
        Task<List<DocumentInfo>> DocumentInfo(string dossierGuid, string documentId = null);
    }
}
