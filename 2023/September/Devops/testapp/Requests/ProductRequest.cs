using System.ComponentModel.DataAnnotations;

namespace testapp.Requests
{
    public class ProductRequest
    {
        [Required]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Length must be 3 to 100")]
        public string? Name { get; set; }        
        [Required]
        public Double Price { get; set; }
        [Required]
        public int Count { get; set; }
        public string? Description { get; set; }
    }
}
