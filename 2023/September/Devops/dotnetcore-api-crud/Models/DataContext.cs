using Microsoft.EntityFrameworkCore;
using Bogus;

namespace dotnetcore_api_crud.Models
{
    public class DataContext:DbContext
    {
        public DataContext(DbContextOptions<DataContext> options)
               : base(options)
        {
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }


        public virtual DbSet<Product> Products { get; set; }
    }
}
