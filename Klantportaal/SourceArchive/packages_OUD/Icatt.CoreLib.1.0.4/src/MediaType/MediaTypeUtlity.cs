using System;
using System.Collections.Generic;
using System.IO;
using System.Resources;

namespace Icatt.MediaType
{
    public static class MediaTypeUtlity
    {
        private static System.Resources.ResourceManager _resourceMan;
        private static object _lock = new object();

        internal static System.Resources.ResourceManager ResourceManager
        {
            get
            {
                if (ReferenceEquals(_resourceMan, null))
                {
                    lock (_lock)
                    {
                        if (ReferenceEquals(_resourceMan, null))
                        {
                            var temp = new ResourceManager("Icatt.MediaType.MediaTypes",
                                typeof (MediaTypeUtlity).Assembly);
                            _resourceMan = temp;
                        }                        
                    }
                }
                return _resourceMan;
            }
        }


        /// <summary>
        /// MIME (Multipurpose Internet Mail Extensions) type or Internet Media Type acoording to this source: http://www.sitepoint.com/web-foundations/mime-types-complete-list/ 
        /// </summary>
        /// <param name="filename">Any valid windows path</param>
        /// <returns>NULL if no MIME type is found or an empty string is passed</returns>
        /// <exception cref="ArgumentException">Thrown when <paramref name="filename"/> conains illegal characters for a windows path </exception>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="filename"/> is null. Empty strings are accepted but will return null.</exception>
        public static string GetMediayTypeByFileName(string filename)
        {
            if (filename == null) throw new ArgumentNullException("filename");
            if (filename == string.Empty) return null;

            var extenstion = Path.GetExtension(filename);

            return GetMediayTypeByExtension(extenstion);
        }

        /// <summary>
        /// MIME (Multipurpose Internet Mail Extensions) type or Internet Media Type acoording to this source: http://www.sitepoint.com/web-foundations/mime-types-complete-list/ 
        /// </summary>
        /// <param name="extension">File extension INCLUDING the dot (e.g. '.jpg'</param>
        /// <returns>NULL if no MIME type is found or an empty string is passed</returns>
        /// <exception cref="ArgumentException">Thrown when <paramref name="extension"/> does not start with a '.' (dot) </exception>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="extension"/> is null. Empty strings are accepted but will return null.</exception>
        public static string GetMediayTypeByExtension(string extension)
        {
            if (extension == null) throw new ArgumentNullException("extension");
            if (extension == string.Empty) return null;
            if (!extension[0].Equals('.')) throw new ArgumentException(string.Format("The value for parameter 'extension' must start with a '.' (dot). Actual value: '{0}'",extension),"extension");

            var mimeType = ResourceManager.GetString(extension.Substring(1).ToLowerInvariant());

            return mimeType;
        }


    }
}
