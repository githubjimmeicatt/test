using Icatt.ServiceModel;
using Sphdhv.DeelnemerPortalApi.Interface;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;
using Sphdhv.DeelnemerPortalApi.Contract;
using System.Linq;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;
using Sphdhv.KlantPortaal.Access.Correspondentie.Contract;
using CorrespondentieOverzicht = Sphdhv.KlantPortaal.Access.Correspondentie.Contract.CorrespondentieOverzicht;

namespace Sphdhv.KlantPortaal.Access.Correspondentie.Service
{
    public class CorrespondentieAccess<TContext> : ServiceBase<TContext>, ICorrespondentieAccess where TContext : class, Common.IUserContext
    {
        public CorrespondentieAccess(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        async Task<CorrespondentieOverzicht> ICorrespondentieAccess.Overzicht()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerPortalApi>(Context);
            var documents = await proxy.DocumentInfo(Context.DossierNummer);

            var overzicht = new CorrespondentieOverzicht { Items = new List<Item>() };

            foreach (var document in documents)
            {
                var item = ToItem(document);
                overzicht.Items.Add(item);
            }
            return overzicht;
        }

        async Task<Contract.Document> ICorrespondentieAccess.CorrespondentieItem(string documentId)
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDeelnemerPortalApi>(Context);
            var docInfo = await proxy.DocumentInfo(Context.DossierNummer, documentId);
            var result = await proxy.Document(documentId, Context.DossierNummer);

            var props = docInfo?.SingleOrDefault(x => x.DocumentId == documentId);

            if (props == null || result?.Data == null)
            {
                return null;
            }

            var doc = new Contract.Document
            {
                Bytes = Convert.FromBase64String(result.Data),
                Properties = ToItem(props)
            };

            return doc;
        }
        private Item ToItem(DocumentInfo document)
        {
            var item = new Item
            {
                Categorie = document.Categorie,
                Dossier = document.DossierGuid,
                Id = document.DocumentId,
                Paginas = document.Paginas ?? 0,
                Titel = document.DocumentNaam,
                Type = document.Type
            };

            DateTime aanmaakDatum;
            if ( DateTime.TryParse(document.AanmaakDatum, out aanmaakDatum))
            {
                item.AanmaakDatum = aanmaakDatum;
            }

            DateTime mutatieDatum;
            if (DateTime.TryParse(document.MutatieDatum, out mutatieDatum))
            {
                item.MutatieDatum = mutatieDatum;
            }

            return item;
        }

        
    }
    
}

