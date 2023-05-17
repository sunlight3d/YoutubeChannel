import 'package:flutter/material.dart';
import 'package:stock_app/screens/commons/utilities.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CoveredWarrants extends StatefulWidget {
  const CoveredWarrants({Key? key}) : super(key: key);

  @override
  State<CoveredWarrants> createState() => _CoveredWarrantsState();
}

class _CoveredWarrantsState extends State<CoveredWarrants> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _symbols = [
    'MSN',
    'MSG',
    'POW',
    'STB',
  ];
  String _selectedSymbol = '';

  final List<String> _issuers = [
    'HSC',
    'SSI',
    'ACBS',
    'PHS',
  ];
  String _selectedIssuer = '';

  bool _showDatePicker = false;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        hint: const Text('Symbol'),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        value: _selectedSymbol.isEmpty ? null : _selectedSymbol,
                        items: _symbols.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedSymbol = selectedItem ?? '';
                          });
                        }
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        hint: const Text('Issuer'),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        value: _selectedIssuer.isEmpty ? null : _selectedIssuer,
                        items: _issuers.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedIssuer = selectedItem ?? '';
                          });
                        }
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Text('Choose date', style: TextStyle(fontSize: 16),),
                        const SizedBox(width: 5,),
                        const Icon(Icons.date_range)
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _showDatePicker = true;
                      });
                    },
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
          ),
          onTap: () {
            if(_showDatePicker) {
              setState(() {
                _showDatePicker = false;
              });
            }
          },
        ),
        if(_showDatePicker) 
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: SfDateRangePicker(
              backgroundColor: Colors.white,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if(args.value is PickerDateRange) {
                  setState(() {
                    _startDate = ((args.value as PickerDateRange).startDate) ?? _startDate;
                    _endDate = ((args.value as PickerDateRange).endDate) ?? _endDate;
                  });
                }
              },
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(const Duration(days: 3)))
          ))
      ],
    );
  }
}

