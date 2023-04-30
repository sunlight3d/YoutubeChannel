using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StockAppWebApi.Models
{
    [Table("stocks")]
    public class Stock
    {
        [Key]
        [Column("stock_id")]
        public int StockId { get; set; }

        [Required(ErrorMessage = "Symbol is required")]
        [MaxLength(10, ErrorMessage = "Symbol must not exceed 10 characters")]
        [Column("symbol")]
        public string Symbol { get; set; } = "";

        [Required(ErrorMessage = "Company name is required")]
        [MaxLength(255, ErrorMessage = "Company name must not exceed 255 characters")]
        [Column("company_name")]
        public string CompanyName { get; set; } = "";

        [Column("market_cap")]
        public decimal? MarketCap { get; set; }

        [MaxLength(200, ErrorMessage = "Sector must not exceed 200 characters")]
        [Column("sector")]
        public string Sector { get; set; } = "";

        [MaxLength(200, ErrorMessage = "Industry must not exceed 200 characters")]
        [Column("industry")]
        public string Industry { get; set; } = "";

        [MaxLength(200, ErrorMessage = "Sector (English) must not exceed 200 characters")]
        [Column("sector_en")]
        public string SectorEn { get; set; } = "";

        [MaxLength(200, ErrorMessage = "Industry (English) must not exceed 200 characters")]
        [Column("industry_en")]
        public string IndustryEn { get; set; } = "";

        [MaxLength(50, ErrorMessage = "Stock type must not exceed 50 characters")]
        [Column("stock_type")]
        public string StockType { get; set; } = "";

        [Column("rank")]
        public int Rank { get; set; }

        [MaxLength(200, ErrorMessage = "Rank source must not exceed 200 characters")]
        [Column("rank_source")]
        public string RankSource { get; set; } = "";

        [MaxLength(255, ErrorMessage = "Reason must not exceed 255 characters")]
        [Column("reason")]
        public string Reason { get; set; } = "";

        //navigation
        public ICollection<WatchList>? WatchLists { get; set; }
    }
}




