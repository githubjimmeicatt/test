namespace Icatt.Membership.Data.UserStore.DbContext
{
    class IdentityDbContextFactory : IIdentityDbContextFactory
    {
        public IdentityDbContext Create()
        {
            return new IdentityDbContext();
        }
    }
}
