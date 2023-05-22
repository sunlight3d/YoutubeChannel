import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Xác nhận quyền thông báo
    await _firebaseMessaging.requestPermission();

    // Lấy thông báo hiện tại nếu ứng dụng được mở từ thông báo
    RemoteMessage? initialMessage =
    await _firebaseMessaging.getInitialMessage();

    // Lắng nghe các thông báo trong khi ứng dụng đang chạy
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Xử lý thông báo
    });
    // Lắng nghe các thông báo khi ứng dụng được mở từ trạng thái đóng
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Xử lý thông báo
    });
    // Lắng nghe token FCM
    _firebaseMessaging.getToken().then((String? token) {
      if (token != null) {
        print('FCM Token: $token');
        // Thực hiện xử lý khác với FCM Token ở đây
      }
    });
  }
}