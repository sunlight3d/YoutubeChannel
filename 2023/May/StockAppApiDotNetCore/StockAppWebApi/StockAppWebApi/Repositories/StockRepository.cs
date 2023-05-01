using System;
using StockAppWebApi.Models;
using Microsoft.EntityFrameworkCore;

namespace StockAppWebApi.Repositories
{
	public class StockRepository:IStockRepository
	{
        private readonly StockAppContext _context;        

        public StockRepository(StockAppContext context)
        {
            _context = context;            
        }
        
        public async Task<Stock?> GetStockById(int stockId)
        {
            Stock? stock = await _context.Stocks.FindAsync(stockId);            
            return stock;
        }
    }
}

