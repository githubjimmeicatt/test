using Sphdhv.KlantPortaal.Access.AuthToken.Contract;
using System.Collections.Generic;

namespace Sphdhv.KlantPortaal.Access.AuthToken.Service
{
    public class TokenEntryMemoryStore
    {
        protected static readonly object InMemoryStoreLock = new object();
        protected static Dictionary<string, TokenEntry> InMemoryStore { get; set; } = new Dictionary<string, TokenEntry>(1100);
    }
}
