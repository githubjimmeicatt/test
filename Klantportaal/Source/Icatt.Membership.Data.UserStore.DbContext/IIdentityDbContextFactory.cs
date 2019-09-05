using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Membership.Data.UserStore.DbContext
{
    interface IIdentityDbContextFactory
    {
        IdentityDbContext Create();
    }
}
