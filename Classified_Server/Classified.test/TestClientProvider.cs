using System;
using System.Net.Http;
using Classifieds;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.TestHost;

namespace Classified.test;

public class TestClientProvider : IDisposable
{
    private TestServer server;
    public HttpClient Client { get ; private set; }
    
    public TestClientProvider()
    {   
        server = new TestServer(new WebHostBuilder().UseStartup<Startup>());
        Client = server.CreateClient();
        
    }

    public void Dispose()
    {
       server?.Dispose();
       Client?.Dispose();
    }
}