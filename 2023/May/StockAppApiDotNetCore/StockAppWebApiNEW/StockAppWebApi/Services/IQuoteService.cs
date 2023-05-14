using System;
using System.Threading.Tasks;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface IQuoteService
	{
		Task<List<RealtimeQuote>?> GetRealtimeQuotes(
			int page,
			int limit,
			string sector,
            string industry);
        Task<List<Quote>> GetHistoricalQuotes(int days);
    }
}