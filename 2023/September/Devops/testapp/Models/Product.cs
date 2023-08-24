using System.ComponentModel.DataAnnotations;
using testapp.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.OpenApi;
using Microsoft.AspNetCore.Http.HttpResults;
using System.ComponentModel.DataAnnotations.Schema;

namespace testapp.Models
{
    [Table("tblProduct")]
    public class Product
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        
        public string Name { get; set; }
        public string Description { get; set; }
        public Double Price { get; set; }
        public int Count { get; set; }
    }
}
