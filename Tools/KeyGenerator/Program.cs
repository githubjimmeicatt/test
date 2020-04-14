using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace KeyGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            // genereer een key die gebruikt kan worden als vervanging van de huidige encryption keys in de keyvault
            // nb dit is geen ideale oplossing. de iv zou hier niet mee opgeslagen moeten worden, maar dat is hoe het systeem op dit moment met sleutels werkt
            var key = new byte[32];
            var iv = new byte[16];
            var compositeKey = new byte[48];

            var rngCsp = new RNGCryptoServiceProvider();

            rngCsp.GetBytes(key);
            rngCsp.GetBytes(iv);
            
            iv.CopyTo(compositeKey, 0);
            key.CopyTo(compositeKey, 16);

            var keyVaultFriendlyKey = Convert.ToBase64String(compositeKey);

            Console.WriteLine(keyVaultFriendlyKey);
            Console.ReadKey();

        }
    }
}
