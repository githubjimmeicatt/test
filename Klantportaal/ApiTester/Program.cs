using Sphdhv.DeelnemerPortalApi.Interface;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiTester
{
    class Program
    {
        static async Task Main(string[] args)
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var proxy = factoryContainer.ProxyFactory.CreateProxy<IDeelnemerPortalApi>(new KlantPortaalContext());

            //test data
            //178424912, "0000307944" 
            //292634110, "0000307949" 
            //279618013, "0000307950" 
            //70704703, "0000308222", 
            //237648829, "0000307943" 

           
            var bsn = "xxxx";
            var dossier = "xxxx";


            var bsnResult = await proxy.VerzekerdeByBsn(bsn);

            Console.WriteLine("data for XXXX:");

            Console.WriteLine($"{bsnResult.AchternaamVolledig}");
            Console.WriteLine($"{bsnResult.Afdeling}");
            Console.WriteLine($"{bsnResult.Burgerlijkestaat}");
            Console.WriteLine($"{bsnResult.CrmId}");
            Console.WriteLine($"{bsnResult.DatumGeboorte}");
            Console.WriteLine($"{bsnResult.DatumOpnameFonds}");
            Console.WriteLine($"{bsnResult.DatumOverlijden}");
            Console.WriteLine($"{bsnResult.Fonds}");
            Console.WriteLine($"{bsnResult.Geboortenaam}");
            Console.WriteLine($"{bsnResult.Geslacht}");
            Console.WriteLine($"{bsnResult.Id}");
            Console.WriteLine($"{bsnResult.IdentificatieVerzekerde}");
            Console.WriteLine($"{bsnResult.IsActief}");
            Console.WriteLine($"{bsnResult.Naam}");
            Console.WriteLine($"{bsnResult.Nummer}");
            Console.WriteLine($"{bsnResult.PostSelectie}");
            Console.WriteLine($"{bsnResult.StatusVerzekerde}");
            Console.WriteLine($"{bsnResult.Tussenvoegsels}");
            Console.WriteLine($"{bsnResult.Uitzondering}");
            Console.WriteLine($"{bsnResult.Voorletters}");
            Console.WriteLine("partner:");
            Console.WriteLine($"{ bsnResult.HuidigePartner.DatumGeboorte}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.DatumHuwelijk}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.DatumPartnerschap}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.DatumSamenwonen}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.DossierId}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.Geslacht}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.NaamVolledig}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.Nummer}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.Status}");
            Console.WriteLine($"{ bsnResult.HuidigePartner.StatusOmschrijving}");

            Console.WriteLine("------------");



            
            var dossierResult = await  proxy.Verzekerde(dossier);


            Console.WriteLine("data for dossier xxxx");
            Console.WriteLine($"{dossierResult.AchternaamVolledig}");
            Console.WriteLine($"{dossierResult.Afdeling}");
            Console.WriteLine($"{dossierResult.Burgerlijkestaat}");
            Console.WriteLine($"{dossierResult.CrmId}");
            Console.WriteLine($"{dossierResult.DatumGeboorte}");
            Console.WriteLine($"{dossierResult.DatumOpnameFonds}");
            Console.WriteLine($"{dossierResult.DatumOverlijden}");
            Console.WriteLine($"{dossierResult.Fonds}");
            Console.WriteLine($"{dossierResult.Geboortenaam}");
            Console.WriteLine($"{dossierResult.Geslacht}");
            Console.WriteLine($"{dossierResult.Id}");
            Console.WriteLine($"{dossierResult.IdentificatieVerzekerde}");
            Console.WriteLine($"{dossierResult.IsActief}");
            Console.WriteLine($"{dossierResult.Naam}");
            Console.WriteLine($"{dossierResult.Nummer}");
            Console.WriteLine($"{dossierResult.PostSelectie}");
            Console.WriteLine($"{dossierResult.StatusVerzekerde}");
            Console.WriteLine($"{dossierResult.Tussenvoegsels}");
            Console.WriteLine($"{dossierResult.Uitzondering}");
            Console.WriteLine($"{dossierResult.Voorletters}");

            Console.WriteLine("partner:");
            Console.WriteLine($"{ dossierResult.HuidigePartner.DatumGeboorte}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.DatumHuwelijk}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.DatumPartnerschap}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.DatumSamenwonen}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.DossierId}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.Geslacht}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.NaamVolledig}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.Nummer}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.Status}");
            Console.WriteLine($"{ dossierResult.HuidigePartner.StatusOmschrijving}");

 



            Console.ReadLine();
             
        }
    }
}
