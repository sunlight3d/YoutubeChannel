using System;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Filters;

namespace StockAppWebApi.Attributes
{
    public class JwtAuthorizeAttribute : TypeFilterAttribute
    {

        public JwtAuthorizeAttribute()
            : base(typeof(JwtAuthorizeFilter))
        {

        }
    }
}

