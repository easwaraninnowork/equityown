import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    Key? key,
    required this.hintText,
  }): super(key : key);

  final String hintText;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      height: 50.0,
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border:  Border.all(color: Colors.grey),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0))),
          child: new Center(
            child: new Text(hintText),
          )),
    );
  }}