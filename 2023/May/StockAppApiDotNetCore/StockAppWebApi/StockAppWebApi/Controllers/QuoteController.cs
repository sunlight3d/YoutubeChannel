using System;
using System.Net.WebSockets;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using StockAppWebApi.Models;
using StockAppWebApi.Repositories;
using StockAppWebApi.Services;
using System.Text.Json;

namespace StockAppWebApi.Controllers
{
    [ApiController]
    [Route("api/ws/[controller]")]
    public class QuoteController : ControllerBase
    {
        private readonly IQuoteService _quoteService;
        public QuoteController(IQuoteService quoteService)
        {
            _quoteService = quoteService;
        }
        [HttpGet]
        public async Task GetRealtimeQuotes(int page = 1, int limit = 10) { 
            if (HttpContext.WebSockets.IsWebSocketRequest)
            {
                using var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
                //await _webSocketManager.AddWebSocket(webSocket);
                while (webSocket.State == WebSocketState.Open)
                {

                    List<RealtimeQuote>? quotes =  await _quoteService.GetRealtimeQuotes(page, limit);
                    string jsonString = JsonSerializer.Serialize(quotes);
                    var buffer = Encoding.UTF8.GetBytes(jsonString);
                    await webSocket.SendAsync(new ArraySegment<byte>(buffer),
                        WebSocketMessageType.Text, true, CancellationToken.None);

                    await Task.Delay(2000); // Đợi 2 giây trước khi gửi giá trị tiếp theo
                }
                await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure,
                    "Connection closed by the server", CancellationToken.None);
            }
            else
            {
                HttpContext.Response.StatusCode = StatusCodes.Status400BadRequest;
            }
        }
    }
}

