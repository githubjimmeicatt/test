using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using Icatt.Logging.Entities;
using System;

namespace Icatt.Logging.DbContext
{
    public class LoggingDbContext : System.Data.Entity.DbContext
    {

        public LoggingDbContext(int databaseAppenderTimeoutInSeconds = 1) : this("name=Icatt.Logging.DbContext.TestDatabase", databaseAppenderTimeoutInSeconds)
        {

        }

        public LoggingDbContext(string nameOrConnectionString, int databaseAppenderTimeoutInSeconds = 1, DatabaseInitializationMode initializationMode = DatabaseInitializationMode.NoInitialization) : base(nameOrConnectionString)
        {
            ((IObjectContextAdapter)this).ObjectContext.CommandTimeout = databaseAppenderTimeoutInSeconds;

            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
            switch (initializationMode)
            {
                case DatabaseInitializationMode.NoInitialization:
                    Database.SetInitializer(new NullDatabaseInitializer<LoggingDbContext>());
                    break;
                case DatabaseInitializationMode.CreateIfNotExists:
                    Database.SetInitializer(new CreateDatabaseIfNotExists<LoggingDbContext>());
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



        public virtual DbSet<ExceptionEntry> ExceptionEntries { get; set; }
        public virtual DbSet<LogEntry> LogEntries { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            var logEntryEntity = modelBuilder.Entity<LogEntry>();
            logEntryEntity
                .HasKey(e => e.Id)
                .ToTable("LogEntry");

            logEntryEntity.Property(e => e.CreatedAtUtc).HasColumnType("datetime2").HasPrecision(7);
            logEntryEntity.Property(e => e.ApplicationName).IsRequired().HasMaxLength(256);
            logEntryEntity.Property(e => e.ApplicationArea).IsRequired().HasMaxLength(256);
            logEntryEntity.Property(e => e.Message).IsRequired().HasMaxLength(512);

            var exceptionEntryEntity = modelBuilder.Entity<ExceptionEntry>();
            exceptionEntryEntity
                .HasKey(e => e.Id)
                .ToTable("ExceptionEntry");
            exceptionEntryEntity.Property(e => e.CreatedAtUtc).HasColumnType("datetime2").HasPrecision(7);
            exceptionEntryEntity.Property(e => e.ApplicationName).IsRequired().HasMaxLength(256);
            exceptionEntryEntity.Property(e => e.ApplicationArea).IsOptional().HasMaxLength(256);
            exceptionEntryEntity.Property(e => e.Message).IsRequired();
            exceptionEntryEntity.Property(e => e.Type).IsRequired();
            exceptionEntryEntity.Property(e => e.Depth).IsRequired();


        }
    }
}
