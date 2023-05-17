using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface ICWRepository
	{
        Task<List<CoveredWarrant>> GetCoveredWarrantsByStockId(int stockId);
    }
}

