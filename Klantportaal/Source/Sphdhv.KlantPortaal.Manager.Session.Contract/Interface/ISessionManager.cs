using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

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
