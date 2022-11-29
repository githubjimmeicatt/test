using System;
using System.IO;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Icatt.Heartcore.Data;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using Refit;
using Umbraco.Headless.Client.Net.Delivery;
using Umbraco.Headless.Client.Net.Management;
using ManagementMedia = Umbraco.Headless.Client.Net.Management.Models.Media;

namespace Icatt.Heartcore.Umbraco
{
    public class HeartcoreMediaManager : IHeartcoreMediaManager
    {
        private readonly IContentManagementService _contentManagement;
        private readonly IContentDeliveryService _contentDelivery;
        private readonly IUmbracoSecureFileProvider _fileProvider;
        private readonly ILogger<HeartcoreMediaManager> _log;
        private readonly IPortalConfig _portalConfig;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly UmbracoHeartcoreConfig _umbracoHeartcoreConfig;
        private readonly Uri _baseUri;

        public HeartcoreMediaManager(
            IContentManagementService contentManagement,
            IContentDeliveryService contenDelivery,
            IUmbracoSecureFileProvider fileProvider,
            ILogger<HeartcoreMediaManager> log,
            IPortalConfig portalConfig,
            IHttpContextAccessor httpContextAccessor,
            UmbracoHeartcoreConfig umbracoHeartcoreConfig)
        {
            _contentManagement = contentManagement;
            _contentDelivery = contenDelivery;
            _fileProvider = fileProvider;
            _log = log;
            _portalConfig = portalConfig;
            _httpContextAccessor = httpContextAccessor;
            _umbracoHeartcoreConfig = umbracoHeartcoreConfig;
            _baseUri = new Uri(_umbracoHeartcoreConfig.BackofficeUrl);
        }

        public async Task<string> SaveMedia(UmbracoMedia model)
        {
            var media = await _contentManagement.Media.GetById(model.Id);
            if (media.MediaTypeAlias == "Folder")
            {
                return "";
            }

            var result = await IsSecureMedia(media.ParentId);
            if (result)
            {
                var secureResult = await SecureMedia(media.Id);
                return secureResult;
            }
            return "";
        }

        public async Task<bool> DeleteMedia(UmbracoMedia model)
        {
            ManagementMedia media = null;

            try
            {
                media = await _contentManagement.Media.GetById(model.Id);
            }
            catch (ApiException e)
            {
                if (e.StatusCode != System.Net.HttpStatusCode.NotFound)
                {
                    throw;
                }
            }

            if (media == null)
            {
                _log.LogWarning("Tried to delete Media {UmbracoMedia}, but not found in umbraco", model.Id);
                return false;
            }

            var path = GetPath(media);

            if (string.IsNullOrWhiteSpace(path) ||
                !DeleteFolderRecursive(path.Split('/', StringSplitOptions.RemoveEmptyEntries).First()))
            {
                _log.LogWarning("Tried to delete Media {UmbracoMedia}, but not found on disk", model.Id);
                return false;
            }

            _log.LogInformation("Deleted Media {UmbracoMedia}", model.Id);
            return true;
        }


        private bool AlreadyProcessed(string path) => File.Exists(GetMarkerPath(path));
        private string GetMarkerPath(string path) => GetFullPath(path) + "_MARKER";
        private string GetFullPath(string path) => Path.Combine(_fileProvider.GetRootPath(), path);
        private void CreateMarkerFile(string path) => File.Create(GetMarkerPath(path)).Dispose();
        private void DeleteMarkerFile(string path) => File.Delete(GetMarkerPath(path));

        private bool DeleteFolderRecursive(string path)
        {
            if (string.IsNullOrWhiteSpace(path) || path == "/" || path == "\\")
            {
                _log.LogError("Root folders mogen niet recursive gedelete worden.");
                return false;
            }
            path = GetFullPath(path);
            if (!Directory.Exists(path))
            {
                return false;
            }
            Directory.Delete(path, true);
            return true;
        }

        private async Task<string> DownloadFile(string url, string folder)
        {
            folder = GetFullPath(folder);
            var filename = Path.GetFileName(url.Split("?").First());
            var filePath = Path.Combine(folder, filename);
            Directory.CreateDirectory(folder);

            _log.LogInformation("downloaded secure file to {path}", filePath);

            using var wc = new System.Net.WebClient();
            await wc.DownloadFileTaskAsync(new Uri(url), filePath);
            return filePath;
        }

        private async Task<string> SecureMedia(Guid mediaId)
        {
            var mediaTask = _contentManagement.Media.GetById(mediaId);
            var mediaDelivery = await _contentDelivery.Media.GetById(mediaId);
            var media = await mediaTask;

            var parts = mediaDelivery.Url.Split('/', StringSplitOptions.RemoveEmptyEntries);
            var alias = parts[2];

            //bedankt Umbraco!!! na uploaden in heartcore dev omgeving gewoon zelf de verkeerde media url teruggeven....
            if (alias != _umbracoHeartcoreConfig.UmbProjectAlias.ToLower())
            {
                _log.LogError("{UmbracoMedia} heeft geen correcte umbracoalias ", media.Id);
            }
            var folder = parts[3];
            var path = GetPath(media);

            if (folder.Length != 8)
            {
                _log.LogError("{UmbracoMedia} heeft geen correcte umbraco folder ", media.Id);
            }

            if (AlreadyProcessed(path))
            {
                // onze eigen wijziging onderaan deze method zorgt ook weer voor een trigger van de webhook. Daarom kunnen we deze negeren
                DeleteMarkerFile(path);
                _log.LogInformation("Marker file verwijderd voor {UmbracoMedia}", media.Id);
                return "markerfile deleted";
            }

            DeleteFolderRecursive(folder);

            // hack: url aanpassen zodat we cache kunnen busten. anders krijgen we de gecachte, geblurde versie van het bestand
            var alternativeUrl = new Uri(_baseUri, $"media/{path}?{Guid.NewGuid():N}").ToString();
            var filePath = await DownloadFile(alternativeUrl, folder);
            var fileName = Path.GetFileName(filePath);


            object umbracoFileValue = "";

            if (media.MediaTypeAlias == "Image")
            {
                filePath = await ImageEngine.Blur(filePath, 10);
                umbracoFileValue = new { src = fileName };
            }

            if (media.MediaTypeAlias == "File")
            {
                filePath = Path.GetFullPath("Assets/dummy.txt");
                //fileName += ".txt";
                umbracoFileValue = media.Properties["umbracoFile"];
            }

            CreateMarkerFile(path);

            var contentType = HeyRed.Mime.MimeTypesMap.GetMimeType(fileName);
            media.SetValue("umbracoFile", umbracoFileValue, new FileInfoPart(new FileInfo(filePath), fileName, contentType));

            var updateResult = await _contentManagement.Media.Update(media);

            var hasError = updateResult == null || updateResult.Id == default;

            if (hasError)
            {
                var error = updateResult != null && updateResult.Properties.TryGetValue("error", out var errObj) && errObj is JObject jObj ? jObj : null;
                _log.LogError("Error securing {UmbracoMedia}: {UmbracoError}", media.Id, error?.ToString());
            }
            else
            {
                _log.LogInformation("{UmbracoMedia} is secured", updateResult.Id);
            }

            return !hasError ? "Media secured" : "Media could not be secured";
        }

        private async Task<bool> IsSecureMedia(Guid? mediaId)
        {
            if (!mediaId.HasValue) return false;
            var protectedFolderIds = _portalConfig.ProtectedMediaFolderIds();

            var media = await _contentManagement.Media.GetById(mediaId.Value);
            if (protectedFolderIds.Contains(media.Id))
            {
                return true;
            }

            if (media.ParentId.HasValue)
            {
                return await IsSecureMedia(media.ParentId);
            }

            return false;
        }

        private string GetPath(ManagementMedia media)
        {

            if (media.Properties.TryGetValue("umbracoFile", out var val))
            {
                string umbracoPath = null;

                if (val is JObject jObject && jObject.TryGetValue("src", out var src) && src.Type == JTokenType.String)
                {
                    umbracoPath = src.Value<string>();
                }
                else if (val is string @string)
                {
                    umbracoPath = @string;
                }

                return string.Join('/', umbracoPath.Split('/', StringSplitOptions.RemoveEmptyEntries).Skip(1));
            }
            else
            {
                _log.LogError("{UmbracoMedia} heeft geen correcte umbraco folder ", media.Id);
                return null;
            }

        }
    }

    public class UmbracoMedia
    {
        [JsonPropertyName("_id")]
        public Guid Id { get; set; }
    }
}
