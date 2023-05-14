using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface IStockRepository
	{
		Task<Stock?> GetStockById(int stockId);
	}
}

