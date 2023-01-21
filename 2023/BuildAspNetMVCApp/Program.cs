using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using StudentManagement.Models;
/*
add-migration initial
update-database
 */
namespace StudentManagement
{
    public class Program
    {        
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
                       
            builder.Services.AddDbContext<StudentManagementContext>(options =>
                options.UseSqlServer(builder.Configuration
                    .GetConnectionString("SQLServerConnection")));
            builder.Services.AddControllersWithViews();
            builder.Services.AddDatabaseDeveloperPageExceptionFilter();
            
            
            StudentManagementContext context = builder
                                                .Services?.BuildServiceProvider()
                                                .GetRequiredService<StudentManagementContext>();

            DbInitializer.Initialize(context);
            
            
            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
        }
    }
}