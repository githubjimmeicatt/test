using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dhv.AutomatedUITest.UIMap.Pages.BaseClasses;
using Icatt.Test.Ui;
 
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Dhv.AutomatedUITest.UIMap.Pages
{
    public class DigidLoginPage : PageBase
    {
        private readonly IWebDriver _driver;
        private readonly IWait<IWebDriver> _wait;
        private readonly IRunContext _testContext;


        public DigidLoginPage(IWebDriver driver, IWait<IWebDriver> wait, IRunContext context)
        {
            _driver = driver;
            _wait = wait;
            _testContext = context;
        }
        
        public void WaitForPageReady()
        {
            _wait.ElementIsVisible("authentication_digid_username");
        }

        public void Login()
        { 
            _wait.ElementIsVisible("authentication_digid_username").SendKeys("digid1");
            _wait.ElementIsVisible("authentication_wachtwoord").SendKeys("A-ndr01d!"); ;
            _wait.ElementIsVisible("submit-button").Click();
        }

    }
}
