using System;
using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.ServiceStub
{
    public class MijnPensioenManagerStub : IMijnPensioenManager
    {
        public Task<ActueelPensioen> ActueelPensioenAsync()
        {
            throw new NotImplementedException();
        }

        public Task<DeelnemerProfiel> DeelnemerProfielAsync()
        {
            throw new NotImplementedException();
        }

        public Task<CorrespondentieOverzicht> CorrespondentieOverzichtAsync()
        {
            throw new NotImplementedException();
        }

 

        public Task<CorrespondentieOverzicht> DocumentenAsync()
        {
            throw new NotImplementedException();
        }

        public Task<Document> DownloadDocumentAsync(string documentId)
        {
            throw new NotImplementedException();
        }
    }
}
