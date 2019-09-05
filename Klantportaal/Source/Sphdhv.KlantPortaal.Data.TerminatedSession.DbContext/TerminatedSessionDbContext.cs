using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Data.Entity;
using Sphdhv.KlantPortaal.Data.TerminatedSession.Entities.Mappings;

namespace Sphdhv.KlantPortaal.Data.TerminatedSession.DbContext
{
    public class TerminatedSessionDbContext : System.Data.Entity.DbContext
    {
        public TerminatedSessionDbContext(string nameOrConnectionString = null, DatabaseInitializationMode initializationMode = DatabaseInitializationMode.NoInitialization) : base(nameOrConnectionString ?? "Icatt.Sks.KeyStoreContext")
        {

            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
            switch (initializationMode)
            {
                case DatabaseInitializationMode.NoInitialization:
                    Database.SetInitializer(new NullDatabaseInitializer<TerminatedSessionDbContext>());
                    break;
                case DatabaseInitializationMode.CreateIfNotExists:
                    Database.SetInitializer(new CreateDatabaseIfNotExists<TerminatedSessionDbContext>());
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

        // ReSharper disable UnusedAutoPropertyAccessor.Global
        public IDbSet<Entities.TerminatedSession> TerminatedSessions { get; set; }
        
        // ReSharper restore UnusedAutoPropertyAccessor.Global

        #region fluent API

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new TerminatedSessionMap());
        }

        #endregion

        public int Save()
        {
            this.ApplyStateChanges();
            return SaveChanges();
        }

    }
}
