import 'package:flutter/material.dart';
import 'package:flutterapp/screens/market/stock_table.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';


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

  List<StockData> stockDataList = [
    StockData(
      symbol: 'AAPL',
      price: '135.44',
      plusMinus: '+1.23',
      plusMinusPercent: '+0.91%',
      totalVol: '12.4M',
    ),
    StockData(
      symbol: 'GOOGL',
      price: '2255.50',
      plusMinus: '-7.50',
      plusMinusPercent: '-0.33%',
      totalVol: '1.2M',
    ),
    StockData(
      symbol: 'AMZN',
      price: '3350.50',
      plusMinus: '+45.25',
      plusMinusPercent: '+1.37%',
      totalVol: '5.5M',
    ),
    StockData(
      symbol: 'NFLX',
      price: '542.95',
      plusMinus: '-2.25',
      plusMinusPercent: '-0.41%',
      totalVol: '2.8M',
    ),
    StockData(
      symbol: 'MSFT',
      price: '250.23',
      plusMinus: '+2.10',
      plusMinusPercent: '+0.85%',
      totalVol: '6.1M',
    ),
    StockData(
      symbol: 'FB',
      price: '312.46',
      plusMinus: '-3.32',
      plusMinusPercent: '-1.05%',
      totalVol: '3.9M',
    ),
    StockData(
      symbol: 'NVDA',
      price: '610.13',
      plusMinus: '-11.75',
      plusMinusPercent: '-1.89%',
      totalVol: '2.2M',
    ),
    StockData(
      symbol: 'PYPL',
      price: '268.05',
      plusMinus: '+1.85',
      plusMinusPercent: '+0.69%',
      totalVol: '4.7M',
    ),
    StockData(
      symbol: 'JPM',
      price: '150.20',
      plusMinus: '-0.25',
      plusMinusPercent: '-0.17%',
      totalVol: '7.3M',
    ),
    StockData(
      symbol: 'V',
      price: '224.35',
      plusMinus: '-0.48',
      plusMinusPercent: '-0.21%',
      totalVol: '3.5M',
    ),
    StockData(
      symbol: 'MA',
      price: '370.80',
      plusMinus: '+4.12',
      plusMinusPercent: '+1.12%',
      totalVol: '1.9M',
    ),
    StockData(
      symbol: 'BRK.A',
      price: '414820.00',
      plusMinus: '-720.00',
      plusMinusPercent: '-0.17%',
      totalVol: '12.0K',
    ),
    StockData(
      symbol: 'AAPL',
      price: '135.44',
      plusMinus: '+1.23',
      plusMinusPercent: '+0.91%',
      totalVol: '12.4M',
    ),
    StockData(
      symbol: 'AMZN',
      price: '3350.50',
      plusMinus: '+45.25',
      plusMinusPercent: '+1.37%',
      totalVol: '5.5M',
    ),
    StockData(
      symbol: 'NFLX',
      price: '542.95',
      plusMinus: '-2.25',
      plusMinusPercent: '-0.41%',
      totalVol: '2.8M',
    ),
    StockData(
      symbol: 'MSFT',
      price: '250.23',
      plusMinus: '+2.10',
      plusMinusPercent: '+0.85%',
      totalVol: '6.1M',
    ),
    StockData(
      symbol: 'FB',
      price: '312.46',
      plusMinus: '-3.32',
      plusMinusPercent: '-1.05%',
      totalVol: '3.9M',
    ),
    StockData(
      symbol: 'NVDA',
      price: '610.13',
      plusMinus: '-11.75',
      plusMinusPercent: '-1.89%',
      totalVol: '2.2M',
    ),
    StockData(
      symbol: 'PYPL',
      price: '268.05',
      plusMinus: '+1.85',
      plusMinusPercent: '+0.69%',
      totalVol: '4.7M',
    ),
    StockData(
      symbol: 'JPM',
      price: '150.20',
      plusMinus: '-0.25',
      plusMinusPercent: '-0.17%',
      totalVol: '7.3M',
    ),
    StockData(
      symbol: 'V',
      price: '224.35',
      plusMinus: '-0.48',
      plusMinusPercent: '-0.21%',
      totalVol: '3.5M',
    ),
    StockData(
      symbol: 'MA',
      price: '370.80',
      plusMinus: '+4.12',
      plusMinusPercent: '+1.12%',
      totalVol: '1.9M',
    ),
    StockData(
      symbol: 'BRK.A',
      price: '414820.00',
      plusMinus: '-720.00',
      plusMinusPercent: '-0.17%',
      totalVol: '12.0K',
    ),
    StockData(
      symbol: 'KO',
      price: '53.76',
      plusMinus: '-0.12',
      plusMinusPercent: '-0.22%',
      totalVol: '9.8M',
    ),
    StockData(
      symbol: 'BAC',
      price: '37.69',
      plusMinus: '-0.15',
      plusMinusPercent: '-0.40%',
      totalVol: '12.7M',
    ),
    StockData(
      symbol: 'DIS',
      price: '184.00',
      plusMinus: '+1.03',
      plusMinusPercent: '+0.56%',
      totalVol: '4.6M',
    ),
    StockData(
      symbol: 'TSLA',
      price: '683.80',
      plusMinus: '-12.56',
      plusMinusPercent: '-1.80%',
      totalVol: '8.7M',
    ),
    // Add more fake data here
  ];
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
        return StockTable(stockDataList: this.stockDataList);
      },
    ));
  }
}