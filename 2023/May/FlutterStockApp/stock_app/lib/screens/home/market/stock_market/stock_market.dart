import 'package:flutter/material.dart';
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
  /*
  final List<String> industries = [
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
  ];
  */
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
                  value: _selectedIndex.isEmpty ?
                  (_indexes.firstOrNull ?? '') : _selectedIndex,
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
        Expanded(child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Symbol')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('+/-')),
                DataColumn(label: Text('+/- %')),
                DataColumn(label: Text('TotalVol')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('ABC')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                DataRow(cells: [
                  DataCell(Text('ZZ')),
                  DataCell(Text('123.1')),
                  DataCell(Text('12.3')),
                  DataCell(Text('11.0')),
                  DataCell(Text('12345')),
                ]),
                
              ],
            ),
          ),
        ),)
      ],
    );
  }
}

