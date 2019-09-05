using Icatt.Dnn.Mvc;

namespace Sphdhv.Dnn.Extensions.KlantPortaal.Modules
{
    public class DeelnemerDataCollectorController : ControllerBase
    {
        public IActionResult Default()
        {

            return new ActionResult
            {
                View = "Default"
            };

        }


        public class ViewModel
        {
            public string KlantportaalEndpoint { get; set; }
        }

    }
}
