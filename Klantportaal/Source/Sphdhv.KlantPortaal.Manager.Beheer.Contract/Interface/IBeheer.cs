using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Manager.Beheer.Interface
{
    public interface IBeheer
    {
        Contract.File ExportEmails();

        void OverrideDossierData(Contract.DossierDataOverride data);
    }
}
