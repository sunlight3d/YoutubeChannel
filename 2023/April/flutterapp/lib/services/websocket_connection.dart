import 'dart:async';

import 'package:web_socket_channel/io.dart';

class WebSocketConnection {
  late final String _hubUrl;
  final _controller = StreamController.broadcast();
  late IOWebSocketChannel _webSocketChannel;

  WebSocketConnection(String url) {
    _webSocketChannel = IOWebSocketChannel.connect(url);
    _hubUrl = url;
  }

  Stream get stream => _controller.stream;

  void connect() {
    _webSocketChannel = IOWebSocketChannel.connect(_hubUrl);
    _webSocketChannel.stream.listen((data) {
      _controller.add(data);
    });
  }

  void disconnect() {
    _webSocketChannel.sink.close();
    _controller.close();
  }

  void sendMessage(String message) {
    if (_webSocketChannel != null) {
      _webSocketChannel.sink.add(message);
    }
  }
}
