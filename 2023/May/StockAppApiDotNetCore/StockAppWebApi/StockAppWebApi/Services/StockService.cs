using System;
using Microsoft.EntityFrameworkCore;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;

namespace StockAppWebApi.Services
{
    public class StockService : IStockService
    {
        private readonly IStockRepository _stockRepository;
        public StockService(IStockRepository stockRepository) {
            _stockRepository = stockRepository;
        }
        public async Task<Stock?> GetStockById(int stockId)
        {
            return await _stockRepository.GetStockById(stockId);
        }

        public async Task<List<string>> GetDistinctIndustries()
        {            
            return await _stockRepository.GetDistinctIndustries();
        }

        public async Task<List<string>> GetDistinctSectors()
        {
            return await _stockRepository.GetDistinctSectors();
        }
    }
}

