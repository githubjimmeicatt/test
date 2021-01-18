namespace Icatt.Membership.Data.UserStore.DbContext
{
    interface IIdentityDbContextFactory
    {
        IdentityDbContext Create();
    }
}
