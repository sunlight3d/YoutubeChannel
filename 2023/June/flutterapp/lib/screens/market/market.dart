import 'package:flutter/material.dart';
import 'package:flutterapp/models/quote_realtime.dart';
import 'package:flutterapp/screens/market/stock_market/stock_market.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';

import 'stock_market/child_widget.dart';


class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final List<String> categories = [
    'Stock Market',
    'Industry',
    'Index',
    'Derivatives',
    'Cover Warrants',
    'ETF',
    'Top Stock',
  ];

  List<QuoteRealtime> data = [
    // Add more fake data here
  ];
  OverlayEntry? _overlayEntry;
  bool _isPopupVisible = false;
  void _togglePopup() {
    if (_isPopupVisible) {
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createPopupOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    }
    _isPopupVisible = !_isPopupVisible;
  }
  OverlayEntry _createPopupOverlay() {
    return OverlayEntry(
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          _togglePopup();
        },
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent tap from closing the popup
              child: Opacity(
                opacity: 0.9,
                child: ChildWidget(
                  togglePopup: _togglePopup,
                  data: [
                    'Software & Services',
                    'Technology Hardware & Equipment',
                    'Semiconductors & Semiconductor Equipment',
                    'Pharmaceuticals',
                    'Biotechnology',
                    'Medical Devices & Supplies',
                    'Banking',
                    'Insurance',
                    'Asset Management & Custody Banks',
                    'Automobiles & Components',
                    'Consumer Durables & Apparel',
                    'Retailing',
                    'Food & Staples Retailing',
                    'Household & Personal Products',
                    'Oil, Gas & Consumable Fuels',
                    'Energy Equipment & Services',
                    'Electric Utilities',
                    'Metals & Mining',
                    'Chemicals',
                    'Wireless Telecommunication Services',
                  ],
                  onPressItem: (selectedItem) {
                    debugPrint(selectedItem);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(child: InfiniteScrollTabView(
      contentLength: categories.length,
      onTabTap: (index) {
        debugPrint('tapped $index');
      },
      tabBuilder: (index, isSelected) => Text(
        categories[index],
        style: TextStyle(
          color: isSelected ? Colors.pink : Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      separator: const BorderSide(color: Colors.black12, width: 2.0),
      onPageChanged: (index) => debugPrint('page changed to $index.'),
      indicatorColor: Colors.pink,
      pageBuilder: (context, index, _) {
        if(index == 0) {
          return StockMarketScreen();
        }
        return Text('aa');
      },
    ));
  }
}