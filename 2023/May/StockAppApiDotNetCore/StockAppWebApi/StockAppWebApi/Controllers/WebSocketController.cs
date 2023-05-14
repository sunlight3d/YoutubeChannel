using System;
using Microsoft.AspNetCore.Http;
using System.Net.WebSockets;
using System.Text;
using Microsoft.AspNetCore.Mvc;


namespace StockAppWebApi.Controllers
{
    [Route("api/ws")]
    public class WebSocketController: ControllerBase
	{
		[HttpGet]
		public async Task Get() {
            if (HttpContext.WebSockets.IsWebSocketRequest)
            {
                using var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
                //sinh ngẫu nhiên 2 giá trị x, y, thay đổi 2 giây /
                var random = new Random();
                while (webSocket.State == WebSocketState.Open)
                {
                    // Tạo giá trị x, y ngẫu nhiên
                    int x = random.Next(1, 100);
                    int y = random.Next(1, 100);
                    var buffer = Encoding.UTF8.GetBytes($"{{ \"x\": {x}, \"y\": {y} }}");
                    await webSocket.SendAsync(
                        new ArraySegment<byte>(buffer),
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

