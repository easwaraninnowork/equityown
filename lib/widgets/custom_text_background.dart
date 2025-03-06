import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextBackground extends StatelessWidget {
  const CustomTextBackground({
    Key? key,
    required this.hintText,
    required this.background_color,
    required this.text_color,
  }): super(key : key);

  final String hintText;
  final Color background_color;
  final Color text_color;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      height: 50.0,
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: background_color,
              border:  Border.all(color: Colors.grey),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0))),
          child: new Center(
            child: new Text(hintText,style: TextStyle(color: text_color),),
          )),
    );
  }}