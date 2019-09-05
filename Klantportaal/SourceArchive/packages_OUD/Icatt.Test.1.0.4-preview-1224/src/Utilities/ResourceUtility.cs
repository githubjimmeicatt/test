using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Test.Utilities
{
    public static class ResourceUtility
    {


        public static string GetString(string resourceName,Type typeFromAssemblyContainingResource = null)
        {
            var assemblyContainingResource = AssemblyContainingResource(typeFromAssemblyContainingResource);


            using (var stream = assemblyContainingResource.GetManifestResourceStream(resourceName))
            {
                if (stream == null) return null;

                using (var reader = new StreamReader(stream)) return reader.ReadToEnd();

            }
        }

        public static string GetString(string resourceName, Encoding encoding, Type typeFromAssemblyContainingResource = null)
        {
            var assemblyContainingResource = AssemblyContainingResource(typeFromAssemblyContainingResource);


            using (var stream = assemblyContainingResource.GetManifestResourceStream(resourceName))
            {
                if (stream == null) return null;

                using (var reader = new StreamReader(stream,encoding)) return reader.ReadToEnd();

            }
        }

        private static Assembly AssemblyContainingResource(Type typeFromAssemblyContainingResource)
        {
            var assemblyContainingResource = typeFromAssemblyContainingResource == null
                ? Assembly.GetExecutingAssembly()
                : typeFromAssemblyContainingResource.Assembly;
            return assemblyContainingResource;
        }

        public static byte[] GetBytes(string resourceName, Type typeFromAssemblyContainingResource = null)
        {
            var assemblyContainingResource = AssemblyContainingResource(typeFromAssemblyContainingResource);

            using (var stream = assemblyContainingResource.GetManifestResourceStream(resourceName))
            {
                if (stream == null) return null;
                var buffer = new byte[stream.Length];

                var count = stream.Read(buffer, 0, buffer.Length);

                return buffer;

            }
        }

        public static Stream GetStream(string resourceName, Type typeFromAssemblyContainingResource = null)
        {
            var assemblyContainingResource = AssemblyContainingResource(typeFromAssemblyContainingResource);

            return assemblyContainingResource.GetManifestResourceStream(resourceName);
        }

        public static string[] GetResourceNames(Type typeFromAssemblyContainingResource)
        {
            var assemblyContainingResource = AssemblyContainingResource(typeFromAssemblyContainingResource);
            return assemblyContainingResource.GetManifestResourceNames();
        }


    }

}
