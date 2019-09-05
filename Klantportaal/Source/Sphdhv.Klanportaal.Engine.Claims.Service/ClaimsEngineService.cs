using System;
using Icatt.Digid.Access.Interface;
using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Access.Pensioen.Interface;
using Sphdhv.KlantPortaal.Engine.Claims.Interface;
using Icatt.OAuth.Contract;
using System.Threading.Tasks;
using Icatt;
using Sphdhv.KlantPortaal.Access.AuthToken.Interface;
using System.Linq;
using Sphdhv.KlantPortaal.Manager.AspNetIdentity.Contract;
using Sphdhv.KlantPortaal.Engine.Claims.Contract;
using StatusCode = Sphdhv.KlantPortaal.Engine.Claims.Contract.StatusCode;
using Icatt.Auditing.Manager.AuditTrailWriter.Interface;
using Icatt.Auditing.Manager.AuditTrailWriter.Contract;
using Icatt.Digid.Access.Contract;

namespace Sphdhv.KlantPortaal.Engine.Claims.Service
{
    public class ClaimsEngineService<TContext> : ServiceBase<TContext>, IClaimsEngine where TContext : class, Common.IUserContext
    {

        private static object[] BsnMappingTable = new[]{
            //            usernm,  digid bsn  , sph bsn  , sph dossiernr, digid email
            new object[] {"digid1","900132188", 178424912, "0000307944", "??"},
            new object[] {"digid1", "900132206", 292634110, "0000307949", "??"},
            new object[] {"digid1", "900132218", 279618013, "0000307950", "??"},
            new object[] {"digid1", "900132231", 70704703, "0000308222", "??"},
            new object[] {"digid1", "900132243", 237648829, "0000307943", "icatttest+sphdhv.digid5@gmail.com"},
            };

        private static readonly ThreadSafeRandomizer Rand = new ThreadSafeRandomizer();

        public ClaimsEngineService(TContext context, IFactoryContainer<TContext> factoryContainer) : base(context, factoryContainer)
        {
        }



        Claim[] IClaimsEngine.ExchangeToken(string appId, string envId, string authToken)
        {
            throw new NotImplementedException();
        }

        async Task<Contract.ExchangeTokenResponse> IClaimsEngine.ExchangeTokenAsync(string appId, string envId, string authToken, string relayState)
        {


            string relayStateDossierNummer = null;
            string relayStateEnvironmentId = null;
            if (!string.IsNullOrWhiteSpace(relayState))
            {
                var relayStateParts = relayState.Split('|');
                if (relayStateParts.Length == 2)
                {
                    relayStateDossierNummer = relayStateParts[0];
                    relayStateEnvironmentId = relayStateParts[1];
                }
            }



            if (appId == "Sphdhv.KlantPortaal.Host.WebHost")
            {
                Claim bsnClaim = null;
                Claim dossierNrClaim = null;
                Claim usernameClaim = null;

                var csfrClaim = new Claim
                {
                    Issuer = "SpdhvKlantportaal",
                    OriginalIssuer = "SpdhvKlantportaal",
                    Type = "CSRF",
                    Value = Icatt.Security.SigningUtility.CreateRandomString(12),
                    ValueType = "string",

                };


                if (relayStateEnvironmentId == "acceptImpersonate")
                {

                    var proxy = FactoryContainer.ProxyFactory.CreateProxy<IAspNetIdentityManager>(Context);

                    var impersonateClaims = proxy.ExchangeToken(authToken, relayState);

                    usernameClaim = impersonateClaims.SingleOrDefault(c => c.Type == "pensioenfondshakoningdhv.nl/username");

                    Context.DossierNummer = relayStateDossierNummer;

                }
                else
                {

                    //Call DigiD client
                    IDigidAccess digidProxy = FactoryContainer.ProxyFactory.CreateProxy<IDigidAccess>(Context);

                    Icatt.Digid.Access.Contract.VerifyTokenResponse digidResult = null;
                    try
                    {
                        digidResult = await digidProxy.VerifyTokenAsync(authToken);
                    }
                    catch (Exception)
                    {
                        //Digid storing of geen verbinding
                        return new ExchangeTokenResponse
                        {
                            Status = StatusCode.ServiceFailure
                        };
                    }

                    if (digidResult?.Status == Icatt.Digid.Access.Contract.StatusCode.AuthnFailed)
                    {
                        Audit(digidResult, EventType.CancelledByUser);
                        return new ExchangeTokenResponse
                        {
                            Status = StatusCode.CancelledByUser
                        };
                    }

                    if (digidResult?.Status == Icatt.Digid.Access.Contract.StatusCode.ServiceFailure)
                    {
                        Audit(digidResult, EventType.ServiceFailure);
                        return new ExchangeTokenResponse
                        {
                            Status = StatusCode.ServiceFailure
                        };
                    }
                    

                    //audit sucessful digid login
                    Audit(digidResult, EventType.Login );


                    bsnClaim = new Claim
                    {
                        OriginalIssuer = digidResult?.Issuer,
                        Issuer = digidResult?.Issuer,
                        Type = "digid.nl/bsn", //check IANA registry for existence of official JWT claim type for BSN
                        Value = digidResult?.Bsn,
                        ValueType = "string"
                    };




                    if (envId.Equals("dev", StringComparison.OrdinalIgnoreCase) || envId.Equals("test", StringComparison.OrdinalIgnoreCase))
                    {
                        //map BSN naar één van de test dossiernrs
                        var map = BsnMappingTable.OfType<object[]>().SingleOrDefault(row => bsnClaim.Value.Equals((string)row[1], StringComparison.Ordinal));
                        if (map != null)
                        {
                            var sphBsn = (int)map[2];

                            bsnClaim.Value = sphBsn.ToString();
                        }
                    }

                    //Call spdhv access
                    Context.Bsn = bsnClaim.Value;


                    IPensioenAccess accessProxy = FactoryContainer.ProxyFactory.CreateProxy<IPensioenAccess>(Context);

                    var result = await accessProxy.DeelnemerProfiel();

                    Context.DossierNummer = result?.Nummer;


                    if ( string.IsNullOrEmpty(Context.DossierNummer) )
                    {
                        return new ExchangeTokenResponse
                        {
                            Status = StatusCode.UnknownDossier
                        };
                    }

                }



                dossierNrClaim = new Claim
                {
                    OriginalIssuer = "SPHDHV",
                    Issuer = "SPHDHV",
                    Type = "pensioenfondshakoningdhv.nl/dossiernummer",
                    Value = Context.DossierNummer,
                    ValueType = "string"
                };


                //Ensure Dnn User ID for DossierNr or BSN
                //TODO use hash of DossierNr as dnn userId together with iv

                string dnnUserId;

                using (var provider1 = new System.Security.Cryptography.SHA512Managed())
                {
                    dnnUserId = "sph" + Convert.ToBase64String(provider1.ComputeHash(System.Text.Encoding.UTF8.GetBytes(Context.DossierNummer)));
                }

                var dnnClaims = new[]
                {
                    new Claim
                    {
                        Issuer = "SpdhvKlantportaal",
                        OriginalIssuer="SpdhvKlantportaal",
                        Type = "pensioenfondshakoningdhv.nl/DnnUserId",
                        Value = dnnUserId,
                        ValueType = "string",
                    },
                    csfrClaim
                };


                var tokenAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IAuthTokenAccess>(Context);


                //Issue auth token voor Dnn client app
                var dnnTokenEntry = tokenAccessProxy.IssueToken(dnnClaims, TimeSpan.FromSeconds(30)); // TokenRepository.IssueToken(dnnClaims, TimeSpan.FromSeconds(5)); //TODO make setting for token expiration

                //Concatenate token en signature
                var dnnAuthClaim = new Claim
                {
                    Issuer = "SpdhvKlantportaal",
                    OriginalIssuer = "SpdhvKlantportaal",
                    Type = "authtoken",
                    Value = dnnTokenEntry.Token + "." + Convert.ToBase64String(dnnTokenEntry.Signature),
                    ValueType = "string",
                };



                Claim[] claims;
                if (relayStateEnvironmentId == "acceptImpersonate")
                {
                    claims = new[] { usernameClaim, dossierNrClaim, dnnAuthClaim, csfrClaim };
                }
                else
                {
                    claims = new[] { bsnClaim, dossierNrClaim, csfrClaim };
                }

                return new ExchangeTokenResponse
                {
                    Claims = claims,
                    Status = StatusCode.Success
                };

            };

            if (appId == "Sphdhv.DnnHost")
            {
                var tokenPair = authToken.Split(new[] { "." }, StringSplitOptions.None);

                if (tokenPair.Length == 2)
                {
                    //Get claims from token store and clear token from repo preventing replay attacks
                    var tokenAccessProxy = FactoryContainer.ProxyFactory.CreateProxy<IAuthTokenAccess>(Context);
                    var claims = tokenAccessProxy.RedeemToken(tokenPair[0], tokenPair[1]);

                    if (claims != null)
                        return new ExchangeTokenResponse
                        {
                            Claims = claims,
                            Status = StatusCode.Success
                        };

                }


            }

            throw new UnauthorizedAccessException();
        }



        private void Audit(VerifyTokenResponse digidResult, EventType eventType)
        {
            var auditData = new Icatt.Auditing.Manager.AuditTrailWriter.Contract.DigidAuditData() { Bsn = digidResult.Bsn, Ip = digidResult.ClientIp, Sofinummer = digidResult.Sofi };
            var auditTrailManagerproxy = FactoryContainer.ProxyFactory.CreateProxy<IAuditTrailWriter>(Context);
            auditTrailManagerproxy.WriteEntryEncrypted(eventType, auditData);
        }


    }
}
