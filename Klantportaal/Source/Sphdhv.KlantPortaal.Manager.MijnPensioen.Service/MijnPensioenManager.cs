using System;
using System.Threading.Tasks;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Engine.Pensioen.Interface;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.Mapping;
using Sphdhv.KlantPortaal.Access.Correspondentie.Interface;
using System.Linq;
using System.Globalization;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Service
{
    public class MijnPensioenManager<TContext> : ServiceBase<TContext>, IMijnPensioenManager
        where TContext : class, IUserContext
    {
        public MijnPensioenManager(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }

        public async Task<ActueelPensioen> ActueelPensioenAsync()
        {

            var proxy = FactoryContainer.ProxyFactory.CreateProxy<IPensioenEngine>(Context);

            var engineResponse = await proxy.ActueelPensioen();

            var resultPensionManager = engineResponse.Map<ActueelPensioen>();

            return resultPensionManager;

        }

        public async Task<DeelnemerProfiel> DeelnemerProfielAsync()
        {
            var proxy = FactoryContainer.ProxyFactory.CreateProxy<Access.Pensioen.Interface.IPensioenAccess>(Context);

            var deelnemerProfielAccess = await proxy.DeelnemerProfiel();

            var resultDeelnemerProfielManager = deelnemerProfielAccess.Map<DeelnemerProfiel>();

            return resultDeelnemerProfielManager;
        }

        public async Task<CorrespondentieOverzicht> DocumentenAsync()
        {
            if (string.IsNullOrEmpty(Context.DossierNummer))
            {
                return null;
            }
            var isStaging = Properties.Settings.Default.IsStaging;

            var proxy = FactoryContainer.ProxyFactory.CreateProxy<ICorrespondentieAccess>(Context);
            var accessResponse = await proxy.Overzicht();
            var filteredDocuments = accessResponse.Items
                .Where(d => d.AanmaakDatum.HasValue && d.AanmaakDatum.Value > new DateTime(2017, 1, 1)
                && (
                        (d.Categorie == "Pensioenopgaven" && d.Type == "Pensioenopgave")
                        || (isStaging && (d.Type == "1" || d.Type == "8"))
                    )
                );

            var overzicht = new CorrespondentieOverzicht
            {
                Items = filteredDocuments.Select(f => new Item()
                {
                    Titel = f.Titel,
                    MutatieDatum = (f.MutatieDatum == null) ? string.Empty : f.MutatieDatum.Value.ToString("dd MMMM yyyy", new CultureInfo("nl-NL")),
                    Id = f.Id
                }).ToList()
            };

            return overzicht;
        }

        public async Task<Document> DownloadDocumentAsync(string documentId)
        {
            if (string.IsNullOrEmpty(Context.DossierNummer) || string.IsNullOrEmpty(documentId))
            {
                return null;
            }

            var proxy = FactoryContainer.ProxyFactory.CreateProxy<ICorrespondentieAccess>(Context);
            var accessResponse = await proxy.CorrespondentieItem(documentId);

            if (accessResponse == null)
            {
                return null;
            }

            string fileName = "document.pdf";

            if ( !string.IsNullOrEmpty(accessResponse.Properties.Titel) ) {
                fileName = (accessResponse.Properties.Titel.Contains(".")) ? accessResponse.Properties.Titel : accessResponse.Properties.Titel + ".pdf";
            }

            string cleanFileName = fileName;
            
            foreach (char badChar in System.IO.Path.GetInvalidFileNameChars() )
            {
                cleanFileName = cleanFileName.Replace(badChar.ToString(), "" );
            }

            var doc = new Document()
            {
                Bytes = accessResponse.Bytes,
                Filename = cleanFileName,
                MediaType = Icatt.MediaType.MediaTypeUtlity.GetMediayTypeByFileName(cleanFileName)
            };

            return doc;
        }
    }
}
