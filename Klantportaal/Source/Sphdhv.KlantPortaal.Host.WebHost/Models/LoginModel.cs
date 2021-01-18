using Icatt.OAuth.Contract;

namespace Sphdhv.KlantPortaal.Host.WebHost.Models
{
    public class LoginModel
    {
        public string Destination { get; set; }

        // ReSharper disable once InconsistentNaming - name format prescribed by DigiD standard
        public string SAMLRequest { get; set; }
        
        public string RelayState { get; set; }

        public NameValuePair[] Parameters { get; set; }
    }

}

 