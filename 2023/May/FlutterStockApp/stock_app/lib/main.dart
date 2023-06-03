import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/firebase_options.dart';
import 'package:stock_app/notification/local_notification.dart';
import 'package:stock_app/repositories/firebase_respository.dart';
import 'package:stock_app/repositories/user_repository.dart';
import 'package:stock_app/screens/chart/chart.dart';
import 'package:stock_app/screens/home/home.dart';
import 'package:stock_app/screens/login/login.dart';
import 'package:splash_screen_package/splash_screen_package.dart';

import 'screens/biometrics/biometric_login.dart';
import 'screens/webview/webview_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //auto-generate
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotification.initialize();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification.showNotification(message);
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  //lấy device's token để test FCM, với ios phải có real device
  FirebaseMessaging.instance.getToken().then((value) {
    String? token = value;
    print(token ?? "");
    //ios: eqi5-7nBsE9nrf2YOZ1wYo:APA91bGYS1R3BQMLp007_b5f6sXMg_iZeRpZ1_pdl3KbcFTUp8St9epyT2XOt72ED3Ku0liYMApPenZxNP65pzcYKPFEzdMyf5ynJ-9q1wZn0zwDVj5HaDxIG1ga4DjwCL0hCAunz5sk
    //ios: dBVLTV59Y0fxrlXFVrwFLV:APA91bFgJhwN1iqjqz48dOplS7ETZPrfE0Bh4MoOwX2g5GRSmFJa2APVyPdY__Nne8-DYt0RkJaLhc-M4ktqxg2mu04pTym4pJAvQOBMzRHMuV7XhDGnE2cYm_pJl3-nHFyS7HMRSnJl
    //android: dR-iR1TITqe-EHbwyf6Z0a:APA91bFOKkMhBSUJFllaFX5ujlWedx2uZKupM1zRosbth9k7s_jk4yLfJqnvrXjqN9E8Y5KX_kV6bllYu4gIugRbH0RZbc6NIoo53VpAAhd0iTUAZZ5iu17tb2wHs4M3c2L1Wag3XkPG
  });
  /*
  FirebaseRepository.createRecord();
  FirebaseRepository.listen((responseData){
    print("haha");
  });
  */
  runApp(const MyApp());
}

Future<void> checkLoginStatus(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isTokenExpired = UserRepository.isTokenValid(prefs.getString('token') ?? "");
  await Future.delayed(const Duration(seconds: 1));
  if (isTokenExpired) {
    // Đã đăng nhập, chuyển sang màn hình HomeScreen
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  } else {
    // Chưa đăng nhập, chuyển sang màn hình LoginScreen
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //home: BiometricLoginScreen()
      home: WebViewScreen()
      //home: Chart()
      // home:SplashScreen(
      //   title: 'Splassssss',
      //   checkLoginStatus: checkLoginStatus,
      // ),

      //home: LoginScreen(),
      //home: HomeScreen(),
    );
  }
}
/*
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/sunlight3d/splash_screen_package.git
git push -u origin master

git tag -a v0.0.1 -m "Phiên bản đầu tiên"
git push origin v0.0.1
* */
/*
Tôi có 1 ứng dụng flutter, muốn gọi Websocket đến url sau:
wss://localhost:7036/api/Quote/ws?page=${page}&limit=${limit}
Giá trị trả về là danh sách đối tượng, mỗi đối tượng có những trường sau:
int quoteId,string? Symbol,string? CompanyName,string? IndexName,
string? IndexSymbol,decimal MarketCap,string? SectorEn,string? IndustryEn,
string? Sector,string? Industry,string? StockType,decimal Price,decimal Change
decimal PercentChange,int Volume,DateTime TimeStamp
Viết cho tôi đoạn gọi webservice,viết cả Model(tên là RealtimeQuote), Repository, hiện dữ liệu lên datatable
Viết phần inject repository vào
Hướng dẫn cách gọi api từ App android đến localhost
* */

/*
Firebase DB:
https://stockapp-b0883-default-rtdb.asia-southeast1.firebasedatabase.app/

* */
