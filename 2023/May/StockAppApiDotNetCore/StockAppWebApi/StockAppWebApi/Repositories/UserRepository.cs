using System;
using Microsoft.EntityFrameworkCore;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly StockAppContext _context;

        public UserRepository(StockAppContext context)
        {
            _context = context;
        }

        public async Task<User?> GetById(int id)
        {
            return await _context.Users.FindAsync(id);
        }

        public async Task<User?> GetByUsername(string username)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.Username == username);
        }

        public async Task<User?> GetByEmail(string email)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
        }

        public async Task<User?> Create(RegisterViewModel registerViewModel)
        {
            //Đoạn này sẽ gọi 1 procedure trong SQL
            var user = ...?
            return user.UserId;
        }
    }

}

