using System;
using StockAppWebApi.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StockAppWebApi.Repositories
{
	public class CWRepository: ICWRepository
    {
        private readonly StockAppContext _context;

        public CWRepository(StockAppContext context)
        {
            _context = context;
        }

        public async Task<List<CoveredWarrant>> GetCoveredWarrantsByStockId(int stockId)
        {
            return await _context.CoveredWarrants
                    .Where(cw => cw.UnderlyingAssetId == stockId)
                    .Include(cw => cw.Stock)
                    .ToListAsync();
        }
    }
}

