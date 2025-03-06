import 'package:flutter/material.dart';
import 'package:quityown/widgets/constants.dart';


class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.icon,
    required this.textEditingController
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final IconData icon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 20,
            ),
          ),
          new Expanded(
            child: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
