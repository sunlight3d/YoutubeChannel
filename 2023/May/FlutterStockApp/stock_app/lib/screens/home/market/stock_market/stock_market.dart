import 'package:flutter/material.dart';
import 'package:stock_app/models/RealtimeQuote.dart';
import 'package:stock_app/repositories/RealtimeQuoteRepository.dart';
import 'package:stock_app/screens/commons/utilities.dart';

class StockMarket extends StatefulWidget {
  const StockMarket({Key? key}) : super(key: key);

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _indexes = [
    'VN30',
    'HOSE',
    'HNX',
    'UPCOM'
  ];
  String _selectedIndex = '';

  Stream<List<RealtimeQuote>>? _quoteStream;
  int _page = 1;
  int _limit = 20;
  bool _isConnected = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quoteStream = RealtimeQuoteRepository.getRealtimeQuoteList(_page, _limit);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<String>(
                  icon: const Icon(Icons.arrow_downward),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  hint: const Text('Select Index'),
                  value: _selectedIndex.isEmpty ? null : _selectedIndex,
                  items: _indexes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      _selectedIndex = selectedItem ?? '';
                    });
                  }
              ),
            )
          ],
        ),
        StreamBuilder(stream: _quoteStream, builder: (context, snapshot){
          if(snapshot.hasData) {
            final quoteList = snapshot.data!;
            return Expanded(child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  dividerThickness: 1.0, // Độ dày của đường phân cách
                  columns: [
                    DataColumn(label: Text('Symbol')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('+/-')),
                    DataColumn(label: Text('+/- %')),
                    DataColumn(label: Text('TotalVol')),
                  ],
                  rows: quoteList
                      .map(
                        (quote) {
                          print('haha');
                          return DataRow(
                            cells: [
                              DataCell(Text(quote.symbol ?? '')),
                              DataCell(Text(quote.companyName ?? '')),
                              DataCell(Text(quote.price.toString())),
                              DataCell(Text(quote.change.toString())),
                              DataCell(Text(quote.volume.toString())),
                            ],
                          );
                        },
                  )
                      .toList(),
                ),
              ),
            ),);
          } else if (snapshot.hasError) {
            // Xử lý lỗi kết nối
            if (!_isConnected) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Gọi hàm để làm mới dữ liệu
                    _quoteStream = RealtimeQuoteRepository.getRealtimeQuoteList(_page, _limit);
                  },
                  child: Text('Refresh'),
                ),
              );
            } else {
              return Text('Error: ${snapshot.error}');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })
      ],
    );
  }
}


