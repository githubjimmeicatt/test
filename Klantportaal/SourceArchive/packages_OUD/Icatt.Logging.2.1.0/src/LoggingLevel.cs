using System;

namespace Icatt.Logging
{
    public enum LoggingLevel
    {
        All = 0,

        //Alternative info level name for debugging and tracing
        Finest = 10000,
        Finer = 20000,
        Fine = 30000,

        //level names for backwards compatibility
        InfoDetail = 20000,

        /// <summary>
        /// Informational message that highlights application progress at a level suitable for very detailed tracing and debugging
        /// </summary>
        Verbose = 10000,

        /// <summary>
        /// Informational message that highlights application progress at a level suitable for tracing
        /// </summary>
        Trace = 20000,

        /// <summary>
        /// Informational message that highlights application progress at a level suitable for debugging
        /// </summary>
        Debug = 30000,

        /// <summary>
        /// Informational message that highlights application progress at a more detailed level
        /// </summary>
        Information = 40000,

        /// <summary>
        /// Informational message that highlights application progress at a course grained level
        /// </summary>
        Notice = 50000,

        /// <summary>
        /// 
        /// </summary>
        Warning = 60000,

        /// <summary>
        /// Error event that do not 
        /// </summary>
        Error = 70000,

        /// <summary>
        /// Severe error event
        /// </summary>
        Severe = 80000,

        /// <summary>
        /// Exceptions are classified as severe
        /// </summary>
        Exception = Severe,

        /// <summary>
        /// Critical condition
        /// </summary>
        Critical = 90000,

        /// <summary>
        /// Severe error event that needs immediat actions
        /// </summary>
        Alert = 100000,

        /// <summary>
        /// Severe error event that presumabley leads to applicaion abort
        /// </summary>
        Fatal = 110000,

        /// <summary>
        /// System unusable
        /// </summary>
        Emergency = 120000, 

        /// <summary>
        /// 
        /// </summary>
        Off = Int32.MaxValue, 
    }
}