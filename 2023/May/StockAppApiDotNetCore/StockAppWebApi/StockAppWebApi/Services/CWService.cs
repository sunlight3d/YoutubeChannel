using System;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;

namespace StockAppWebApi.Services
{
	public class CWService:ICWService
	{
        private readonly ICWRepository _cwRepository;

        public CWService(ICWRepository cwRepository)
        {
            _cwRepository = cwRepository;
        }

        public async Task<List<CoveredWarrant>> GetCoveredWarrantsByStockId(int stockId)
        {
            return await _cwRepository.GetCoveredWarrantsByStockId(stockId);
        }
    }
}

