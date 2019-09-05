using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Manager.Beheer.Contract
{
    public class File
    {
        public string Name { get; set; }
        public byte[] Bytes { get; set; }
        public string Encoding { get; set; }
    }


    public class DossierDataOverride
    {
        public string DossierNr { get; set; }

        //Design note: hier waarden die vervangen moeten worden...

    }
}
