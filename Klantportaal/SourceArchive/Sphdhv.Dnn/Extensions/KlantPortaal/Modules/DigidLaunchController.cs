using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Dnn.Mvc;

namespace Sphdhv.Dnn.Extensions.KlantPortaal.Modules
{
    public class DigidLaunchController : ControllerBase
    {
        public IActionResult Default()
        {
            var result = new ActionResult<ViewModel>
            {
                View = "Default",
                Model = new ViewModel
                {

                }
            };

            try
            {


                return result;
            }
            catch (Exception ex)
            {
                //TODO log exception and display  message to user....
                //result.Messages.Add(new ViewMessage(ViewMessageType.Error, " MESSAGE FOR USER "));
                return new ActionResult { Model = ex, View = "System/Exception" };

            }
        }

        public class ViewModel
        {
            public Uri LoginUri { get; set; }
            public string StatusMessage { get; set; }

        }
    }
}
