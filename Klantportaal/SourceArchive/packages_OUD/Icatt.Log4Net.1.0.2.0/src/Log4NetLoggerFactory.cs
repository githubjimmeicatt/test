using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Infrastructure;
using Icatt.Logging;

namespace Icatt.Log4Net
{
    public class Log4NetLoggerFactory : ILoggerFactory
    {
        public ILogger<TAppAreaEnum, TLogMessageEnum> Create<TAppAreaEnum, TLogMessageEnum>(IContextFactory contextFactory, IDictionary<TLogMessageEnum, string> messageDictionary = null)
        {
            return new Log4NetLogger<TAppAreaEnum, TLogMessageEnum>(contextFactory, messageDictionary);
        }
    }
}
