using System.Threading.Tasks;
using Sphdhv.KlantPortaal.Engine.Pensioen.Contract;


namespace Sphdhv.KlantPortaal.Engine.Pensioen.Interface
{
    public interface IPensioenEngine
    {
        Task<ActueelPensioen> ActueelPensioen();
    }
}
