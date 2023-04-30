using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using StockAppWebApi.Models;

namespace StockAppWebApi.Filters
{
    public class JwtAuthorizeAttribute : TypeFilterAttribute
    {
        
        
        public JwtAuthorizeAttribute()
            : base(typeof(JwtAuthorizeFilter))
        {
            
        }

        private class JwtAuthorizeFilter : IAuthorizationFilter
        {
            private readonly IConfiguration _config;
            JwtAuthorizeFilter(IConfiguration config) {
                _config = config;
            }
            public void OnAuthorization(AuthorizationFilterContext context)
            {
                var token = context.HttpContext.Request
                    .Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
                if (token == null)
                {
                    context.Result = new UnauthorizedResult();
                    return;
                }

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(_config.GetValue<string>("JwtSecret") ?? "");
                try
                {
                    var claimsPrincipal = tokenHandler.ValidateToken(token, new TokenValidationParameters
                    {
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(key),
                        ValidateIssuer = false,
                        ValidateAudience = false,
                        //Nếu token hết hạn,
                        //thì khi gọi phương thức ValidateToken,
                        //mã lỗi SecurityTokenExpiredException sẽ được throw ra
                        ClockSkew = TimeSpan.Zero
                    }, out SecurityToken validatedToken);
                    var jwtToken = (JwtSecurityToken)validatedToken;
                    var userId = int.Parse(jwtToken.Claims.First(x => x.Type == "userId").Value);
                    context.HttpContext.Items["UserId"] = userId;
                }
                catch (Exception)
                {
                    context.Result = new UnauthorizedResult();
                    return;
                }
            }
        }
    }
}

