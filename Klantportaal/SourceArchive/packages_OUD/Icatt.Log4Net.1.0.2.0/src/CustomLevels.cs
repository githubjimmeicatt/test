using log4net.Core;

namespace Icatt.Log4Net
{
    public static class CustomLevels
    {
        /// <summary> Log level for exception. </summary>
        public static Level ExceptionLevel { get { return new Level(79999, "EXCEPTION"); } }
    }
}
