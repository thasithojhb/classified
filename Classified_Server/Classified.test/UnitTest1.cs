using System;
using System.Collections.Generic;
using System.Net;
using System.Text.Json.Nodes;
using System.Threading.Tasks;
using Classifieds;
using FluentAssertions;
using Newtonsoft.Json;
using Xunit;
using Xunit.Sdk;

namespace Classified.test;

public class UnitTest1
{
    [Fact]
    public async Task Test_Get_All()
    {
        using var client = new TestClientProvider().Client;
        var response =  await client.GetAsync("/WeatherForecast");
        response.EnsureSuccessStatusCode();
        var body = JsonConvert.DeserializeObject<List<WeatherForecast>>(await response.Content.ReadAsStringAsync());
        response.StatusCode.Should().Be(HttpStatusCode.OK);
    }
}