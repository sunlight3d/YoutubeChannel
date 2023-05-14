using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface IWatchListRepository
	{
        Task AddStockToWatchlist(int userId, int stockId);
        Task<WatchList?> GetWatchlist(int userId, int stockId);
        Task<List<Stock?>?> GetWatchListByUserId(int userId);
    }
}

