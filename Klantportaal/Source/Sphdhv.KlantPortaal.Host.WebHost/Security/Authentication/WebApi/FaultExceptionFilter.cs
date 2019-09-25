﻿using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.WebApi.MijnPensioen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http.Filters;
using System.Web.Security;

namespace Sphdhv.KlantPortaal.Host.WebHost.Security.Authentication.WebApi
{
    public class FaultExceptionFilter : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            var ex = context.Exception;

            if (!(ex is FaultException || ex is FaultException)) return;

            context.Response = new HttpResponseMessage();
            context.Response.Content = new ObjectContent<ResponseModel<ActueelPensioenModel>>(
                new ResponseModel<ActueelPensioenModel>(400, ex.Message),
                new JsonpFormatter(context.Request)
            );

            base.OnException(context);
        }
    }
}