using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Icatt.Heartcore.Config;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;

namespace DHV.Umbraco.Features.Renderer
{
    public class GetAssets
    {
        private const string ManifestFileName = "manifest.json";
        private readonly IMemoryCache _memoryCache;
        private readonly IWebHostEnvironment _env;
        private readonly IPortalConfig _portalConfig;
        private readonly IFileProvider _fileProvider;
        private static readonly IAsset[] s_fonts =
        {
            new Link{ Href = "https://fonts.gstatic.com/s/sarabun/v8/DtVmJx26TKEr37c9YNpoilss6w.woff2", Rel = "preload", As = "font", Type ="font/woff2", CrossOrigin = true },
            new Link{ Href = "https://fonts.gstatic.com/s/sarabun/v8/DtVmJx26TKEr37c9YL5rilss6w.woff2", Rel = "preload", As = "font", Type ="font/woff2", CrossOrigin = true },
            new Link{ Href = "https://fonts.gstatic.com/s/sarabun/v8/DtVmJx26TKEr37c9YOZqilss6w.woff2", Rel = "preload", As = "font", Type ="font/woff2", CrossOrigin = true },
            new Link{ Href = "https://fonts.gstatic.com/s/sarabun/v8/DtVmJx26TKEr37c9YMptilss6w.woff2", Rel = "preload", As = "font", Type ="font/woff2", CrossOrigin = true },
        };

        public GetAssets(IMemoryCache memoryCache, IWebHostEnvironment env, IPortalConfig portalConfig)
        {
            _memoryCache = memoryCache;
            _env = env;
            _portalConfig = portalConfig;
            _fileProvider = env.WebRootFileProvider;
        }

        public async ValueTask<IReadOnlyCollection<IAsset>> Get(CancellationToken token)
        {
            if (_env.IsDevelopment())
            {
                return Array.Empty<IAsset>();
            }

            if (!_memoryCache.TryGetValue(ManifestFileName, out var cacheEntry))
            {
                var path = _fileProvider.GetFileInfo(ManifestFileName).PhysicalPath;
                await using var stream = File.OpenRead(path);
                var manifest = await JsonSerializer.DeserializeAsync<IReadOnlyDictionary<string, ViteAsset>>(stream, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }, token);
                var entry = manifest.Values.Where(x => x.IsEntry).FirstOrDefault();
                if (entry != null)
                {
                    var result = new List<IAsset>(s_fonts);

                    if (entry.Css != null && entry.Css.Any())
                    {
                        result.AddRange(entry.Css.Select(x => new Link
                        {
                            Rel = "stylesheet",
                            Href = '/' + x
                        }));
                    }

                    if (entry.Imports != null && entry.Imports.Any())
                    {
                        result.AddRange(entry.Imports.Select(x => new Link
                        {
                            Rel = "modulepreload",
                            Href = '/' + manifest[x].File
                        }));
                    }

                    result.Add(new Script
                    {
                        Src = '/' + entry.File,
                        Type = "module"
                    });

                    // Configure the cache entry options for a five minute
                    // sliding expiration and use the change token to
                    // expire the file in the cache if the file is
                    // modified.
                    var cacheEntryOptions = new MemoryCacheEntryOptions()
                        .SetSlidingExpiration(TimeSpan.FromMinutes(15))
                        .AddExpirationToken(_fileProvider.Watch(ManifestFileName));

                    cacheEntry = result;
                    _memoryCache.Set(ManifestFileName, cacheEntry, cacheEntryOptions);
                }
            }

            var list = (IEnumerable<IAsset>)cacheEntry ?? Enumerable.Empty<IAsset>();
            var iconName = _portalConfig.TryGetPortal(out var portal) ? portal.Logo ?? portal.Theme : "favicon";

            return list.Append(new Link
            {
                Rel = "shortcut icon",
                Href = "/" + iconName + ".ico"
            }).ToList();
        }
    }


    public class ViteAsset
    {
        public string File { get; set; }
        public string Src { get; set; }
        public bool IsEntry { get; set; }
        public string[] Imports { get; set; }
        public string[] Css { get; set; }
    }


    public interface IAsset
    {

    }

    public class Script : IAsset
    {
        public string Src { get; set; }
        public string Type { get; set; }
    }

    public class Link : IAsset
    {
        public string Href { get; set; }
        public string Rel { get; set; }
        public string As { get; internal set; }
        public string Type { get; internal set; }
        public bool CrossOrigin { get; internal set; }
    }
}
