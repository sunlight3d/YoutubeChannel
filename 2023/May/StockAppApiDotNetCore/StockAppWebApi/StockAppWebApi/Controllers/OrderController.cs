using System;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Services;
using StockAppWebApi.Attributes;
using StockAppWebApi.Extensions;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController: ControllerBase
    {
        private readonly IOrderService _orderService;
        private readonly IUserService _userService;
        public OrderController(
            IOrderService orderService,
            IUserService userService)
        {
            _orderService = orderService;
            _userService = userService;
        }
        [HttpPost("place_order")]
        [JwtAuthorize]
        public async Task<IActionResult> PlaceOrder(OrderViewModel orderViewModel) {
            // Lấy UserId từ context
            int userId = HttpContext.GetUserId();
            // Kiểm tra người dùng và cổ phiếu tồn tại
            var user = await _userService.GetUserById(userId);
            if (user == null)
            {
                return NotFound("User not found.");
            }
            orderViewModel.UserId = userId;
            var createdOrder = await _orderService.PlaceOrder(orderViewModel);
            return Ok(createdOrder);
        }

    }
}

