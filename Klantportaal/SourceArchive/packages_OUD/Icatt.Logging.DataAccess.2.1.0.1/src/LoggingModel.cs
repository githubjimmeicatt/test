using Icatt.Logging.Entities;

namespace Icatt.Logging.DataAccess
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class LoggingModel : DbContext
    {
        public LoggingModel()
            : base("name=LoggingDatabase")
        {
        }

        public virtual DbSet<ExceptionEntry> ExceptionEntries { get; set; }
        public virtual DbSet<LogEntry> LogEntries { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.ApplicationName)
                .IsUnicode(false);

            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.ApplicationArea)
                .IsUnicode(false);

            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.Message)
                .IsUnicode(true);

            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.Type)
                .IsUnicode(true);

            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.Source)
                .IsUnicode(true);

            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.StackTrace)
                .IsUnicode(true);

            modelBuilder.Entity<ExceptionEntry>()
                .Property(e => e.TargetSite)
                .IsUnicode(true);

            modelBuilder.Entity<LogEntry>()
                .Property(e => e.ApplicationName)
                .IsUnicode(true);

            modelBuilder.Entity<LogEntry>()
                .Property(e => e.ApplicationArea)
                .IsUnicode(true);

            modelBuilder.Entity<LogEntry>()
                .Property(e => e.Message)
                .IsUnicode(true);
        }
    }
}
