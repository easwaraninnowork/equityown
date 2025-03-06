import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quityown/pages/AddPropertiesPage.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddpropertyLocationPage extends StatefulWidget{

  const AddpropertyLocationPage({super.key});

  @override
  State<AddpropertyLocationPage> createState() => _AddpropertyLocationPage();
}

class _AddpropertyLocationPage extends State<AddpropertyLocationPage> with SingleTickerProviderStateMixin{
  static const textfieldColor= const Color(0xffD6F5E7);
  static const backgroundcolor= const Color(0xfff1f5f9);
  late TabController _tabController;
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final zipcodeController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();


  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    getSharedpref();
  }

  getSharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("propertyname") != ""){
      addressController.text = prefs.getString("address")!;
      stateController.text = prefs.getString("state")!;
      cityController.text = prefs.getString("city")!;
      zipcodeController.text = prefs.getString("zipcode")!;
      latitudeController.text = prefs.getString("latitude")!;
      longitudeController.text = prefs.getString("longitude")!;
    }
  }

  Future<void> Savefunction() async {
    if(addressController.text.toString() != "") {
      if (stateController.text.toString() != "") {
        if (cityController.text.toString() != "") {
          if (zipcodeController.text.toString() != "") {
            if (latitudeController.text.toString() != "") {
              if (longitudeController.text.toString() != "") {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("address", addressController.text);
                prefs.setString("state", stateController.text);
                prefs.setString("city", cityController.text);
                prefs.setString("zipcode", zipcodeController.text);
                prefs.setString("latitude", latitudeController.text);
                prefs.setString("longitude", longitudeController.text);

                Fluttertoast.showToast(
                  msg: "Propery information saved successfully ",
                  toastLength: Toast.LENGTH_SHORT,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddPropertiesPage(pageIndex: 3),
                    ));

              }
              else {
                Fluttertoast.showToast(
                  msg: "Please enter longitude",
                  toastLength: Toast.LENGTH_SHORT,
                );
              }

            }
            else {
              Fluttertoast.showToast(
                msg: "Please enter zipcode",
                toastLength: Toast.LENGTH_SHORT,
              );
            }

          }
          else {
            Fluttertoast.showToast(
              msg: "Please enter zipcode",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
        else {
          Fluttertoast.showToast(
            msg: "Please enter city",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      else {
        Fluttertoast.showToast(
          msg: "Please enter state",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else{
      Fluttertoast.showToast(
        msg: "Please enter address",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset : false,
            backgroundColor: Colors.white10,
            body:SingleChildScrollView(
                child:
                Padding(padding: EdgeInsets.all(10.0),
                  child:
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white
                    ),
                    child:
                    Padding(padding: EdgeInsets.all(10.0),
                        child:
                        Container(
                          color: backgroundcolor,
                          child: Column(
                              children:
                              <Widget>
                              [
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20,),
                                      Column(
                                        children:
                                        [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                margin: EdgeInsets.only(top: 15),
                                                child:
                                                TextField(
                                                  controller: addressController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      ),
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Address",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintText: '',
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      filled: true,
                                                      fillColor: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Column(
                                        children:
                                        [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                margin: EdgeInsets.only(top: 15),
                                                height: 40,
                                                child:
                                                TextField(
                                                  controller: stateController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("State",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintText: ' ',
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      filled: true,
                                                      fillColor: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Column(
                                        children:
                                        [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                margin: EdgeInsets.only(top: 15),
                                                height: 40,
                                                child:
                                                TextField(
                                                  controller: cityController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("City",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintText: '',
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      filled: true,
                                                      fillColor: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Column(
                                        children:
                                        [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                margin: EdgeInsets.only(top: 15),
                                                height: 40,
                                                child:
                                                TextField(
                                                  controller: zipcodeController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Zip code",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintText: '',
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      filled: true,
                                                      fillColor: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Column(
                                        children:
                                        [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                margin: EdgeInsets.only(top: 15),
                                                height: 40,
                                                child:
                                                TextField(
                                                  controller: latitudeController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Latitude",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintText: '',
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      filled: true,
                                                      fillColor: Colors.white
                                                  )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Column(
                                        children:
                                        [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                margin: EdgeInsets.only(top: 15),
                                                height: 40,
                                                child:
                                                TextField(
                                                  controller: longitudeController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Longitude",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintText: '',
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      filled: true,
                                                      fillColor: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Center(
                                        child: Container(
                                            width: 250,
                                            height: 150,
                                            child: Image.asset('assets/images/pro_location.png')
                                        ),
                                      ),
/*
                                      Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.60,
                                        height: 200,
                                        child: Image.asset('assets/images/pro_location.png'),
                                      ),
*/
                                      SizedBox(height: 10,),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child:
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width * 0.30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateProperty.resolveWith(
                                                    (states) => Colors.black12,
                                              ),
                                            ),
                                            onPressed: (){ Savefunction(); },
                                            child: Text(
                                              "Save",
                                              style: kButtonText.copyWith(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                )
                              ]
                          ),
                        )),
                  ),
                )
            )),
      );
  }

}