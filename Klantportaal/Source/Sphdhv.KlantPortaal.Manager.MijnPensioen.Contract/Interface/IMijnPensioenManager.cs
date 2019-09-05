using System.ServiceModel;
using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface
{
    [ServiceContract]
    public interface IMijnPensioenManager
    {
        [OperationContract]
        Task<ActueelPensioen> ActueelPensioenAsync();

        [OperationContract]
        Task<DeelnemerProfiel> DeelnemerProfielAsync();

        [OperationContract]
        Task<CorrespondentieOverzicht> DocumentenAsync();

        [OperationContract]
        Task<Document> DownloadDocumentAsync(string documentId);


    }


}
