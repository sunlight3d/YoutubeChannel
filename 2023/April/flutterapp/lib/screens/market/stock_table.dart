import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class StockTable extends StatefulWidget {
  final List<StockData> stockDataList;
  StockTable({required this.stockDataList});
  @override
  _StockTableState createState() => _StockTableState();
}

class _StockTableState extends State<StockTable> {

  OverlayEntry? _overlayEntry;
  bool _isPopupVisible = false;
  void _togglePopup() {
    if (_isPopupVisible) {
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createPopupOverlay();
      Overlay.of(context)?.insert(_overlayEntry!);
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
    return Column(
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Expanded(child: Text('This is'),),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down), onPressed: () {  },
                )
              ],
            ),
          ),
          onTap: () {
            _togglePopup();
          },
        ),
        Expanded(
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
              rows: this.widget.stockDataList.map((data) {
                return DataRow(cells: [
                  DataCell(Text(data.symbol)),
                  DataCell(Text(data.price)),
                  DataCell(Text(data.plusMinus)),
                  DataCell(Text(data.plusMinusPercent)),
                  DataCell(Text(data.totalVol)),
                ]);
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Table Footer Text',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
class StockData {
  final String symbol;
  final String price;
  final String plusMinus;
  final String plusMinusPercent;
  final String totalVol;

  StockData({
    required this.symbol,
    required this.price,
    required this.plusMinus,
    required this.plusMinusPercent,
    required this.totalVol,
  });
}

class ChildWidget extends StatelessWidget {
  final List<String> data;
  final Function(String) onPressItem;
  final Function togglePopup;

  const ChildWidget({
    Key? key,
    required this.data,
    required this.onPressItem,
    required this.togglePopup
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 0.5 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                data[index],
                style: TextStyle(fontSize: 16),
              ),
            ),
            onTap: () {
              onPressItem(data[index]);
              togglePopup!();
            },
          );
        },
      )),
    );
  }
}