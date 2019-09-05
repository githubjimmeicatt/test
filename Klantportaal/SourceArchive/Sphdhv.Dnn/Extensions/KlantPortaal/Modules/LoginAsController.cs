using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Dnn.Mvc;

namespace Sphdhv.Dnn.Extensions.KlantPortaal.Modules
{
    public class LoginAsController : ControllerBase
    {

        public IActionResult Default()
        {

            return  new ActionResult
            {
                View = "Default"
            };   
            
        }
    }
}



