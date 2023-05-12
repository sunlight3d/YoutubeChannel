using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace StockAppWebApi.Models
{
    [Table("watchlists")]
    public class WatchList
	{
        [Key]
        [ForeignKey("User")]
        [Column("user_id")]
        public int? UserId { get; set; }

        [Key]
        [ForeignKey("Stock")]
        [Column("stock_id")]
        public int? StockId { get; set; }

        [JsonIgnore]
        public User? User { get; set; }

        [JsonIgnore]
        public Stock? Stock { get; set; }
    }
}

