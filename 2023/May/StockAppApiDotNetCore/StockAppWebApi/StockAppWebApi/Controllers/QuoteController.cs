using System;
using System.Net.WebSockets;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Models;
using StockAppWebApi.Services;

namespace StockAppWebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class QuoteController : ControllerBase
    {
        private readonly IQuoteService _quoteService;
        public QuoteController(IQuoteService quoteService)
        {
            _quoteService = quoteService;
        }
        [HttpGet("ws")]
        //https://localhost:port/api/quote/ws
        public async Task GetRealtimeQuotes(
            int page = 1, int limit = 10,
            string sector = "",
            string industry = ""
            )
        {
            if (HttpContext.WebSockets.IsWebSocketRequest)
            {
                using var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
                //await _webSocketManager.AddWebSocket(webSocket);
                while (webSocket.State == WebSocketState.Open)
                {
                    List<RealtimeQuote>? quotes = await _quoteService
                                                    .GetRealtimeQuotes(page, limit, sector, industry);
                    //convert list of objects to json
                    string jsonString = JsonSerializer.Serialize(quotes);
                    var buffer = Encoding.UTF8.GetBytes(jsonString);
                    await webSocket.SendAsync(new ArraySegment<byte>(buffer),
                        WebSocketMessageType.Text, true, CancellationToken.None);

                    await Task.Delay(2000); // Đợi 2 giây trước khi gửi giá trị tiếp theo
                }
            }
            else
            {

            }
        }
    }
}

