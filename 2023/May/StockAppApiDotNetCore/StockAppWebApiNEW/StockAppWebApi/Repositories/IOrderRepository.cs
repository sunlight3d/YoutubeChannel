using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
    public interface IOrderRepository
    {
        Task<Order> CreateOrder(OrderViewModel orderViewModel);
        Task<List<Order>> GetOrderBook();
    }

}

