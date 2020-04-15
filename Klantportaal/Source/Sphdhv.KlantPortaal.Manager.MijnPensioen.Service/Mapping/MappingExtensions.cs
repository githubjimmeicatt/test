using AutoMapper;
using AccessContract = Sphdhv.KlantPortaal.Access.Pensioen.Contract;
using EngineContract = Sphdhv.KlantPortaal.Engine.Pensioen.Contract;
using ManagerContract = Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;

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
                cfg.CreateMap<EngineContract.Polis, ManagerContract.Polis>();
                cfg.CreateMap<EngineContract.ArbeidVast, ManagerContract.ArbeidVast>();
                cfg.CreateMap<EngineContract.ArbeidVariabel, ManagerContract.ArbeidVariabel>();
                cfg.CreateMap<EngineContract.Pensioenrecht, ManagerContract.Pensioenrecht>();
                cfg.CreateMap<EngineContract.Pensioen, ManagerContract.Pensioen>();
                cfg.CreateMap<EngineContract.DeelnemerProfiel, ManagerContract.DeelnemerProfiel>();
                cfg.CreateMap<EngineContract.Adres, ManagerContract.Adres>();
                cfg.CreateMap<EngineContract.Bereikbaarheid, ManagerContract.Bereikbaarheid>();
                cfg.CreateMap<EngineContract.Huidigepartner, ManagerContract.Huidigepartner>();

                cfg.CreateMap<AccessContract.DeelnemerProfiel, ManagerContract.DeelnemerProfiel>();
                cfg.CreateMap<AccessContract.Adres, ManagerContract.Adres>();
                cfg.CreateMap<AccessContract.Bereikbaarheid, ManagerContract.Bereikbaarheid>();
                cfg.CreateMap<AccessContract.Huidigepartner, ManagerContract.Huidigepartner>();
                cfg.CreateMap<AccessContract.Pensioenrecht, ManagerContract.Pensioenrecht>();

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
    }
}
