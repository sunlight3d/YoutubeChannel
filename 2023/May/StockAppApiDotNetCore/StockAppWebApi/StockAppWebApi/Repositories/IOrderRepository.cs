using System;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Repositories
{
	public interface IOrderRepository
	{
        Task<Order> CreateOrder(OrderViewModel orderViewModel);
    }
}

