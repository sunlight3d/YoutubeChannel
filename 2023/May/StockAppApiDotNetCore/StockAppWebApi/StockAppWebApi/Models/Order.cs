using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StockAppWebApi.Models
{
	[Table("orders")]
	public class Order
	{
        [Key]
        [Column("order_id")]
        public int OrderId { get; set; }

        [ForeignKey("User")]
        [Column("user_id")]
        public int UserId { get; set; }
        public User? User { get; set; }

        [ForeignKey("Stock")]
        [Column("stock_id")]
        public int StockId { get; set; }
        public Stock? Stock { get; set; }

        [Required(ErrorMessage = "Order type is required")]
        [StringLength(20)]
        [Column("order_type")]
        public string? OrderType { get; set; }

        [Required(ErrorMessage = "Direction is required")]
        [StringLength(20)]
        [Column("direction")]
        public string? Direction { get; set; }

        [Range(1, int.MaxValue,
            ErrorMessage = "Quantity must be greater than 0")]
        [Column("quantity")]
        public int Quantity { get; set; }

        [Column("price")]
        public decimal Price { get; set; }

        [Required(ErrorMessage = "Status is required")]
        [StringLength(20)]
        [Column("status")]
        public string? Status { get; set; }

        [Column("order_date")]
        public DateTime OrderDate { get; set; }

    }
}

