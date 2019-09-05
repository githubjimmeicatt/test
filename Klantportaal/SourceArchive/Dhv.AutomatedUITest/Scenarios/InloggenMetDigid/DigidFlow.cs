using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dhv.AutomatedUITest.UIMap.Pages;
using Icatt.Test.Ui;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Dhv.AutomatedUITest.Scenarios.InloggenMetDigid
{
    public class DigidFlow
    {

        public void LoginWithDigid(IWebDriver driver, IWait<IWebDriver> wait, IRunContext testContext)
        {
            var loginPage = new LoginPage(driver, wait, testContext);

            loginPage.Load();
            loginPage.Login();

            var digidLoginPage = new DigidLoginPage(driver, wait, testContext);

            digidLoginPage.WaitForPageReady();
            digidLoginPage.Login();

            var digidLoginLandingsPage = new DigidLoginLandingsPage(driver, wait, testContext);

            digidLoginLandingsPage.WaitForPageReady();
            digidLoginLandingsPage.AssertContainsCorrectBsn();

        }

    }
}
