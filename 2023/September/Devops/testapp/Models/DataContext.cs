using Microsoft.EntityFrameworkCore;
using Bogus;

namespace testapp.Models
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
