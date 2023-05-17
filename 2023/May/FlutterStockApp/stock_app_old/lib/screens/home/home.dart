import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/screens/home/assets/assets.dart';
import 'package:stock_app/screens/home/cash_transfer/cash_transfer.dart';
import 'package:stock_app/screens/home/drawers/left/left.dart';
import 'package:stock_app/screens/home/market/market.dart';
import 'package:stock_app/screens/home/trading/trading.dart';
import 'package:stock_app/screens/home/watchlist/watchlist.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    MarketScreen(),
    WatchListScreen(),
    TradingScreen(),
    AssetsScreen(),
    CashTransferScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: LeftDrawer(),
      body: Column(
        children: [
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      //Open drawer
                      _scaffoldKey.currentState?.openDrawer();
                    }, icon: const Icon(Icons.menu)),
                    Expanded(child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search something',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0)
                      ),
                    )),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        // Handle bell icon button press
                      },
                    ),
                  ],
                ),
              ) 
          ),
          _screens[_currentIndex]
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey.shade300,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_sharp),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.area_chart),
            label: 'Trading',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Cash Transfer',
          ),
        ]
      ),
    );
  }
}