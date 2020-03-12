using AutoMapper;
using EngineContract = Sphdhv.KlantPortaal.Engine.Pensioen.Contract;
using AccessContract = Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using CorrespondentieAccessContract = Sphdhv.KlantPortaal.Access.Correspondentie.Contract;
using ManagerContract = Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using System.Globalization;

namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Service.Mapping
{
    public static class MappingExtensions
    {
        private static readonly IMapper Mapper;
        static MappingExtensions()
        {
            //Put any AutoMapper configuration needed for these mapping extensions in here
            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<EngineContract.ActueelPensioen, ManagerContract.ActueelPensioen>();
                cfg.CreateMap<AccessContract.DeelnemerProfiel, ManagerContract.DeelnemerProfiel>();
                cfg.CreateMap<AccessContract.Pensioenrecht, ManagerContract.Pensioenrecht>();

              //  cfg.CreateMap<CorrespondentieAccessContract.CorrespondentieOverzicht, ManagerContract.CorrespondentieOverzicht>();
                cfg.CreateMap<CorrespondentieAccessContract.Document, ManagerContract.Document>();

                //cfg.CreateMap<CorrespondentieAccessContract.Item, ManagerContract.Item>()
                //    .ForMember(dest => dest.MutatieDatum, opt => opt.ResolveUsing(m =>                
                //        (m.MutatieDatum == null) ? string.Empty:  m.MutatieDatum.Value.ToString("dd MMMM yyyy", new CultureInfo("nl-NL"))
                //     ));

                cfg.AllowNullCollections = true;
            });

            Mapper = new Mapper(config);
        }


        public static TResult Map<TResult>(this EngineContract.ActueelPensioen engineContract)
        {
            return Mapper.Map<TResult>(engineContract);
        }


        public static TResult Map<TResult>(this AccessContract.DeelnemerProfiel managerContract)
        {
            return Mapper.Map<TResult>(managerContract);
        }

        //public static TResult Map<TResult>(this CorrespondentieAccessContract.CorrespondentieOverzicht managerContract)
        //{
        //    return Mapper.Map<TResult>(managerContract);
        //}

        public static TResult Map<TResult>(this CorrespondentieAccessContract.Document managerContract)
        {
            return Mapper.Map<TResult>(managerContract);
        }
    }
}
