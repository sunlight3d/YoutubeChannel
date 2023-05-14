using System;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;

namespace StockAppWebApi.Services
{
    public class WatchListService : IWatchListService
    {
        private readonly IWatchListRepository _repository;

        public WatchListService(IWatchListRepository repository)
        {
            _repository = repository;
        }

        public async Task AddStockToWatchlist(int userId, int stockId)
        {
            await _repository.AddStockToWatchlist(userId, stockId);
        }

        public async Task<WatchList?> GetWatchlist(int userId, int stockId)
        {
            return await _repository.GetWatchlist(userId, stockId);
        }

        public async Task<List<Stock?>?> GetWatchListByUserId(int userId) {
            return await _repository.GetWatchListByUserId(userId);
        }
    }

}

