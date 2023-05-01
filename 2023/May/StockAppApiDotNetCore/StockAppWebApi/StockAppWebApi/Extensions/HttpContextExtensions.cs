using System;
namespace StockAppWebApi.Extensions
{
	public static class HttpContextExtensions
	{
        public static int GetUserId(this HttpContext httpContext) {
            return httpContext.Items["UserId"] as int? ??
                throw new Exception("User ID not found in HttpContext.Items");
        }

    }
}

