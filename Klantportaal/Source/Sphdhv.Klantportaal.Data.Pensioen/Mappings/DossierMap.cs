using System.Data.Entity.ModelConfiguration;

namespace Sphdhv.Klantportaal.Data.Pensioen.Mappings
{
    public class DossierMap : EntityTypeConfiguration<Entities.Dossier>
    {
        public DossierMap()
        {
            ToTable("Dossier");
            HasKey(k => k.Nummer);
            Property(p => p.Blocked).IsRequired();
            Property(p => p.CreatedAtUtc).IsRequired();
            Property(p => p.ModifiedAtUtc).IsRequired();
            Ignore(i => i.State);
        }
    }
}
