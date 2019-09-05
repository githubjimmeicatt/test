using System;

namespace SphdhvPiramideApi.Models
{
    public class ServiceConfiguration
    {
        public string BuildConfiguration { get; set; }
        public string ServerName { get; set; }
        public DateTime ServerTime { get; set; }
        public string ServiceName { get; set; }
        public string AssemblyVersion { get; set; }
        public string ProductVersion { get; set; }
        public string FileVersion { get; set; }
    }

}
