using System.Collections.Generic;
using Sphdhv.KlantPortaal.Engine.Pensioen.Contract;

namespace Sphdhv.KlantPortaal.Engine.Pensioen.ServiceStub
{
    public class PensioenEngineDataCollection
    {
        public Dictionary<string,ActueelPensioen> ActueelPensioenCollection { get; set; } = new Dictionary<string, ActueelPensioen>();

    }
}
