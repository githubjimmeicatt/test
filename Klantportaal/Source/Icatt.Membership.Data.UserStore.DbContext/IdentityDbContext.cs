using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Data.Entity;

namespace Icatt.Membership.Data.UserStore.DbContext
{
    public class IdentityDbContext : IdentityDbContext<IdentityUser>
    {

        public IdentityDbContext(string nameOrConnectionString = null, DatabaseInitializationMode initializationMode = DatabaseInitializationMode.NoInitialization) : base(nameOrConnectionString ?? "IdentityDbContext")
        {
            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
            switch (initializationMode)
            {
                case DatabaseInitializationMode.NoInitialization:
                    Database.SetInitializer(new NullDatabaseInitializer<IdentityDbContext>());
                    break;
                case DatabaseInitializationMode.CreateIfNotExists:
                    Database.SetInitializer(new CreateDatabaseIfNotExists<IdentityDbContext>());
                    break;
                default:
                    throw new NotSupportedException($"Unsupported initialization mode '{initializationMode}'");
            }
        }
        public enum DatabaseInitializationMode
        {
            NoInitialization,
            CreateIfNotExists
        }


    }
    

}
