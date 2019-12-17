using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Access.Deelnemer.Interface
{
    public interface IDeelnemerAccess
    {
        Contract.Deelnemer Deelnemer();

        int Update(Contract.DeelnemerUpdate deelnemer);

        int UpdateEmailStatus(DeelnemerStatus status);

        List<Contract.Deelnemer> Deelnemers();

    }
}
