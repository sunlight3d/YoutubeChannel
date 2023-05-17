import 'package:flutter/material.dart';

class TradingScreen extends StatefulWidget {
  const TradingScreen({Key? key}) : super(key: key);

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Trading screen'),
    );
  }
}
