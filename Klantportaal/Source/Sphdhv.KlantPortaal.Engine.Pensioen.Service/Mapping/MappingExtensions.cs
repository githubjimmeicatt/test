using AutoMapper;
using AccessContract = Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using EngineContract = Sphdhv.KlantPortaal.Engine.Pensioen.Contract;

namespace Sphdhv.KlantPortaal.Engine.Pensioen.Service.Mapping
{
    public static class MappingExtensions
    {
        private static readonly IMapper Mapper;
        static MappingExtensions()
        {
            //Put any AutoMapper configuration needed for these mapping extensions in here
            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<AccessContract.ActueelPensioen, EngineContract.ActueelPensioen>();
                cfg.CreateMap<AccessContract.Polis, EngineContract.Polis>();
                cfg.CreateMap<AccessContract.ArbeidVast, EngineContract.ArbeidVast>();
                cfg.CreateMap<AccessContract.ArbeidVariabel, EngineContract.ArbeidVariabel>();
                cfg.CreateMap<AccessContract.Pensioenrecht, EngineContract.Pensioenrecht>();
                cfg.CreateMap<AccessContract.Pensioen, EngineContract.Pensioen>();
                cfg.CreateMap<AccessContract.DeelnemerProfiel, EngineContract.DeelnemerProfiel>();
                cfg.CreateMap<AccessContract.Bereikbaarheid, EngineContract.Bereikbaarheid>();
                cfg.CreateMap<AccessContract.Adres, EngineContract.Adres>();
                cfg.CreateMap<AccessContract.Huidigepartner, EngineContract.Huidigepartner>();
            });
            Mapper = new Mapper(config);
        }


        public static TResult Map<TResult>(this AccessContract.ActueelPensioen entity)
        {
            return Mapper.Map<TResult>(entity);
        }
    }
}
