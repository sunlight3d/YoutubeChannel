import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'websocket_connection.dart';

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
  static final QuoteService _singleton = QuoteService(
      //wsslà giao thức truyền thông bảo mật sử dụng SSL/TLS
      WebSocketConnection("ws://localhost/quoteHub"));

  factory QuoteService.getInstance() {
    return _singleton;
  }
  Future<void> connect() async {
    try {
      _webSocketConnection.connect();
    } catch (e) {
      print('Cannot connect to WebSocket server: $e');
    }
  }
  Future<void> disconnect() async {
    if (_webSocketConnection != null) {
      _webSocketConnection.disconnect();
    }
  }
  void subscribeToStocksRealTime(void Function(dynamic data) onDataReceived, {
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
