using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
	public interface IStockService
	{
		Task<Stock?> GetStockById(int stockId);
        Task<List<string>> GetDistinctIndustries();
        Task<List<string>> GetDistinctSectors();
    }
}

