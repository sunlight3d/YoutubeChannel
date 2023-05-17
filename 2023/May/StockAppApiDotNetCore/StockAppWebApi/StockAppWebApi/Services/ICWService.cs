using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
	public interface ICWService
	{
        Task<List<CoveredWarrant>> GetCoveredWarrantsByStockId(int stockId);
    }
}

