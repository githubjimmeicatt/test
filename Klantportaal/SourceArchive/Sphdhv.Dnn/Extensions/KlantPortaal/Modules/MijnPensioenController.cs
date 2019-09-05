using System;
using Icatt.Dnn.Mvc;
using System.Collections.Generic;
using System.Web.Http.Routing;
using System.Web.Http;

namespace Sphdhv.Dnn.Extensions.KlantPortaal.Modules
{
    public class MijnPensioenController : ControllerBase
    {

        public IActionResult Default()
        {
            var result = new ActionResult
            {
                View = "Default",
                Model = new ViewModel
                {
                    KlantportaalEndpoint = Properties.Settings.Default.KlantportaalEndpoint
                }
            };


            try
            {

            


                return result;
            }
            catch (Exception ex)
            {
                //TODO log exception and display  message to user or throw
                //result.Messages.Add(new ViewMessage(ViewMessageType.Error, " MESSAGE FOR USER "));
                return new ActionResult { Model = ex, View = "System/Exception" };

            }
        }

        public class ViewModel
        {
            public string KlantportaalEndpoint { get; set; }
        }
    }
}
