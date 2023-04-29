import 'package:flutter/material.dart';
import '../assets/assets.dart';
import '../cash_transfer/cash_transfer.dart';
import '../drawers/left/left.dart';
import '../market/market.dart';
import '../trading/trading.dart';
import '../watchlist/watchlist.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _screens = [
    MarketScreen(),
    WatchlistScreen(),
    TradingScreen(),
    AssetsScreen(),
    CashTransferScreen(),
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search/Add/Remove Symbol',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Handle bell icon button press
                    },
                  ),
                ],
              ),
            ),
          ),
          _screens[_currentIndex],
        ],
      ),
      //body:
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
            icon: Icon(Icons.list_sharp),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Market',
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
        ],
      ),
    );
  }
}