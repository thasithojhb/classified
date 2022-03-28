using System;
using System.Collections.Generic;
using System.Net;
using System.Text.Json.Nodes;
using System.Threading.Tasks;
using Classifieds;
using FluentAssertions;
using Newtonsoft.Json;
using Xunit;
using Xunit.Abstractions;
using Xunit.Sdk;

namespace Classified.test;

public class UnitTest1
{
    private readonly ITestOutputHelper _testOutputHelper;

    public UnitTest1(ITestOutputHelper testOutputHelper)
    {
        _testOutputHelper = testOutputHelper;
    }

    [Fact]
    public async Task Test_Get_All()
    {
        using var client = new TestClientProvider().Client;
        var response =  await client.GetAsync("/WeatherForecast");
        response.EnsureSuccessStatusCode();
        var body = JsonConvert.DeserializeObject<List<WeatherForecast>>(await response.Content.ReadAsStringAsync());
        body.ForEach(e => _testOutputHelper.WriteLine(e.ToString()));
        response.StatusCode.Should().Be(HttpStatusCode.OK);
    }
}