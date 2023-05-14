using System;
using System.Net.NetworkInformation;
using Microsoft.EntityFrameworkCore;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
    public class OrderRepository : IOrderRepository
    {
        private readonly StockAppContext _context;

        public OrderRepository(StockAppContext context)
        {
            _context = context;
        }

        public async Task<Order> CreateOrder(OrderViewModel orderViewModel)
        {
            try
            {
                Order order = new Order
                {
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
            }
            catch (Exception e) {
                Console.WriteLine("ddd");
            }
            return new Order();
        }

        public async Task<List<Order>> GetOrderBook()
        {
            return await _context.Orders.ToListAsync();
        }
    }
}

