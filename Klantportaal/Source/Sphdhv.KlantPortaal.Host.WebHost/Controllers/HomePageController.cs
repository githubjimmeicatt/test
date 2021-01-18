using System.Web.Mvc;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class HomePageController : Controller
    {
  
        public HomePageController()
        {
        }

        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        
    }
}