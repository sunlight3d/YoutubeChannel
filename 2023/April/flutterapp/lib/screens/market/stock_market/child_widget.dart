import 'package:flutter/material.dart';

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
      width: MediaQuery
          .of(context)
          .size
          .width - 60,
      height: 0.5 * MediaQuery
          .of(context)
          .size
          .height,
      decoration: BoxDecoration(
        color: Colors.red,
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
              togglePopup();
            },
          );
        },
      )),
    );
  }
}