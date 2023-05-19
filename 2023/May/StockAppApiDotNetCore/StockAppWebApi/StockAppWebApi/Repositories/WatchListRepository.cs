using System;
using Microsoft.EntityFrameworkCore;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public class WatchListRepository:IWatchListRepository
	{		
        private readonly StockAppContext _context;
        private readonly IConfiguration _config;

        public WatchListRepository(StockAppContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        public async Task AddStockToWatchlist(int userId, int stockId)
        {
            var watchlist = await _context.WatchLists.FindAsync(userId, stockId);

            if (watchlist == null)
            {
                watchlist = new WatchList
                {
                    UserId = userId,
                    StockId = stockId
                };

                _context.WatchLists.Add(watchlist);
                await _context.SaveChangesAsync();//COMMIT
            }
        }

        public async Task<WatchList?> GetWatchlist(int userId, int stockId)
        {
            return await _context.WatchLists
                .FirstOrDefaultAsync(watchList => watchList.UserId == userId
                    && watchList.StockId == stockId);
        }
        public async Task<List<Stock?>?> GetWatchListByUserId(int userId)
        {
            return await _context.WatchLists
                .Where(wl => wl.UserId == userId)
                .Include(wl => wl.Stock)
                .Select(wl => wl.Stock)
                .ToListAsync();
        }
    }
}

