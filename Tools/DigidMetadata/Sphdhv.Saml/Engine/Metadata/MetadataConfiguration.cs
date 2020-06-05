using System.Collections.Generic;

namespace Icatt.Security.Saml2.Engine.Metadata
{
    public class MetadataConfiguration
    {
        public string Id { get; set; }
        public string EntityId { get; set; }
        public List<string> AssertionConsumerServiceArtifactLocations { get; set; }
        public string KeyName { get; set; }
    }
}
