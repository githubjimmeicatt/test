using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Windows.Input;
using System.Windows.Forms;
using System.Drawing;
using Dhv.AutomatedUITest.Scenarios.InloggenMetDigid;
using Icatt.Test.Ui;
using Microsoft.VisualStudio.TestTools.UITesting;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UITest.Extension;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Keyboard = Microsoft.VisualStudio.TestTools.UITesting.Keyboard;
using Dhv.AutomatedUITest;


namespace Dhv.AutomatedUITest
{
    /// <summary>
    /// Summary description for CodedUITest1
    /// </summary>
    [TestClass]
    public class CodedUITest1 :TestBaseClass
    {
 

        public IRunContext UiContext
        {
            get { return new RunContext(new Context(TestContext), TestRunOptions); }

        }

        private IWebDriverControllerFactory CreateWebDriverControllerFactory()
        {
            return new WebDriverControllerFactory(new Logger(TestContext), new BrowserWindow());
        }


        [TestMethod]
        public void CUI_Test_Login_met_Digid()
        {

            var digiDLoginFlow = new DigidFlow();

            var testRunner = new TestRunner(CreateWebDriverControllerFactory(), UiContext);

            testRunner.Run(
                new[]
                {
                    new TestScenario("Inloggen via Digid",
                        new Action<IWebDriver, IWait<IWebDriver>, IRunContext>[]
                        {
                            digiDLoginFlow.LoginWithDigid
                        })
                });

        }

        #region Additional test attributes

        // You can use the following additional attributes as you write your tests:

        ////Use TestInitialize to run code before running each test 
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{        
        //    // To generate code for this test, select "Generate Code for Coded UI Test" from the shortcut menu and select one of the menu items.
        //}

        ////Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{        
        //    // To generate code for this test, select "Generate Code for Coded UI Test" from the shortcut menu and select one of the menu items.
        //}

        #endregion

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext { get; set; }
    }
}
