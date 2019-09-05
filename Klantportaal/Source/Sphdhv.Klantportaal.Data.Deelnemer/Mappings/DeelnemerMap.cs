using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sphdhv.KlantPortaal.Data.Deelnemer.Mappings
{
    public class DeelnemerMap : EntityTypeConfiguration<Entities.Deelnemer>
    {
        public DeelnemerMap()
        {
            ToTable("Deelnemer");
            HasKey(k => k.Id);
            Property(p => p.Email).IsRequired();
            Property(p => p.Bsn).IsRequired();
            Property(p => p.CreatedAtUtc).IsRequired();
            Property(p => p.ModifiedAtUtc).IsRequired();
            Ignore(i => i.State);
        }
    }
}
