using System;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;
using StockAppWebApi.ViewModels;

namespace StockAppWebApi.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<User?> GetUserById(int userId)
        {
            User? user = await _userRepository.GetById(userId);
            return user;
        }

        public async Task<string> Login(LoginViewModel loginViewModel) {
            // Thực hiện thêm mới user
            return await _userRepository.Login(loginViewModel);
        }
        public async Task<User?> Register(RegisterViewModel registerViewModel)
        {
            // Kiểm tra xem username hoặc email đã tồn tại trong database chưa
            //Tạo ra đối tượng User từ RegisterViewModel            
            var existingUserByUsername = await _userRepository
                        .GetByUsername(registerViewModel.Username ?? "");
            if (existingUserByUsername != null)
            {
                throw new ArgumentException("Username already exists");
            }

            var existingUserByEmail = await _userRepository
                .GetByEmail(registerViewModel.Email);
            if (existingUserByEmail != null)
            {
                throw new ArgumentException("Email already exists");
            }

            // Thực hiện thêm mới user
            return await _userRepository.Create(registerViewModel);
        }

    }
}

