using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;

namespace Sphdhv.KlantPortaal.Host.WebHost.Utilities
{
    internal static class Cookies
    {
        internal static string GetCookie(HttpRequestMessage request, string key)
        {

            var authCookie = request.Headers.GetCookies(key).FirstOrDefault();
            if (authCookie == null)
                return null;

            return authCookie[key].Value;
        }
    }
}