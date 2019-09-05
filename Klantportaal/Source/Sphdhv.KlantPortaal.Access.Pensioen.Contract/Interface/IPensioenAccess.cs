using System.ServiceModel;
using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Access.Pensioen.Contract;

namespace Sphdhv.KlantPortaal.Access.Pensioen.Interface
{
    [ServiceContract]
    public interface IPensioenAccess
    {
        [OperationContract]
        Task<ActueelPensioen> ActueelPensioenAsync();

        [OperationContract]
        Task<DeelnemerProfiel> DeelnemerProfiel();

        [OperationContract]
        Task<bool> VerifyDossierNr();
    }
}

