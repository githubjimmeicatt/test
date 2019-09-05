using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using Icatt.Ar.Manager.ApplicationAuthority.Contract;

namespace Icatt.Ar.Manager.ApplicationAuthority.Service
{
    internal class MemoryApplicationRegistry
    {
        private static readonly ConcurrentDictionary<string, ApplicationEnvironment> InternalApplicationRegistry = new ConcurrentDictionary<string, ApplicationEnvironment>(
            20,
            new Dictionary<string, ApplicationEnvironment> {
                { "0AE1112D26C3FD61416F9970177188C331C66CEE",new ApplicationEnvironment("Icatt.Sks.Admin.Console","DEV")},
                { "DD3D01B13E7183116B7232037BD038CC79EF62C7",new ApplicationEnvironment("Icatt.Sks.Admin.Console","TEST")},
                { "5D337CFAB345EB2ACF8E923C15D060F0FE1E1D86",new ApplicationEnvironment("Icatt.Sks.Admin.Console","ACCEPT")},
                { "5A422B820EDD75C2BF9C68FC5192283911D5DAC1",new ApplicationEnvironment("Icatt.Sks.Admin.Console","PROD")},

                { "8BD92D40E3867A1AEA828BE47C9CC6A852F96F3A",new ApplicationEnvironment("Icatt.Sks.MasterKeyAdmin.Console","DEV")},
                { "BA8AB45B4328ADEF01E9EC859817DDA1C5DCBC05",new ApplicationEnvironment("Icatt.Sks.MasterKeyAdmin.Console","TEST")},
                { "33A43809711D15F3A13D0030376077690DF103C8",new ApplicationEnvironment("Icatt.Sks.MasterKeyAdmin.Console","ACCEPT")},
                { "3B83CE56A5175A085F6CA9F8DDDEDACD05D80425",new ApplicationEnvironment("Icatt.Sks.MasterKeyAdmin.Console","PROD")},

                { "BCC9DF162FA1BA2EF27F61139C1589C39B04C455",new ApplicationEnvironment("Icatt.Sks.KeyReader.Console","DEV")},
                { "AE8E7B9BBA7AE9E5F2E9EAA97155CB08A50BCB9C",new ApplicationEnvironment("Icatt.Sks.KeyReader.Console","ACCEPT")},
                { "E2F9CA0E2639B278F4EE0EEC725BF2A9F5BB373B",new ApplicationEnvironment("Icatt.Sks.KeyReader.Console","TEST")},
                //GEEN PROD KEYREADER CONSOLE

                { "FDA96F574A9451D704D0EFAAA025A8352B2618B0",new ApplicationEnvironment("Sphdhv.KlantPortaal.WebHost","DEV")},
                { "B363520428E153961ABD71996CFEBB5E6F96565E",new ApplicationEnvironment("Sphdhv.KlantPortaal.WebHost","TEST")},
                { "EF038AD9D9BD4E71BE82607C4BCA44E70AB77BCE",new ApplicationEnvironment("Sphdhv.KlantPortaal.WebHost","ACCEPT")},
                { "535B2E585C12029E561CEDBD15CB104E71BDAE70",new ApplicationEnvironment("Sphdhv.KlantPortaal.WebHost","PROD")},

                { "E99E5CABA2434265279A0E2E4753D33C4AC5AACC",new ApplicationEnvironment("Sphdhv.DnnHost","DEV")},
                { "730A23375D867D35CCB17D689131B26AC849393F",new ApplicationEnvironment("Sphdhv.DnnHost","TEST")},
                { "AD0F239A2160AC854921B2533DD5992FF158D249",new ApplicationEnvironment("Sphdhv.DnnHost","ACCEPT")},
                { "EF0D3CF2BE1AB37E88D0877256AE30C097AC0288",new ApplicationEnvironment("Sphdhv.DnnHost","PROD")},

                { "AD9F2F8DB207D5D0EC1421D5A2B92A4578A101F9",new ApplicationEnvironment("Mk.DnnHost","DEV")},
                { "2F4230289A3596D0CD7BB9CA475746C7B5D7B12B",new ApplicationEnvironment("Mk.DnnHost","TEST")},
                { "1FFFD2870A605A19F00F54414D431EC534FD90E5",new ApplicationEnvironment("Mk.DnnHost","ACCEPT")},
                { "8866C1DEB967C4C502B2655ED20628F3D6927BCA",new ApplicationEnvironment("Mk.DnnHost","PROD")},
            },
            StringComparer.OrdinalIgnoreCase);

        internal bool TryGetValue(string thubprint, out ApplicationEnvironment appenv)
        {
            return InternalApplicationRegistry.TryGetValue(thubprint, out appenv);
        }

    }
}