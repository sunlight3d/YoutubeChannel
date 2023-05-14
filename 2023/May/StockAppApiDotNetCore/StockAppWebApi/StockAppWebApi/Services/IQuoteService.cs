using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Services
{
	public interface IQuoteService
	{
        Task<List<RealtimeQuote>?> GetRealtimeQuotes(
            int page,
            int limit,
            string sector,
            string industry);
    }
}

