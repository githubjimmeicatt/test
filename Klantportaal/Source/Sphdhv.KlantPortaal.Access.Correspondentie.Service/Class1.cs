using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Correspondentie.Contract;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;

namespace Sphdhv.KlantPortaal.Access.Correspondentie.Service
{
    public class CorrespondentieAccess<TContext> : ServiceBase<TContext> , ICorrespondentieAccess where TContext : class
    {
        public CorrespondentieAccess(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public CorrespondentieOverzicht Overzicht(string deelnemerId)
        {
            throw new System.NotImplementedException();
        }

        public CorrespondentieOverzicht.Item CorrespondentieItem(string deelnemerId, ItemIdentifier itemId)
        {
            throw new System.NotImplementedException();
        }
    }
}
