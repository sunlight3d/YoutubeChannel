﻿using System;
using StockAppWebApi.Models;

namespace StockAppWebApi.Repositories
{
	public interface IQuoteRepository
	{
        Task<List<RealtimeQuote>?> GetRealtimeQuotes(int page, int limit);
        
    }
}
