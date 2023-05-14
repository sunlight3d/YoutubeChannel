using System;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Attributes;
using StockAppWebApi.Extensions;
using StockAppWebApi.Models;
using StockAppWebApi.Services;

namespace StockAppWebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderService _orderService;
        private readonly IUserService _userService;
        
        public OrderController(IOrderService orderService, IUserService userService)
        {
            _orderService = orderService;
            _userService = userService;
        }
        [HttpPost("place_order")]
        [JwtAuthorize]
        public async Task<IActionResult> PlaceOrder(OrderViewModel orderViewModel)
        {
            try
            {
                // Lấy UserId từ context
                int userId = HttpContext.GetUserId();
                // Kiểm tra người dùng và cổ phiếu tồn tại
                var user = await _userService.GetUserById(userId);
                if (user == null)
                {
                    return NotFound("User not found.");
                }
                var createdOrder = await _orderService.PlaceOrder(orderViewModel);
                return Ok(createdOrder);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("order-book")]
        [JwtAuthorize]
        public async Task<IActionResult> GetOrderBook()
        {
            var orderBook = await _orderService.GetOrderBook();
            return Ok(orderBook);
        }
    }
}

