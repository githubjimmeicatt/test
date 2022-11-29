using System;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Primitives;

namespace Icatt.Heartcore.Umbraco
{
    public interface IUmbracoSecureFileProvider : IFileProvider
    {
        string GetRootPath();
    }

    internal sealed class UmbracoSecureFileProvider : IUmbracoSecureFileProvider, IDisposable
    {
        private readonly PhysicalFileProvider _inner;

        public UmbracoSecureFileProvider(IWebHostEnvironment environment)
        {
            var parentFolder = Directory.GetParent(environment?.ContentRootPath.TrimEnd('\\')).FullName;
            var dataRoot = Path.Combine(parentFolder, "Data");
            Directory.CreateDirectory(dataRoot);
            _inner = new PhysicalFileProvider(dataRoot);
        }

        public void Dispose()
        {
            _inner.Dispose();
        }

        public IDirectoryContents GetDirectoryContents(string subpath) => _inner.GetDirectoryContents(subpath);

        public IFileInfo GetFileInfo(string subpath) => _inner.GetFileInfo(subpath);

        public string GetRootPath() => GetFileInfo("/").PhysicalPath;

        public IChangeToken Watch(string filter) => _inner.Watch(filter);
    }
}
