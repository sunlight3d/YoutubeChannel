import 'package:flutter/material.dart';
import 'package:stock_app/screens/commons/utilities.dart';

class Industry extends StatefulWidget {
  const Industry({Key? key}) : super(key: key);

  @override
  State<Industry> createState() => _IndustryState();
}

class _IndustryState extends State<Industry> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _industries = [
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
  String _selectedIndustry = '';
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
                  hint: const Text('Select Industry'),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  value: _selectedIndustry.isEmpty ? null : _selectedIndustry,
                  items: _industries.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      _selectedIndustry = selectedItem ?? '';
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
              dividerThickness: 1.0, // Độ dày của đường phân cách
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

