using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StockAppWebApi.Models
{
    public class OrderViewModel
    {

        [Required]
        public int UserId { get; set; }

        [Required]
        public int StockId { get; set; }

        [Required(ErrorMessage = "Order type is required")]        
        public string? OrderType { get; set; }

        [Required(ErrorMessage = "Direction is required")]
        [StringLength(20)]        
        public string? Direction { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Quantity must be greater than 0")]        
        public int Quantity { get; set; }

        [Column("price")]
        public decimal Price { get; set; }

        [Required(ErrorMessage = "Status is required")]        
        public string? Status { get; set; }

        //[Column("order_date")]
        //public DateTime OrderDate { get; set; }                
    }
}

