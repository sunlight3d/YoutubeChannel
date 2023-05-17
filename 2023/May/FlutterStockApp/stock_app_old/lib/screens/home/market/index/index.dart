import 'package:flutter/material.dart';
import 'package:stock_app/screens/commons/utilities.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

