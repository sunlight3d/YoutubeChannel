using System;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Repositories
{
	public class OrderRepository:IOrderRepository
	{
        private readonly StockAppContext _context;
        public OrderRepository(StockAppContext context)
        {
            _context = context;
        }

        public async Task<Order> CreateOrder(OrderViewModel orderViewModel)
        {
            //tạo ra order từ orderViewModel
            Order order = new Order {
                UserId = orderViewModel.UserId,
                StockId = orderViewModel.StockId,
                OrderType = orderViewModel.OrderType,
                Direction = orderViewModel.Direction,
                Quantity = orderViewModel.Quantity,
                Price = orderViewModel.Price,
                Status = orderViewModel.Status,
                OrderDate = DateTime.Now
            };
            _context.Orders.Add(order);
            await _context.SaveChangesAsync();
            return order;//có thể sẽ ko lấy đc orderId, sẽ test thử
        }
    }
}

