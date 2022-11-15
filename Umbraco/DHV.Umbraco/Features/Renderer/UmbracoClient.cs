using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using AngleSharp.Html.Parser;
using Icatt.Heartcore.Config;
using Icatt.Heartcore.Umbraco.Menu;
using Microsoft.Extensions.Logging;
using Schema.NET;
using MenuItem = Icatt.Heartcore.Umbraco.Menu.MenuItem;

namespace DHV.Umbraco.Features.Renderer
{
    public interface IUmbracoClient
    {
        Task<Head> GetHeadAsync(string baseUri, string path, CancellationToken token);
        Head GetHead404();
    }

    public class Head
    {
        public static readonly Head Empty = new();

        public Head(string initialState = null, string title = null, string contentType = null, string jsonLd = null, IReadOnlyCollection<Meta> meta = null, Portal portal = null, string redirect = null, IReadOnlyCollection<MenuItem> menu = null)
        {
            InitialState = initialState ?? string.Empty;
            Title = title ?? string.Empty;
            ContentType = contentType ?? string.Empty;
            JsonLd = jsonLd ?? string.Empty;
            Meta = meta ?? Array.Empty<Meta>();
            Portal = portal;
            Redirect = redirect ?? string.Empty;
            Menu = menu ?? Array.Empty<MenuItem>();
        }

        public string InitialState { get; }
        public string Title { get; }
        public string ContentType { get; }
        public string JsonLd { get; }
        public IReadOnlyCollection<Meta> Meta { get; }
        public Portal Portal { get; }
        public string Redirect { get; }
        public IReadOnlyCollection<MenuItem> Menu { get; }
    }

    public class Meta
    {
        public Meta(string property = null, string name = null, string content = null)
        {
            Property = property;
            Name = name;
            Content = content;
        }

        public string Property { get; }
        public string Name { get; }
        public string Content { get; }
    }

    public class RedirectPageModel
    {
        [JsonPropertyName("_id")]
        public Guid Id { get; set; }

        [JsonPropertyName("redirect")]
        public HasUrl Redirect { get; set; }
    }

    public class HasUrl
    {
        [JsonPropertyName("_url")]
        public string Url { get; set; }
    }

    public class UmbracoClient : IUmbracoClient
    {
        private const int MenuDepth = 3;

        private static readonly HtmlParser s_htmlParser = new();

        private static readonly string[] s_descriptionProperties = new[] { "seoDescription", "summary", "body" };
        private static readonly string[] s_titleProperties = new[] { "seoTitle", "title", "name" };

        // Uncomment deze regel als de umbraco cdn resize functie stuk ik
        //private static readonly string[] s_imageProperties = new[] { "seoImage._url", "image._url", "pageHeader.backgroundImage._url" };
        private static readonly string[] s_imageProperties = new[] { "seoImage.umbracoFile.focalPointUrlTemplate", "image.umbracoFile.focalPointUrlTemplate", "pageHeader.backgroundImage.umbracoFile.focalPointUrlTemplate" };

        private readonly HttpClient _httpClient;
        private readonly IPortalConfig _portalConfig;
        private readonly ILogger<UmbracoClient> _log;
        private readonly IMenuManager _menuManager;

        public UmbracoClient(HttpClient httpClient, IPortalConfig portalConfig, ILogger<UmbracoClient> log, IMenuManager menuManager)
        {
            _httpClient = httpClient;
            _portalConfig = portalConfig;
            _log = log;
            _menuManager = menuManager;
        }

        public async Task<Head> GetHeadAsync(string baseUri, string path, CancellationToken token)
        {
            if (string.IsNullOrWhiteSpace(baseUri))
            {
                throw new ArgumentNullException(nameof(baseUri));
            }

            path ??= "";
            path = '/' + path.Trim('/');
            baseUri = baseUri.Trim('/');
            var fullUri = new Uri(baseUri + path);

            var umbracoPath = path;

            if (_portalConfig.TryGetPortal(out var portal) && !string.IsNullOrWhiteSpace(portal.Prefix))
            {
                umbracoPath = '/' + portal.Prefix.Trim('/') + path;
            }

            var menu = await _menuManager.GetMenuAsync(portal.UmbracoId, MenuDepth, token);

            // TODO: nette afhandeling van custom pagina's
            if ("/zoeken".Equals(path, StringComparison.OrdinalIgnoreCase))
            {
                return new(portal: portal, menu: menu);
            }

            var query = HttpUtility.UrlEncode(umbracoPath);
            using var response = await _httpClient.GetAsync($"url?url={query}", token);

            if (response.IsSuccessStatusCode)
            {
                var initialState = await response.Content.ReadAsStringAsync(token);
                var scriptTagRegEx = new Regex(@"<script[^>]*>[\s\S]*?</script>");
                var stateWithoutScriptTags = scriptTagRegEx.Replace(initialState, "");
                return await GetHead(fullUri, portal, stateWithoutScriptTags, menu, token);
            }

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
            {
                var redirectUrl = await GetRedirectUrl(umbracoPath, portal, token);

                return !string.IsNullOrWhiteSpace(redirectUrl)
                    ? (new(redirect: redirectUrl))
                    : null;
            }

            return new(portal: portal);
        }



        private async Task<Head> GetHead(Uri uri, Portal portal, string initialState, IReadOnlyList<MenuItem> menu, CancellationToken token)
        {
            const string SiteName = "SPH";
            using var doc = JsonDocument.Parse(initialState);
            var json = doc.RootElement;

            if (json.TryGetNonWhitespaceStringProperty("contentTypeAlias", out var contentType)
                && contentType.StartsWith("redirect", StringComparison.OrdinalIgnoreCase))
            {
                var redirectPage = JsonSerializer.Deserialize<RedirectPageModel>(initialState);
                var redirectUrl = UnPrefixUrl(portal, redirectPage?.Redirect?.Url);
                if (string.IsNullOrWhiteSpace(redirectUrl))
                {
                    _log.LogError("redirect pagina met id {PageId} bevat geen url om naar te redirecten", redirectPage?.Id);
                    return null;
                }

                return new(redirect: redirectUrl);
            }

            json.TryGetFirstNonWhitespaceStringProperty(s_titleProperties, out var title);
            json.TryGetFirstNonWhitespaceStringProperty(s_descriptionProperties, out var description);
            json.TryGetFirstNonWhitespaceStringProperty(s_imageProperties, out var imageUrl);

            json.TryGetNonWhitespaceStringProperty("_writerName", out var author);
            json.TryGetNonWhitespaceStringProperty("keywords", out var keywords);
            json.TryGetNonWhitespaceStringProperty("_createDate", out var createDate);
            json.TryGetNonWhitespaceStringProperty("_updateDate", out var updateDate);

            if (!string.IsNullOrWhiteSpace(description))
            {
                description = GetInnerText(description);

                if (description.Length > 150)
                {
                    description = description[0..147] + "...";
                }
            }

            if (!string.IsNullOrWhiteSpace(title))
            {
                title = GetInnerText(title);
            }

            if (string.IsNullOrWhiteSpace(imageUrl) && json.TryGetNonWhitespaceStringProperty("_url", out var umbracoUrl))
            {
                var splitSlash = umbracoUrl.Split('/', StringSplitOptions.RemoveEmptyEntries);

                if (splitSlash.Length > 1)
                {
                    // de huidige pagina is in dit geval niet de homepagina van de portal, dus die kunnen we ophalen als fallback
                    var portalHomeUrl = splitSlash[0];
                    using var homeResponse = await _httpClient.GetAsync($"url?url=/{portalHomeUrl}", token);

                    if (homeResponse.IsSuccessStatusCode)
                    {
                        await using var homeStream = await homeResponse.Content.ReadAsStreamAsync(token);
                        using var homeDoc = await JsonDocument.ParseAsync(homeStream, default, token);
                        homeDoc.RootElement.TryGetFirstNonWhitespaceStringProperty(s_imageProperties, out imageUrl);
                    }
                }
            }
            if (!string.IsNullOrWhiteSpace(imageUrl))
            {
                // aanbevolen afmetingen van twitter:image en og:image
                imageUrl = imageUrl.Replace("{width}", "1200").Replace("{height}", "630");
            }

            var meta = new List<Meta>
            {
                new (content: "article", property : "og:type"),
                new (content: uri?.ToString(), property : "og:url"),
                new (content: title, name: "title"),
                new (content: title, property : "og:title"),
                new (content: "nl_NL", property: "og:locale"),
                new (content: SiteName, property : "og:site_name"),
                new (content: author, name: "author"),
                new (content: "summary_large_image", name: "twitter:card"),
                new (content: title, name: "twitter:title")
            };

            if (!string.IsNullOrWhiteSpace(createDate))
            {
                meta.Add(new(content: createDate, name: "article:published_time"));
                meta.Add(new(content: createDate, property: "og:publish_date"));
            }

            if (!string.IsNullOrWhiteSpace(updateDate))
            {
                meta.Add(new(content: updateDate, name: "article:modified_time"));
            }

            if (!string.IsNullOrWhiteSpace(description))
            {
                meta.Add(new(property: "og:description", content: description));
                meta.Add(new(name: "description", content: description));
                meta.Add(new(name: "twitter:description", content: description));
            }
            if (!string.IsNullOrWhiteSpace(keywords))
            {
                meta.Add(new(name: "keywords", content: keywords));
            }
            if (!string.IsNullOrWhiteSpace(imageUrl))
            {
                meta.Add(new(name: "image", content: imageUrl));
                meta.Add(new(property: "og:image", content: imageUrl));
                meta.Add(new(name: "twitter:image", content: imageUrl));
            }

            var jsonLd = new NewsArticle
            {
                MainEntityOfPage = new WebPage { Id = uri },
                Headline = title,
                Author = new Person { Name = author },
                Publisher = new Organization
                {
                    Name = SiteName
                },
                Description = description,
            };

            if (Uri.TryCreate(imageUrl, UriKind.Absolute, out var imageUri))
            {
                jsonLd.Image = new ImageObject { Url = imageUri };
            }

            if (DateTime.TryParse(createDate, out var createDateTime))
            {
                jsonLd.DatePublished = createDateTime;
            }

            if (DateTime.TryParse(updateDate, out var updateDateTime))
            {
                jsonLd.DateModified = updateDateTime;
            }

            return new(
                initialState: initialState,
                menu: menu,
                contentType: contentType,
                title: title,
                jsonLd: jsonLd.ToString(),
                meta: meta,
                portal: portal
            );
        }



        private async Task<string> GetRedirectUrl(string url, Portal portal, CancellationToken token)
        {
            if (!_httpClient.DefaultRequestHeaders.TryGetValues("Umb-Project-Alias", out var values))
            {
                return null;
            }

            var projectAlias = values.FirstOrDefault();

            if (string.IsNullOrWhiteSpace(projectAlias))
            {
                return null;
            }


            var stripped = url.Trim('/');
            using var result = await _httpClient.GetAsync($"https://{projectAlias}.euwest01.umbraco.io/umbraco/backoffice/UmbracoApi/RedirectUrlManagement/SearchRedirectUrls?searchTerm=%2f{HttpUtility.UrlEncode(stripped)}", token);

            if (!result.IsSuccessStatusCode)
            {
                return null;
            }

            await using var stream = await result.Content.ReadAsStreamAsync(token);
            using var json = await JsonDocument.ParseAsync(stream, cancellationToken: token);

            if (json.RootElement.ValueKind != JsonValueKind.Object || !json.RootElement.TryGetProperty("searchResults", out var resultElement) || resultElement.ValueKind != JsonValueKind.Array)
            {
                return null;
            }

            foreach (var item in resultElement.EnumerateArray())
            {
                if (item.TryGetNonWhitespaceStringProperty("originalUrl", out var originalUrl)
                    && originalUrl.Trim('/').Equals(stripped, StringComparison.OrdinalIgnoreCase)
                    && item.TryGetNonWhitespaceStringProperty("destinationUrl", out var destinationUrl))
                {
                    return UnPrefixUrl(portal, destinationUrl);
                }
            }

            return null;
        }

        private static string UnPrefixUrl(Portal portal, string destinationUrl) =>
            portal?.RemovePrefix(destinationUrl);

        public Head GetHead404()
        {

            Portal portal = null;

            if (_portalConfig.TryGetPortal(out var p))
            {
                portal = p;
            }
            return new(portal: portal);

        }

        private static string GetInnerText(string inputStr) => string.Concat(s_htmlParser.ParseFragment(inputStr, null).Select(x => x.TextContent));
    }

    public static class Extensions
    {
        public static bool TryGetNonWhitespaceStringProperty(this JsonElement element, string propName, out string value)
        {
            value = string.Empty;

            if (element.ValueKind != JsonValueKind.Object)
            {
                return false;
            }

            var splitOnDot = propName.Split('.');

            if (splitOnDot.Length > 1)
            {
                if (!element.TryGetProperty(splitOnDot[0], out var inner))
                {
                    return false;
                }
                var rest = string.Join('.', splitOnDot.Skip(1));
                return inner.TryGetNonWhitespaceStringProperty(rest, out value);
            }

            if (!element.TryGetProperty(propName, out var prop) || prop.ValueKind != JsonValueKind.String)
            {
                return false;
            }

            value = prop.GetString();
            return !string.IsNullOrWhiteSpace(value);
        }

        public static bool TryGetFirstNonWhitespaceStringProperty(this JsonElement element, string[] propNames, out string value)
        {
            foreach (var propName in propNames)
            {
                if (element.TryGetNonWhitespaceStringProperty(propName, out value))
                {
                    return true;
                }
            }

            value = string.Empty;
            return false;
        }
    }
}
