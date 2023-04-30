using System;
namespace StockAppWebApi.Services
{
	public interface IWatchListService
	{
        public Task AddStockToWatchlist(int userId, int stockId);
    }
}

