using System;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using System.Net.Mime;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace testapp
{
    public class CustomHealthCheck : IHealthCheck
    {
        public Task<HealthCheckResult> CheckHealthAsync(
            HealthCheckContext context, CancellationToken cancellationToken = default)
        {
            try
            {
                return Task.FromResult(
                    HealthCheckResult.Healthy("The service is up and running."));
            }
            catch (Exception)
            {
                return Task.FromResult(
                    new HealthCheckResult(
                        context.Registration.FailureStatus, "The service is down."));
            }
        }
    }
}