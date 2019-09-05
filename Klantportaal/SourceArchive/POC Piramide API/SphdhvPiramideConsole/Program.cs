using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using SphdhvPiramideApi;
using SphdhvPiramideApi.Models;

namespace SphdhvPiramideConsole
{
    class Program
    {
        private static readonly List<string> DossierNummers = new List<string>()
            {
                "0000307943","0000307944","0000307949","0000307950",
                "0000307957","0000307952","0000307959","0000307954",
                "0000307974","0000308054","0000308218","0000308204",
                "0000308219","0000308220","0000308221","0000308222"
            };

        static void Main(string[] args)
        {
            Console.WriteLine("Press enter to start the test.");
            Console.ReadLine();
            Runtest();
            Runtest();
            Runtest();
            Console.WriteLine("Press enter to end the test.");
            Console.ReadLine();
        }

        public static async void Runtest()
        {
            var tasksEnum = DossierNummers.Select(nummer => GetResult<Verzekerde>($"/api/verzekerden/{nummer}"));
            var runid = Guid.NewGuid();

            Console.WriteLine("Starting run " + runid);

            var tasks = tasksEnum.ToList();
            var runningTasks = new List<Task<Verzekerde>>(tasks);

            // ***Add a loop to process the tasks one at a time until none remain.  
            while (runningTasks.Count > 0)
            {
                // Identify the first task that completes.  
                var firstFinishedTask = await Task.WhenAny(runningTasks);
                runningTasks.Remove(firstFinishedTask);

                var index = tasks.IndexOf(firstFinishedTask);
                Console.WriteLine(firstFinishedTask.Result.Bsn + " : " +index);
            }

            Console.WriteLine("All tasks for run " + runid + " are finished");
        }

        private static Task<T> GetResult<T>(string endpoint)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            var request = new PiramideApi();
            var url = new Uri($"https://dhvwebapi.bgstest.piramide.nl/{endpoint}");
            var task = request.GetRequestAsync<T>(url);
            return task;
        }
    }
}
