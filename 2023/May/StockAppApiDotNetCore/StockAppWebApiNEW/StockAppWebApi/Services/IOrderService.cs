using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
    public interface IOrderService
    {
        Task<Order> PlaceOrder(OrderViewModel orderViewModel);
        Task<List<Order>> GetOrderBook();
    }
}

