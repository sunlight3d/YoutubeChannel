using System;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace StockAppWebApi.Models
{
    [Table("view_quotes_realtime")]
    [Keyless]
    public class RealtimeQuote
	{
        [Column("quote_id")]
        public int quoteId { get; set; }

        [Column("symbol")]
        public string? Symbol { get; set; }

        [Column("company_name")]
        public string? CompanyName { get; set; }

        [Column("index_name")]
        public string? IndexName { get; set; }

        [Column("index_symbol")]
        public string? IndexSymbol { get; set; }

        [Column("market_cap")]
        public decimal MarketCap { get; set; }

        [Column("sector_en")]
        public string? SectorEn { get; set; }

        [Column("industry_en")]
        public string? IndustryEn { get; set; }

        [Column("sector")]
        public string? Sector { get; set; }

        [Column("industry")]
        public string? Industry { get; set; }

        [Column("stock_type")]
        public string? StockType { get; set; }

        [Column("price")]
        public decimal Price { get; set; }


        [Column("change")]
        public decimal Change { get; set; }

        [Column("percent_change")]
        public decimal PercentChange { get; set; }

        [Column("volume")]
        public int Volume { get; set; }

        [Column("time_stamp")]
        public DateTime TimeStamp { get; set; }
    }
}

