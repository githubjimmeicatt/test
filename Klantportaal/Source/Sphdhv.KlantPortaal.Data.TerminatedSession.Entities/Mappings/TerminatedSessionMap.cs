using System.Data.Entity.ModelConfiguration;

namespace Sphdhv.KlantPortaal.Data.TerminatedSession.Mappings
{
    public class TerminatedSessionMap : EntityTypeConfiguration<Entities.TerminatedSession>
    {
        public TerminatedSessionMap()
        {
            ToTable("TerminatedSession");
            HasKey(k => k.MarkerId);
            Property(p => p.MarkerId).HasMaxLength(255).IsRequired();
            Ignore(i => i.State);
        }
    }
}
