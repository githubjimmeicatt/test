using System;
using System.Data.Entity;
using Icatt.Data.Entity;
using Sphdhv.Klantportaal.Data.Pensioen.Mappings;

namespace Sphdhv.KlantPortaal.Data.Pensioen.DbContext
{
    public class PensioenDbContext : System.Data.Entity.DbContext
    {
        public PensioenDbContext(string nameOrConnectionString = null, DatabaseInitializationMode initializationMode = DatabaseInitializationMode.NoInitialization) : base(nameOrConnectionString ?? "name=PensioenDbContext")
        {

            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
            switch (initializationMode)
            {
                case DatabaseInitializationMode.NoInitialization:
                    Database.SetInitializer(new NullDatabaseInitializer<PensioenDbContext>());
                    break;
                case DatabaseInitializationMode.CreateIfNotExists:
                    Database.SetInitializer(new CreateDatabaseIfNotExists<PensioenDbContext>());
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

        public IDbSet<Klantportaal.Data.Pensioen.Entities.Dossier> Dossiers { get; set; }

        #region fluent API

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new DossierMap());
        }

        #endregion

        public int Save()
        {
            this.ApplyStateChanges();
            return SaveChanges();
        }

    }
}
