using System;
namespace StockAppWebApi.Repositories
{
	public interface IWatchListRepository
	{
        Task AddStockToWatchlist(int userId, int stockId);

    }
}

