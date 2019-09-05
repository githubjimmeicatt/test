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
    public class LoginPage : PageBase
    {
        private readonly IWebDriver _driver;
        private readonly IWait<IWebDriver> _wait;
        private readonly IRunContext  _testContext;


        public LoginPage(IWebDriver driver, IWait<IWebDriver> wait, IRunContext context)
        {
            _driver = driver;
            _wait = wait;
            _testContext = context;
        }


        public void Load()
        {
            _driver.Navigate().GoToUrl(new Uri(BaseUrl + "/login"));
            _wait.ElementIsVisible(By.ClassName("cui-digidlogin"));
        }

        public void Login()
        {
            _wait.ElementIsVisible(By.ClassName("cui-digidlogin")).Click();   
        }
    }
}
