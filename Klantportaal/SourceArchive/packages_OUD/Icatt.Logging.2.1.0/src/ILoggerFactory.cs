using System.Collections.Generic;
using Icatt.Infrastructure;

namespace Icatt.Logging
{
    public interface ILoggerFactory
    {
        /// <summary>
        /// Factory that creates specific <see cref="ILogger{TAppAreaEnum,TLogMessageEnum}"/> implementations. 
        /// </summary>
        /// <typeparam name="TAppAreaEnum"></typeparam>
        /// <typeparam name="TLogMessageEnum"></typeparam>
        /// <param name="contextFactory"></param>
        /// <param name="messageDictionary"></param>
        /// <returns></returns>
        ILogger<TAppAreaEnum, TLogMessageEnum> Create<TAppAreaEnum, TLogMessageEnum>(IContextFactory contextFactory, IDictionary<TLogMessageEnum, string> messageDictionary = null);
    }
}
