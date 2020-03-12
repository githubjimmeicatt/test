using System;
using AutoMapper;
using Sphdhv.KlantPortaal.Engine.Claims.Contract;
using Sphdhv.KlantPortaal.Manager.Authentication.Contract;

namespace Sphdhv.KlantPortaal.Manager.Authentication.Service.Mapping
{
    public static class MappingExtensions
    {
        private static readonly IMapper Mapper;
        static MappingExtensions()
        {
            //Put any AutoMapper configuration needed for these mapping extensions in here
            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<Engine.Claims.Contract.ExchangeTokenResponse, Contract.ExchangeTokenResponse>();
                cfg.CreateMap<Engine.Claims.Contract.StatusCode, Contract.StatusCode>()
                .ConvertUsing<StatusCodeConverter>();

                cfg.AllowNullCollections = true;
            });

            Mapper = new Mapper(config);
        }


        public static Contract.ExchangeTokenResponse ToContract(this Engine.Claims.Contract.ExchangeTokenResponse engine)
        {
            return Mapper.Map<Contract.ExchangeTokenResponse>(engine);
        }


    }

    public class StatusCodeConverter : ITypeConverter<Engine.Claims.Contract.StatusCode, Contract.StatusCode>
    {
        Contract.StatusCode ITypeConverter<Engine.Claims.Contract.StatusCode, Contract.StatusCode>.Convert(Engine.Claims.Contract.StatusCode source, Contract.StatusCode destination, ResolutionContext context)
        {
            switch (source)
            {
                case Engine.Claims.Contract.StatusCode.CancelledByUser:
                    return Contract.StatusCode.CancelledByUser;
                case Engine.Claims.Contract.StatusCode.ServiceFailure:
                    return Contract.StatusCode.ServiceFailure;
                case Engine.Claims.Contract.StatusCode.Success:
                    return Contract.StatusCode.Success;
                case Engine.Claims.Contract.StatusCode.UnknownDossier:
                    return Contract.StatusCode.UnknownDossier;
                default:
                    //Any unknonw enum is a breakdown
                    return Contract.StatusCode.ServiceFailure;
            }
        }
    }
}
