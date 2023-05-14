using System;
using Microsoft.Data.SqlClient;
using System.Diagnostics.Metrics;
using System.Numerics;
using Microsoft.EntityFrameworkCore;
using StockAppWebApi.Models;
using StockAppWebApi.ViewModels;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace StockAppWebApi.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly StockAppContext _context;
        private readonly IConfiguration _config;

        public UserRepository(StockAppContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
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
            string sql = "EXECUTE dbo.RegisterUser @username, " +
                            "@password, " +
                            "@email, " +
                            "@phone, " +
                            "@full_name, " +
                            "@date_of_birth, " +
                            "@country";
            IEnumerable<User> result = await _context.Users.FromSqlRaw(sql,
                        new SqlParameter("@username", registerViewModel.Username ?? ""),
                        new SqlParameter("@password", registerViewModel.Password),
                        new SqlParameter("@email", registerViewModel.Email),
                        new SqlParameter("@phone", registerViewModel.Phone ?? ""),
                        new SqlParameter("@full_name", registerViewModel.FullName ?? ""),
                        new SqlParameter("@date_of_birth", registerViewModel.DateOfBirth),
                        new SqlParameter("@country", registerViewModel.Country)).ToListAsync();            

            User? user = result.FirstOrDefault();
            return user;
        }
        public async Task<string> Login(LoginViewModel loginViewModel) {
            string sql = "EXECUTE dbo.CheckLogin @email, @password";
            IEnumerable<User> result = await _context.Users.FromSqlRaw(sql,
                        new SqlParameter("@email", loginViewModel.Email),
                        new SqlParameter("@password", loginViewModel.Password))
                .ToListAsync();

            User? user = result.FirstOrDefault();
            if (user != null)
            {
                //tạo ra jwt string để gửi cho client
                // Nếu xác thực thành công, tạo JWT token
                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(_config["Jwt:SecretKey"] ?? "");
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                        new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString()),                        
                    }),
                    Expires = DateTime.UtcNow.AddDays(30),
                    SigningCredentials = new SigningCredentials
                        (new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                };
                var token = tokenHandler.CreateToken(tokenDescriptor);
                var jwtToken = tokenHandler.WriteToken(token);                
                return jwtToken;
            }
            else {
                throw new ArgumentException("Wrong email or password");
            }            
        }
    }

}

