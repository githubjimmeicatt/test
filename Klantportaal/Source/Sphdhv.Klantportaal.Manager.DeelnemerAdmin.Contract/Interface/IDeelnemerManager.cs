using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.Klantportaal.Manager.Deelnemer.Interface
{
    [ServiceContract]
    public interface IDeelnemerManager
    {



        [OperationContract]
        bool VraagAanvulling();

        [OperationContract]
        bool OpslaanAanvulling(string Email);

        [OperationContract]
        bool VerifyEmail(Guid verificationid);
        
        [OperationContract]
        void WijzigingDoorDeelnemer(string Email, bool optOut);
    }
}
