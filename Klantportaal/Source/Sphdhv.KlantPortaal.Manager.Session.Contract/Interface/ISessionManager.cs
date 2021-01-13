using System.ServiceModel;

namespace Sphdhv.KlantPortaal.Manager.Session.Contract.Interface
{
    [ServiceContract]
    public interface ISessionManager
    {
        [OperationContract]
        void StartSession();

        [OperationContract]
        bool IsActiveSession();

        [OperationContract]
        void EndSession();
    }
}
