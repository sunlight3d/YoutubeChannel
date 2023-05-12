﻿using System;
using Microsoft.EntityFrameworkCore;

namespace StockAppWebApi.Models
{
    public class StockAppContext : DbContext
    {
        public StockAppContext(DbContextOptions<StockAppContext> options)
            : base(options)
        {
        }
        public DbSet<User> Users { get; set; }
        public DbSet<WatchList> WatchLists { get; set; }
        public DbSet<Stock> Stocks { get; set; }
        public DbSet<RealtimeQuote> RealtimeQuotes { get; set; }
        

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<WatchList>()
                .HasKey(w => new { w.UserId, w.StockId });            
        }
    }
}
