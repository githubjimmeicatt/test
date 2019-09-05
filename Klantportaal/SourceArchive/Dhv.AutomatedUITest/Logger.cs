using Icatt.Test.Ui.Enums;
using Icatt.Test.Ui.Infrastructure.Logging;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace Dhv.AutomatedUITest
{

    public class Logger : ILogger<ApplicationArea, LoggingLevel>
    {
        private TestContext _testContext;
        public Logger(TestContext testContext)
        {
            _testContext = testContext;
        }

        public void Log(ApplicationArea applicationArea, LoggingLevel level, string details, string msg)
        {
            _testContext.WriteLine(BuildMessage(applicationArea, level, details, msg));
        }

        public void Log(ApplicationArea applicationArea, LoggingLevel level, object details, string msg)
        {
            throw new NotImplementedException();
        }

        public void Log(ApplicationArea applicationArea, LoggingLevel level, string format, params object[] arguments)
        {
            _testContext.WriteLine(BuildMessage(applicationArea, level, "...", string.Format(format, arguments)));
        }

        public void LogException(Exception ex)
        {
            throw new NotImplementedException();
        }

        private string BuildMessage(ApplicationArea applicationArea, LoggingLevel level, string details, string msg)
        {
            return string.Format("{0}-{1}-{2}-{3}", applicationArea.ToString(), (int)level, details, msg);
        }
    }
}
