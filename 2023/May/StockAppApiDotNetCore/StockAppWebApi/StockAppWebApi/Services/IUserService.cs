using System;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Services
{
    public interface IUserService
    {
        Task<int> Register(RegisterViewModel registerViewModel);
    }
}

