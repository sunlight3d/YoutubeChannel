using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
    public interface IOrderRepository
    {
        Task<Order> CreateOrder(Order order);
        Task<List<Order>> GetOrderBook();
    }

}

