using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Data.Entity;
using Sphdhv.KlantPortaal.Data.Deelnemer.Mappings;

namespace Sphdhv.KlantPortaal.Data.Deelnemer.DbContext
{
    public class DeelnemerDbContext : System.Data.Entity.DbContext
    {
        public DeelnemerDbContext(string nameOrConnectionString = null, DatabaseInitializationMode initializationMode = DatabaseInitializationMode.NoInitialization) : base(nameOrConnectionString ?? "name=IdentityDbContext")
        {

            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
            switch (initializationMode)
            {
                case DatabaseInitializationMode.NoInitialization:
                    Database.SetInitializer(new NullDatabaseInitializer<DeelnemerDbContext>());
                    break;
                case DatabaseInitializationMode.CreateIfNotExists:
                    Database.SetInitializer(new CreateDatabaseIfNotExists<DeelnemerDbContext>());
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

        public IDbSet<Entities.Deelnemer> Deelnemers { get; set; }

        #region fluent API

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new DeelnemerMap());
        }   

        #endregion

        public int Save()
        {
            this.ApplyStateChanges();
            return SaveChanges();
        }

    }
}
