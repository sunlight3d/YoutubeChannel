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
        public async Task<List<string>> GetDistinctIndustries()
        {
            List<string> distinctIndustries = await _context.Stocks
                .Select(s => s.Industry ?? "")
                .Distinct()
                .ToListAsync();

            return distinctIndustries;
        }

        public async Task<List<string>> GetDistinctSectors()
        {
            List<string> distinctSectors = await _context.Stocks
                .Select(s => s.Sector ?? "")
                .Distinct()
                .ToListAsync();

            return distinctSectors;
        }
    }
}

