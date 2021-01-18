using System;
using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using Sphdhv.KlantPortaal.Access.Pensioen.Interface;

namespace Sphdhv.KlantPortaal.Access.Pensioen.ServiceStub
{
    public class PensioenAccessStub : Icatt.Test.Stubbing.StubManager<PensioenAccessData>, IPensioenAccess
    {
        

        public Task<ActueelPensioen> ActueelPensioenAsync()
        {
            throw new NotImplementedException();
        }

        public Task<DeelnemerProfiel> DeelnemerProfiel()
        {
            throw new NotImplementedException();
        }

        public Task<bool> VerifyDossierNr()
        {
            throw new NotImplementedException();
        }
    }

    public class PensioenAccessData
    {
    }
}
