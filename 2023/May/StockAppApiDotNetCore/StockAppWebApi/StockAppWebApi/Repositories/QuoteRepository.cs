using System;
using Microsoft.EntityFrameworkCore;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
    public class QuoteRepository : IQuoteRepository
    {
        private readonly StockAppContext _context;

        public QuoteRepository(StockAppContext context)
        {
            _context = context;
        }
        public async Task<List<RealtimeQuote>?> GetRealtimeQuotes(int page, int limit)
        {
            var quotes = await _context.RealtimeQuotes
                            .Skip((page - 1) * limit) // Bỏ qua số lượng bản ghi trước trang hiện tại
                            .Take(limit) // Lấy số lượng bản ghi tối đa trên mỗi trang
                            .ToListAsync();

            return quotes;
        }
    }
}

