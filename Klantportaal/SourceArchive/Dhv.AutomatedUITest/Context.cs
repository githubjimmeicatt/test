using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Icatt.Test.Ui;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Dhv.AutomatedUITest
{
    public class BrowserWindow : IBrowserWindow
    {
        public void ResetZoomLevel()
        {
            System.Threading.Thread.Sleep(500);
            System.Windows.Forms.SendKeys.SendWait("^{0}");
        }
    }

    public class Context : IContext
    {
        private readonly TestContext _context;

        public Context(TestContext context)
        {
            _context = context;
        }

        public void AddResultFile(string fileName)
        {
            _context.AddResultFile(fileName);
        }

        public void WriteLine(string s)
        {
            _context.WriteLine(s);
        }

        public string OutputDirectory
        {
            get { return _context.TestRunResultsDirectory; }
        }

        public string TestName
        {
            get { return _context.TestName; }
        }
    }
}
