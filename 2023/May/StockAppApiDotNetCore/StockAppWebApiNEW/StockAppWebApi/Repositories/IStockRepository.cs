using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface IStockRepository
	{
		Task<Stock?> GetStockById(int stockId);
        //lấy ra danh sách các sector và industry ko trùng lặp nhau
        Task<List<string>> GetDistinctIndustries();
        Task<List<string>> GetDistinctSectors();
    }
}

