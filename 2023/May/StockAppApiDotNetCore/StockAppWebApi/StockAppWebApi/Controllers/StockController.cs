using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Services;

namespace StockAppWebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StockController : ControllerBase
    {
        private readonly IStockService _stockService;
        public StockController(IStockService stockService)
        {
            _stockService = stockService;
        }
        [HttpGet("sectors")]
        public async Task<IActionResult> GetDistinctSectors()
        {
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
