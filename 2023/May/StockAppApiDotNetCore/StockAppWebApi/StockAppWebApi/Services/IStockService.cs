using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
	public interface IStockService
	{
		Task<Stock?> GetStockById(int stockId);

    }
}

