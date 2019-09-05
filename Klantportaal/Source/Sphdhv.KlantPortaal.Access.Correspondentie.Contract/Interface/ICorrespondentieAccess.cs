using System.ServiceModel;
using Sphdhv.KlantPortaal.Access.Correspondentie.Contract;
using System.Threading.Tasks;


namespace Sphdhv.KlantPortaal.Access.Correspondentie.Interface
{
    [ServiceContract]
    public interface ICorrespondentieAccess
    {
        [OperationContract]
        Task<CorrespondentieOverzicht> Overzicht();

        [OperationContract]
        Task<Document> CorrespondentieItem(string documentId);
    }


}
