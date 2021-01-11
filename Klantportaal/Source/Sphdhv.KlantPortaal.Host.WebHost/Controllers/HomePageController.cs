using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using Icatt.Azure.Access;
using Microsoft.Extensions.Configuration;
using Sphdhv.KlantPortaal.Host.WebHost.Properties;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
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