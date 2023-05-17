using System;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Services
{
	public class OrderService: IOrderService
    {
        private readonly IOrderRepository _orderRepository;

        public OrderService(IOrderRepository orderRepository)
        {
            _orderRepository = orderRepository;
        }

        public Task<List<Order>> GetOrderHistory()
        {
            throw new NotImplementedException();
        }

        public async Task<Order> PlaceOrder(OrderViewModel orderViewModel)
        {
            if (orderViewModel.Quantity <= 0)
            {
                throw new ArgumentException("Quantity must be greater than 0");
            }
            return await _orderRepository.CreateOrder(orderViewModel);
        }
    }
}

