using System.Runtime.Serialization;

namespace Icatt.Security.Engine.Cryptographer.Contract
{
    [DataContract]
    public class SupportedCipher
    {
        public string Id { get; set; }
        public string Description { get; set; }
    }
}