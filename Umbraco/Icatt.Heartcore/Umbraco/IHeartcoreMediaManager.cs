using System;
using System.Threading.Tasks;

namespace Icatt.Heartcore.Umbraco
{
    public interface IHeartcoreMediaManager
    {
        Task<string> SaveMedia(UmbracoMedia model);
        Task<bool> DeleteMedia(UmbracoMedia model);
    }
}
