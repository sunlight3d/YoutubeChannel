using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
    public interface IOrderService
    {
        Task<Order> PlaceOrder(Order order);
        Task<List<Order>> GetOrderBook();
    }
}

