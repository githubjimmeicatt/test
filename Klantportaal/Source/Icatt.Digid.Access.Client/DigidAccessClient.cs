using System;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using System.Xml.Serialization;
using Icatt.Digid.Access.Contract;
using Icatt.Digid.Access.Interface;
using Icatt.OAuth.Contract;
using Icatt.Security.Saml2.Engine.ArtifactResolutionRequest;
using Icatt.Security.Saml2.Engine.AuthnRequest;
using Icatt.Security.Saml2.Engine.Signing;
using Icatt.Security.Saml2.Saml.Contract;
using Icatt.ServiceModel;
using Icatt.Time;
using System.IO;
using System.Xml;

namespace Icatt.Digid.Access.Client
{
    

    public class DigidAccessClient<TContext> : ServiceBase<TContext>, IDigidAccess where TContext : class
    {
        //private readonly string _certificateSubject ;//= "CN=mijn.accept.pensioenfondshaskoningdhv.nl"; // "CN=mijn.accept.pensioenfondshaskoningdhv.nl, SERIALNUMBER=00000003623067230000, O=Stichting Pensioenfonds HaskoningDHV, L=Amersfoort, S=Utrecht, C=NL";
        //private readonly string _certificateIssuer ;//= "https://mijn.accept.pensioenfondshaskoningdhv.nl/metadata.xml";
        //private readonly string _\UresolveArtifactEndpoint;//= @"https://was-preprod1.digid.nl/saml/idp/resolve_artifact";
        //readonly StoreName _certificateStoreName;// = StoreName.My;
        //readonly StoreLocation _certificateStoreLocation;// = StoreLocation.LocalMachine;
        //private byte _assertionConsumerServiceIndex;
        //private string _requestAuthenticationEndpoint;
        private DigidSettings _settings;


        public DigidAccessClient(TContext context, IFactoryContainer<TContext> factoryContainer, DigidSettings settings) : base(context,factoryContainer)
        {
            _settings = settings;
        }

        public async Task<VerifyTokenResponse> VerifyTokenAsync(string samlArtefact)
        {

            var time = FactoryContainer.ProxyFactory.CreateProxy<ITimeMachine>(Context);

            var id = Guid.NewGuid().ToString("N"); // "_1234567"
            var issuer = _settings.CertificateIssuer;

            // Get certificate
            var clientCert = GetX509Certificate(StoreName.My,StoreLocation.LocalMachine, _settings.CertificateSubjectDistinguishedName, time);

            //Create XML
            var artefactResolutionEngine = new ArtifactResolutionRequestBuilder();
            var soapEnvelopeXml = artefactResolutionEngine.CreateSamlSoapEnvelope(samlArtefact, id, issuer, clientCert);


            //Create HTTP Post request
            var request = CreateHttpPostRequest(clientCert, _settings.ResolveArtifactEndpoint);

            //Post XML document
            using (var str = await request.GetRequestStreamAsync())
            {
                soapEnvelopeXml.Save(str);
            }

            //Get SAML response
            Envelope result = null;
            XmlDocument xmlResp = null;
            string respId = null;
            using (var httpResponse = await request.GetResponseAsync())
            {
                var serializer = new XmlSerializer(typeof(Envelope));

                var stream = httpResponse.GetResponseStream();

                var tr = new StreamReader(stream, System.Text.Encoding.UTF8);

                var xml = tr.ReadToEnd();

                xmlResp = new XmlDocument();
                xmlResp.PreserveWhitespace = true;
                xmlResp.LoadXml(xml);

                Debug.Assert(stream != null);

                using (var sr = new StringReader(xml))
                {
                    result = (Envelope)serializer.Deserialize(sr);
                    respId = result.Body.ArtifactResponse.ID;
                }


            }


            var artifactResponse = result?.Body?.ArtifactResponse;

            var responseStatus= artifactResponse?.Status?.StatusCode?.Value?.EndsWith(":success", StringComparison.OrdinalIgnoreCase);
            var callSucceeded = responseStatus.HasValue && responseStatus.Value;

            if (!callSucceeded)
            {
                return new VerifyTokenResponse
                {
                    Status = StatusCode.ServiceFailure
                };
            }

            var assertion = artifactResponse?.Response?.Assertion;


            var responseResponseStatus = artifactResponse?.Response?.Status?.StatusCode?.Value?.EndsWith(":success", StringComparison.OrdinalIgnoreCase);
            var authSuccess = responseResponseStatus.HasValue && responseResponseStatus.Value;

            if (!authSuccess)
            {
                //Authnfailed moet anders afgehandeld worden dan de rest. Alle andere codes afhandelen als service failure
                var statusStatus = artifactResponse?.Response?.Status?.StatusCode?.StatusCode;
                var isAuthn = statusStatus?.Value?.EndsWith(":authnfailed", StringComparison.OrdinalIgnoreCase);

                var code = (isAuthn.HasValue && isAuthn.Value) ? StatusCode.AuthnFailed : StatusCode.ServiceFailure;

                //Authentication failed (cancelled) 
                return new VerifyTokenResponse
                {
                    Status = code
                };
            }

            var nameId = assertion?.Subject?.NameID;
            if (string.IsNullOrWhiteSpace(nameId))
            {
                //Dit zou niet voor mogen komen bij status success... afhandelen als service failure
                return new VerifyTokenResponse
                {
                    Status = StatusCode.ServiceFailure
                };
            }


            //Check signature
            var se = new SamlSignatureEngine();
            if (!se.ValidateSamlSignatures(xmlResp.DocumentElement))
            {
                return new VerifyTokenResponse
                {
                    Status = StatusCode.InvalidArtifactSignature
                };
            }

            var sectorInfo = new SectorInfo(nameId);

            var verityTokenResponse = new VerifyTokenResponse
            {
                ClientIp = assertion.AuthnStatement?.SubjectLocality?.Address,
                Status = StatusCode.Success,
                Issuer = artifactResponse.Issuer,
                InResponseTo = artifactResponse.InResponseTo,
                Id = artifactResponse.ID,
                IssuedAt = artifactResponse.IssueInstant,
                Bsn = sectorInfo.Bsn,
                Sofi = sectorInfo.Sofi, //Personen geëmigreerd vóór introductie Bsn kunnen wel een DigiD login hebben maar krijgen dan een Sofinr terug
            };

            return verityTokenResponse;

        }

        public AuthenticationMethod AuthenticationMethod(string relayState)
        {
            if (relayState != null && relayState.Length > 80)
                throw new ArgumentOutOfRangeException(nameof(relayState), relayState.Length, $"{nameof(relayState)} is too large. The SAML standard limits it to 80 characters.");

            var id = Guid.NewGuid().ToString("N"); // "_1234567"

            var time = FactoryContainer.ProxyFactory.CreateProxy<ITimeMachine>(Context);

            var clientCert = GetX509Certificate(StoreName.My, StoreLocation.LocalMachine, _settings.CertificateSubjectDistinguishedName, time);

            if (clientCert == null)
                throw new Exception($"No certificate found in store {StoreName.My} at storelocation {StoreLocation.LocalMachine} with SubjectDistinguishedName {_settings.CertificateSubjectDistinguishedName}.");

            var authnRequestEngine = new AuthenticationRequestBuilder();

            var configuration = new AuthenticationRequestConfiguration()
            {
                Id = id,
                Issuer = _settings.CertificateIssuer,
                AssertionConsumerServiceIndex = _settings.AssertionConsumerServiceEndPointIndex,
                Destination = _settings.RequestAuthenticationEndpoint
            };

            var xmlDoc = authnRequestEngine.CreateRequest(configuration);

            // Sign metadata xml
            var signingEngine = new SamlSignatureEngine();
            var signature = signingEngine.CreateSignature(xmlDoc.DocumentElement, clientCert, "ID", id);

            Debug.Assert(xmlDoc.DocumentElement != null);

            var child = xmlDoc.DocumentElement.ChildNodes[0];
            xmlDoc.DocumentElement.InsertBefore(signature, child);

            //base 64 encoding van message in form
            var formdataBase64Message = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(xmlDoc.OuterXml));

            var method = new AuthenticationMethod()
            {
                Url = _settings.RequestAuthenticationEndpoint,
                Type = AuthMethodType.FormPost,
                Parameters = new[]
                {
                    new NameValuePair
                    {
                        Name= "SAMLRequest",
                        Value = formdataBase64Message
                    },
                    new NameValuePair
                    {
                        Name ="RelayState",
                        Value=relayState
                    }, 
                }
            };
            return method;
        }

        

        #region private helpers

       

        private static X509Certificate2 GetX509Certificate(StoreName storeName, StoreLocation storeLocation, string subjectDistinguishedName, ITimeMachine time)
        {

            X509Certificate2 cert;

            using (var store = new X509Store(storeName, storeLocation))
            {
                store.Open(OpenFlags.OpenExistingOnly | OpenFlags.ReadOnly);

                //  var find = store.Certificates.Find(X509FindType.FindByThumbprint, thumbprint, true);
      

                var find = store.Certificates.Find(X509FindType.FindBySubjectDistinguishedName, subjectDistinguishedName, true);

                var certEnum = find.OfType<X509Certificate2>();

                //Kies het langst geldige certificaat dat nu geldig is.
                cert = certEnum
                //    .Where(c => c.NotBefore < time.UtcNow && c.NotAfter > time.UtcNow)
                     .OrderByDescending(c => c.NotAfter)
                     .FirstOrDefault();

                store.Close();

            }

            return cert;
        }


        private static HttpWebRequest CreateHttpPostRequest(X509Certificate clientCert,string url)
        {
            Debug.Assert(url != null);
            Debug.Assert(clientCert != null);

            var webRequest = (HttpWebRequest)WebRequest.Create(url);

            webRequest.ContentType = "text/xml;charset=\"utf-8\"";
            webRequest.Accept = "text/xml";
            webRequest.Method = "POST";
            webRequest.ClientCertificates.Add(clientCert);

            return webRequest;
        }

        #endregion

    }
}
