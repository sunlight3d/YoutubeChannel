using System;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;

namespace StockAppWebApi.Services
{
    public class OrderService : IOrderService
    {
        private readonly IOrderRepository _orderRepository;

        public OrderService(IOrderRepository orderRepository)
        {
            _orderRepository = orderRepository;
        }

        public async Task<Order> PlaceOrder(Order order)
        {
            if (order.Quantity <= 0)
            {
                throw new ArgumentException("Quantity must be greater than 0");
            }

            // Perform additional validations or business logic if needed

            return await _orderRepository.CreateOrder(order);
        }

        public async Task<List<Order>> GetOrderBook()
        {
            return await _orderRepository.GetOrderBook();
        }
    }

}

