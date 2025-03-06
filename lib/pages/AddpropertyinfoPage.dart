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

class AddPropertyinfoPage extends StatefulWidget{

  const AddPropertyinfoPage({super.key});

  @override
  State<AddPropertyinfoPage> createState() => _AddPropertyinfoPage();
}

class _AddPropertyinfoPage extends State<AddPropertyinfoPage> with SingleTickerProviderStateMixin{
  static const textfieldColor= const Color(0xffD6F5E7);
  static const backgroundcolor= const Color(0xfff1f5f9);
  late TabController _tabController;
  final propertyNameController = TextEditingController();
  final propertyCodeController = TextEditingController();
  final propertyValueController = TextEditingController();
  final propertyOverviewController = TextEditingController();


  initState()  {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    getSharedpref();
  }

  getSharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("propertyname") != ""){
      propertyNameController.text = prefs.getString("propertyname")!;
      propertyCodeController.text = prefs.getString("propertycode")!;
      propertyValueController.text = prefs.getString("propertyvalue")!;
      propertyOverviewController.text = prefs.getString("propertyoverview")!;
    }
  }

  Future<void> Savefunction() async {
    if(propertyNameController.text.toString() != "") {
      if (propertyCodeController.text.toString() != "") {
        if (propertyValueController.text.toString() != "") {
          if (propertyOverviewController.text.toString() != "") {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("propertyname", propertyNameController.text);
            prefs.setString("propertycode", propertyCodeController.text);
            prefs.setString("propertyvalue", propertyValueController.text);
            prefs.setString("propertyoverview", propertyOverviewController.text);

            Fluttertoast.showToast(
              msg: "Propery information saved successfully ",
              toastLength: Toast.LENGTH_SHORT,
            );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPropertiesPage(pageIndex: 1),
                  ));

          }
          else {
            Fluttertoast.showToast(
              msg: "Please enter property Overview",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
        else {
          Fluttertoast.showToast(
            msg: "Please enter property value",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      else {
        Fluttertoast.showToast(
          msg: "Please enter property code",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else{
      Fluttertoast.showToast(
        msg: "Please enter propert name",
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
            backgroundColor: backgroundcolor,
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
                                      Text('Property information',style: blackHeadStyle,textAlign: TextAlign.left,),
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
                                                    controller: propertyNameController,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      ),
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Name",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),
                                                        ],
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                    ),
                                                    autofocus: true,
                                                    keyboardType: TextInputType.text,
                                                  )
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
                                                  child:
                                                  TextField(
                                                    controller: propertyCodeController,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      ),
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Code",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                    ),
                                                    autofocus: true,
                                                    keyboardType: TextInputType.text,
                                                  )
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
                                                  child:
                                                  TextField(
                                                    controller: propertyValueController,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      ),
                                                      label:
                                                      Row(
                                                        children: [
                                                          Text("Value",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                    ),
                                                    autofocus: true,
                                                    keyboardType: TextInputType.text,
                                                  )
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
                                                alignment: Alignment.topLeft,
                                                child:
                                                TextFormField(
                                                  controller: propertyOverviewController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      label:
                                                      Row(
                                                         mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text("Overview",style: TextStyle(fontSize: 12),),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0),
                                                          ),
                                                          const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                        ],
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 12),
                                                      fillColor: Colors.white
                                                  ),
                                                  minLines: 6, // any number you need (It works as the rows for the textarea)
                                                  keyboardType: TextInputType.multiline,
                                                  maxLines: null,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
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
                                            onPressed: (){
                                              Savefunction();
                                            },
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

