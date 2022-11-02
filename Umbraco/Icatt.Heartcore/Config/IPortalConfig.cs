using System;
using System.Collections.Generic;

namespace Icatt.Heartcore.Config
{
    public interface IPortalConfig
    {
        List<Portal> GetPortals();
        IReadOnlyCollection<string> GetRootUrls();
        bool LoginIsRequired();
        List<Guid> ProtectedMediaFolderIds();
        bool TryGetPortal(out Portal portal);
        string GetRealm();
    }
}
