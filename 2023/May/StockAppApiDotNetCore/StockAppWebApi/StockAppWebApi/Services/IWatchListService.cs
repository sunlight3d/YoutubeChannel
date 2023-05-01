using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
	public interface IWatchListService
	{
        Task AddStockToWatchlist(int userId, int stockId);
        Task<WatchList?> GetWatchlist(int userId, int stockId);
    }
}

