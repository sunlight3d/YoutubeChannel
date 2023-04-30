using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StockAppWebApi.Models
{
    [Table("users")]
    public class User
    {
        [Key]
        [Column("user_id")]
        public int UserId { get; set; }

        [Required(ErrorMessage = "Username is required")]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Username must be between 6 and 100 characters")]
        [Column("username")]
        public string Username { get; set; } = "";

        [Required(ErrorMessage = "Password is required")]
        [StringLength(200, MinimumLength = 6, ErrorMessage = "Password must be between 6 and 200 characters")]
        [Column("hashed_password")]
        public string HashedPassword { get; set; } = "";

        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email address")]
        [Column("email")]
        public string Email { get; set; } = "";

        [Required(ErrorMessage = "Phone number is required")]
        [RegularExpression(@"^\+?\d{10,15}$", ErrorMessage = "Invalid phone number")]
        [Column("phone")]
        public string Phone { get; set; } = "";

        [StringLength(255, ErrorMessage = "Full name cannot exceed 255 characters")]
        [Column("full_name")]
        public string FullName { get; set; } = "";

        [Column("date_of_birth")]
        public DateTime? DateOfBirth { get; set; }

        [StringLength(200, ErrorMessage = "Country name cannot exceed 200 characters")]
        [Column("country")]
        public string Country { get; set; } = "";
    }

}

