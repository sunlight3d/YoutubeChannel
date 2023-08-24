using Bogus;
using testapp.Models;

using System;
using System.Linq;

namespace testapp.Models
{
    public class DataSeeder
    {
        private readonly DataContext _context;

        public DataSeeder(DataContext context)
        {
            _context = context;
        }

        public void SeedData()
        {
            if (!_context.Products.Any())
            {
                var fakeProducts = GenerateFakeProducts(10);
                _context.Products.AddRange(fakeProducts);
                _context.SaveChanges();
            }
        }
        /*
         * '_context.Products.Any()' threw an exception of type 'System.InvalidOperationException'
         */

        private Product[] GenerateFakeProducts(int count)
        {
            var faker = new Faker<Product>()
                .RuleFor(p => p.Name, f => f.Commerce.ProductName())
                .RuleFor(p => p.Description, f => f.Lorem.Sentence())
                .RuleFor(p => p.Price, f => f.Random.Double(10, 100))
                .RuleFor(p => p.Count, f => f.Random.Int(1, 100));

            return faker.Generate(count).ToArray();
        }
    }
}
