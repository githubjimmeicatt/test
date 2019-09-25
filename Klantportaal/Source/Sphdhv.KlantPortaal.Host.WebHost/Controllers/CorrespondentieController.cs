﻿using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Security;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract;
using Sphdhv.KlantPortaal.Manager.MijnPensioen.Interface;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using Sphdhv.Security.Manager.Authentication.Interface;
using Sphdhv.KlantPortaal.Host.WebHost.Security.CsrfProtection.WebApi;
using Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi;
using System.Net;
using System.Net.Http.Headers;
using System.Security.Authentication;
using Icatt.ServiceModel;
using System;

namespace Sphdhv.KlantPortaal.Host.WebHost.Controllers
{
    public class CorrespondentieController : ApiController
    {

        [HttpGet]
        [CsrfProtected]
        [AuthenticationExceptionFilter]
        [GeneralExceptionFilter]
        public async Task<ResponseModel<CorrespondentieOverzicht>> CorrespondentieOverzicht()
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();

            (context as IAuthenticationTicket).AuthenticationTicket = Utilities.Cookies.GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            var proxy = factoryContainer.ProxyFactory.CreateProxy<IMijnPensioenManager>(context);
            try
            {
                var result = new ResponseModel<CorrespondentieOverzicht>(await proxy.DocumentenAsync());
                return result;
            }
            catch (HttpRequestException ex)
            {
                return new ResponseModel<CorrespondentieOverzicht>(400, ex.Message);
            }
            
        }

        [HttpGet]
        [GeneralExceptionFilter ]
        public async Task<HttpResponseMessage> OpenFile(string documentId)
        {
            var factoryContainer = new KlantPortaalFactoryContainer();
            var context = new KlantPortaalContext();
            (context as IAuthenticationTicket).AuthenticationTicket = Utilities.Cookies.GetCookie(ControllerContext.Request, FormsAuthentication.FormsCookieName);

            Document file;
           
            var proxy = factoryContainer.ProxyFactory.CreateProxy<IMijnPensioenManager>(context);
            file = await proxy.DownloadDocumentAsync(documentId);
           
           if(file == null)
            {
                return StatusResponse(HttpStatusCode.NotFound);
            }


            var response = new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new ByteArrayContent(file.Bytes)
            };
            response.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment");
            response.Content.Headers.ContentType = new MediaTypeHeaderValue(file.MediaType);
            response.Content.Headers.ContentDisposition.FileName = file.Filename;

            return response;
        }

        private HttpResponseMessage  StatusResponse(HttpStatusCode code)
        {
            var response = Request.CreateResponse(code);
            response.Headers.Location = new Uri(Properties.Settings.Default.DnnMijnOmgevingUrl);
            return response;
        }
    }
}
