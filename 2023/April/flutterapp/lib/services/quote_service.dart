import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'web_socket_connection.dart';

class QuoteService {
  final WebSocketConnection _webSocketConnection;
  final _controller = StreamController.broadcast();

  Stream get stream => _controller.stream;

  QuoteService(this._webSocketConnection) {
    _webSocketConnection.stream.listen((data) {
      final parsedData = json.decode(data);
      _controller.add(parsedData);
    });
  }

  void subscribeToStocksRealTime({
    int page = 1,
    int pageSize = 20,
    String sector = "",
    String industry = "",
  }) {
    final message = {
      "type": "subscribe",
      "page": page,
      "pageSize": pageSize,
      "sector": sector,
      "industry": industry,
    };
    final messageJson = json.encode(message);
    _webSocketConnection.sendMessage(messageJson);
  }

  void unsubscribeFromStocksRealTime() {
    final message = {"type": "unsubscribe"};
    final messageJson = json.encode(message);
    _webSocketConnection.sendMessage(messageJson);
  }
}
