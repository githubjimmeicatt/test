using System;
using Icatt.ServiceModel;
using System.Threading.Tasks;
using Icatt.Digid.Access.Interface;
using Icatt.OAuth.Contract;
using Sphdhv.KlantPortaal.Engine.Claims.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Manager.Authentication.Service.Mapping;

namespace Sphdhv.KlantPortaal.Manager.Authentication.Service
{

    public class AuthenticationManagerService<TContext> : ServiceBase<TContext>, Interface.IAuthenticationManager where TContext : class, IApplicationEnvironmentContext
    {
        
        public AuthenticationManagerService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }


        public async Task<Contract.ExchangeTokenResponse> ExchangeTokenAsync(string authToken, string relayState)
        {
            if (Context.ApplicationId == "Sphdhv.KlantPortaal.Host.WebHost" || Context.ApplicationId == "Sphdhv.DnnHost")
            {
                //Refer to claims engine
                var engine = FactoryContainer.ProxyFactory.CreateProxy<IClaimsEngine>(Context);
                var response = await engine.ExchangeTokenAsync(Context.ApplicationId,Context.EnvironmentId,authToken, relayState);

                return response?.ToContract();
            }

            throw new UnauthorizedAccessException();
        }
 
        public AuthenticationMethod AuthenticationMethod(string cientAppId, string clientAppEnvironment, string clientAppEndpoint, string relayState)
        {

            if (cientAppId == "Sphdhv.KlantPortaal.Host.WebHost")
            {
                 //Auth over Digid

                //Geen clientAppEndpoint validatie. Wordt bepaald door settings
                var proxy = FactoryContainer.ProxyFactory.CreateProxy<IDigidAccess>(Context);
                var authMethod = proxy.AuthenticationMethod(relayState);

                return authMethod;
                
            }

            if (cientAppId == "Sphdhv.DnnHost")
            {//kipped in curren scenario and never used...
                if (!ClientDomainIsValid(cientAppId, clientAppEnvironment, clientAppEndpoint))
                    throw new InvalidClientDomainException();
            }

            throw new UnauthorizedAccessException("Unknown clientAppId");
        }


        private bool ClientDomainIsValid(string applicationId, string environment, string clientAppEndpoint)
        {
            //TODO make store for managing permitted URL's
            var uri = new Uri(clientAppEndpoint);

            //Only accept HTTPS
            //if (!"https".Equals(uri.GetComponents(UriComponents.Scheme, UriFormat.Unescaped),
            //    StringComparison.OrdinalIgnoreCase))
            //    return false;

            switch (applicationId)
            {
                case "Sphdhv.DnnHost":
                    switch (environment)
                    {
                        case "DEV":
                            if (uri.Host.Equals("localhost", StringComparison.OrdinalIgnoreCase)) return true;
                            break;
                        case "ACCEPT":
                            if (uri.Host.Equals("mijn.accept.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            if (uri.Host.Equals("mijn.dhvaccept.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            break;
                        case "TEST":
                            if (uri.Host.Equals("mijn.accept.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            if (uri.Host.Equals("mijn.test.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            break;
                        case "PROD":
                            if (uri.Host.Equals("mijn.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            break;

                    }
                    break;
                case "Sphdhv.KlantPortaal.Host.WebHost":
                    switch (environment)
                    {
                        case "DEV":
                            if (uri.Host.Equals("localhost", StringComparison.OrdinalIgnoreCase)) return true;
                            break;
                        case "ACCEPT":
                            if (uri.Host.Equals("klantportaal.accept.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            break;
                        case "TEST":
                            if (uri.Host.Equals("klantportaal.test.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            break;
                        case "PROD":
                            if (uri.Host.Equals("klantportaal.pensioenfondshaskoningdhv.nl", StringComparison.OrdinalIgnoreCase)) return true;
                            break;

                    }
                    break;
            }
            return false;
        }
    }

    public class InvalidClientDomainException : Exception
    {
    }
}


   

