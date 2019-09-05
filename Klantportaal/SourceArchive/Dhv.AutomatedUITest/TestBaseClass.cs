using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Icatt.Test.Ui;

namespace Dhv.AutomatedUITest
{
    public class TestBaseClass
    {
        public TestRunOptions TestRunOptions
        {
            get
            {
                return new TestRunOptions
                {
                    WebDrivers = new WebDriverType[]
                    {
                        WebDriverType.Chrome,
                        //WebDriverType.Firefox,
                        //WebDriverType.InternetExplorer
                    },
                    // Timeout = 120, 
                    Timeout = 12,
                    Screenshots = new Screenshots() { Action = true, FinalState = true, Scenario = true }
                };
            }
        }
        
    }
}
