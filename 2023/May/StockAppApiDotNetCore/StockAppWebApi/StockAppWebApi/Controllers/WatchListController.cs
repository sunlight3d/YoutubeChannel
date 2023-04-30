using System;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using StockAppWebApi.Filters;
using StockAppWebApi.Services;

namespace StockAppWebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WatchListController: ControllerBase
    {
        private readonly IWatchListService _service;
        private readonly AuthorizationFilterContext _context;

        public WatchListController(IWatchListService service,
            AuthorizationFilterContext context)
        {
            _service = service;
            _context = context;
        }
        [HttpPost("AddStockToWatchlist/{stockId}")]
        [JwtAuthorize]        
        public async Task<IActionResult> AddStockToWatchlist(int stockId)
        {
            // Lấy UserId từ context
            if (!int.TryParse(_context.HttpContext.User
                .FindFirst(ClaimTypes.NameIdentifier)?.Value, out var userId))
            {
                return Unauthorized();
            }

            await _service.AddStockToWatchlist(userId, stockId);
            return Ok();
        }

    }
}

