import 'package:flutter/material.dart';
import 'package:flutterapp/providers/api_provider.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/screens/login/login.dart';
import 'package:flutterapp/screens/settings/settings.dart';
import 'package:flutterapp/screens/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: SplashScreen(),
        home: HomeScreen(),
        //home: SettingsScreen()
      ),
    );
  }
}