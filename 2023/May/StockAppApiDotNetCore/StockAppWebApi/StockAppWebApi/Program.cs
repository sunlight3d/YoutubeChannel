using Microsoft.AspNetCore.Authentication.JwtBearer;
using System.Text;
using Microsoft.AspNetCore.DataProtection.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;
using StockAppWebApi.Services;
using StockAppWebApi.Filters;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var settings = builder.Configuration
                .GetRequiredSection("ConnectionStrings"); //read data from appsettings.json
builder.Services.AddDbContext<StockAppContext>(options =>
        options.UseSqlServer(settings["DefaultConnection"]));
builder.Services.AddControllers();
//repositories, services
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IUserService, UserService>();

builder.Services.AddScoped<IWatchListRepository, WatchListRepository>();
builder.Services.AddScoped<IWatchListService, WatchListService>();

builder.Services.AddScoped<IStockRepository, StockRepository>();
builder.Services.AddScoped<IStockService, StockService>();

builder.Services.AddScoped<JwtAuthorizeFilter>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Đăng ký dịch vụ phân quyền
builder.Services.AddAuthorization();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();
app.UseAuthentication();

app.MapControllers();

app.Run();

