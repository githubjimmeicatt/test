using DotNetNuke.Common;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;

namespace Sphdhv.DnnWebApi.Controllers
{
    public class DeelnemerController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage VerifyEmail(Guid guid)
        {
            var redirectUrl = "";
            var verifyEmailEndpoint = "/#start$verifyemail$" + guid.ToString("N");
            var user = UserController.Instance.GetCurrentUserInfo();
            if (null != user)
            {
                var isMijnDhvUser = user.IsInRole(AuthenticationController.KnownRoleName.MijnDhvRoleName);
                if (isMijnDhvUser)
                {
                    var baseUrl = RequestContext.Url.Request.RequestUri.GetComponents(UriComponents.Scheme | UriComponents.HostAndPort, UriFormat.Unescaped);
                    redirectUrl = $"{baseUrl}{verifyEmailEndpoint}";
                }
            }
            if (string.IsNullOrEmpty(redirectUrl))
            {
                redirectUrl = GetLoginUrl(PortalController.Instance.GetCurrentPortalSettings(), System.Web.HttpUtility.UrlEncode(verifyEmailEndpoint));
            }
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            response.Headers.Location = new Uri(redirectUrl);
            return response;
        }

        private string GetLoginUrl(PortalSettings portalSettings, string returnUrl)
        {
            string controlKey = "Login";

            int tabId = portalSettings.ActiveTab.TabID;
            if (!Null.IsNull(portalSettings.LoginTabId) && string.IsNullOrEmpty(Request.GetQueryNameValuePairs().Where(p => "override" == p.Key).Select(p => p.Value).FirstOrDefault()))
            {
                // user defined tab
                controlKey = string.Empty;
                tabId = portalSettings.LoginTabId;
            }
            else if (!Null.IsNull(portalSettings.HomeTabId))
            {
                // portal tab
                tabId = portalSettings.HomeTabId;
            }

            // else current tab
            return Globals.NavigateURL(tabId, controlKey, new string[] { "returnurl=" + returnUrl });
        }
    }

}
