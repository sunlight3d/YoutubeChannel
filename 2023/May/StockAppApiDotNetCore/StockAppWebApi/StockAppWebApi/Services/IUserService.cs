using System;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Services
{
    public interface IUserService
    {
        Task<User?> GetUserById(int userId);
        Task<User?> Register(RegisterViewModel registerViewModel);
        //jwt string
        Task<string> Login(LoginViewModel loginViewModel);        
    }
}

