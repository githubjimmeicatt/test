using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dhv.AutomatedUITest.UIMap.Pages.BaseClasses;
using Icatt.Test.Ui;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Dhv.AutomatedUITest.UIMap.Pages
{
    public class DigidLoginLandingsPage : PageBase
    {
        private readonly IWebDriver _driver;
        private readonly IWait<IWebDriver> _wait;
        private readonly IRunContext _testContext;


        public DigidLoginLandingsPage(IWebDriver driver, IWait<IWebDriver> wait, IRunContext context)
        {
            _driver = driver;
            _wait = wait;
            _testContext = context;
        }
        
        public void WaitForPageReady()
        {
            _wait.ElementIsVisible(By.TagName("body"));
        }

        public void AssertContainsCorrectBsn()
        {
            var bsnContainer = _wait.ElementIsVisible(By.TagName("body"));
            Assert.IsTrue( bsnContainer.Text.Contains("\"Value\":\"178424912\",\"Type\":\"digid.nl/bsn\"")); 
        }

    }
}
