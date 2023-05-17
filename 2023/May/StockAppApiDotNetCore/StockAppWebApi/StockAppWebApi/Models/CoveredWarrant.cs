using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StockAppWebApi.Models
{
    [Table("covered_warrants")]
    public class CoveredWarrant
	{
        [Key]
        [Column("warrant_id")]
        public int WarrantId { get; set; }

        [Required(ErrorMessage = "Name is required")]
        [StringLength(255)]
        [Column("name")]
        public string? Name { get; set; }

        [ForeignKey("Stock")]
        [Column("underlying_asset_id")]
        public int UnderlyingAssetId { get; set; }

        [Column("issue_date")]
        public DateTime IssueDate { get; set; }

        [Column("expiration_date")]
        public DateTime ExpirationDate { get; set; }

        [Column("strike_price")]
        public decimal? StrikePrice { get; set; }

        [Required(ErrorMessage = "Warrant type is required")]
        [StringLength(50)]
        [Column("warrant_type")]
        public string? WarrantType { get; set; }

        public Stock? Stock { get; set; }
    }
}

