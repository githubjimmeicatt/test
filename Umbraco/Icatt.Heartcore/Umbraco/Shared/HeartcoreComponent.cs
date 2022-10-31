using System;
using Newtonsoft.Json;

namespace Icatt.Heartcore.Umbraco.Shared
{
    public class HeartcoreComponent
    {
        public HeartcoreComponent(string ncContentTypeAlias)
        {
            NcContentTypeAlias = ncContentTypeAlias;
            Key = Guid.NewGuid().ToString();
        }


        [JsonProperty("key", NullValueHandling = NullValueHandling.Ignore)]
        public string Key { get; private set; }

        [JsonProperty("name", NullValueHandling = NullValueHandling.Ignore)]
        public string Name { get; set; }

        [JsonProperty("ncContentTypeAlias", NullValueHandling = NullValueHandling.Ignore)]
        public string NcContentTypeAlias { get; private set; }
    }
}
