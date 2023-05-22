import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  factory FirebaseMessagingService() {
    return _instance;
  }
  FirebaseMessagingService._internal();

  void showLocalNotification(RemoteMessage message) async {
    // Xử lý thông báo
    final notificationData = message.data; // Dữ liệu thông báo
    final notificationTitle = notificationData['title']; // Tiêu đề thông báo
    final notificationBody = notificationData['body']; // Nội dung thông báo

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    // Khởi tạo channel cho local notification
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'channel_1',
    'channel_1',
    importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID thông báo
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: 'notification_payload', // Dữ liệu kèm theo (nếu cần)
    );
  }

  Future<void> initialize() async {
    // Xác nhận quyền thông báo
    await _firebaseMessaging.requestPermission();

    // Lấy thông báo hiện tại nếu ứng dụng được mở từ thông báo
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();

    // Lắng nghe các thông báo trong khi ứng dụng đang chạy
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Xử lý thông báo
      showLocalNotification(message);
    });

    // Lắng nghe các thông báo khi ứng dụng được mở từ trạng thái đóng
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Xử lý thông báo
      showLocalNotification(message);
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
