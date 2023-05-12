using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface IQuoteService
	{
		Task<List<RealtimeQuote>?> GetRealtimeQuotes(int page, int limit);
	}
}