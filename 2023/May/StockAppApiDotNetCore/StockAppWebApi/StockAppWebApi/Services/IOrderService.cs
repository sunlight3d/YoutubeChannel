using System;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Services
{
	public interface IOrderService
	{
        Task<Order> PlaceOrder(OrderViewModel orderViewModel);
        //Task<List<Order>> GetOrderHistory(int userId);//select * from orders where user_id=??
        //Hãy viết thử hàm này, coi như là bài tập
    }
}

