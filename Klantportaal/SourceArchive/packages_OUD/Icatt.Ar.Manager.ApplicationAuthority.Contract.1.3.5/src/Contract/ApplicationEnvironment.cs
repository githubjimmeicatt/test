using System.Runtime.Serialization;

namespace Icatt.Ar.Manager.ApplicationAuthority.Contract
{
    [DataContract]
    public class ApplicationEnvironment
    {
        public ApplicationEnvironment(string appId, string envId)
        {
            ApplicationId = appId;
            EnvironmentId = envId;
        }

        [DataMember]
        public string ApplicationId { get; set; }
        [DataMember]
        public string EnvironmentId { get; set; }
    }

    [DataContract]
    public class PublicCertificate
    {
        [DataMember]
        byte[] Pfx { get; set; }

        [DataMember]
        string Thumbprint { get; set; }
    }
}