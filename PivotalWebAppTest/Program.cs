using System;
using System.Collections.Generic;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace PivotalWebAppTest
{
    public class Program
    {
        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }

        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
            .UseUrls(GetServerUrls(args))    
            .UseStartup<Startup>()
                .Build();

        /// <summary>
        /// Update the server URLs from the command line. 
        /// Required when starting a Pivotal container
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        private static string[] GetServerUrls(IReadOnlyList<string> args)
        {
            var urls = new List<string>();
            for (var i = 0; i < args.Count; i++)
            {
                if ("--server.urls".Equals(args[i], StringComparison.OrdinalIgnoreCase))
                {
                    urls.Add(args[i + 1]);
                }
            }
            return urls.ToArray();
        }
    }
}
