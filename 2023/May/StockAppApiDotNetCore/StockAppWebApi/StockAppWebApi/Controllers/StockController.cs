using System;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Repositories;
using StockAppWebApi.Services;

namespace StockAppWebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]

    public class StockController : ControllerBase    
    {
        private readonly IStockService _stockService;
        public StockController(IStockService stockService)
        {
            _stockService = stockService;
        }
        [HttpGet("sectors")]
        public async Task<IActionResult> GetDistinctSectors() {
            var distinctAreas = await _stockService.GetDistinctSectors();
            return Ok(distinctAreas);
        }

        [HttpGet("industries")]
        public async Task<IActionResult> GetDistinctIndustries()
        {
            var distinctIndustries = await _stockService.GetDistinctIndustries();
            return Ok(distinctIndustries);
        }
    }
}

