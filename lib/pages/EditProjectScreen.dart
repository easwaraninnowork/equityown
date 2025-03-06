import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/AddPropertiesPage.dart';
import 'package:quityown/pojo/EditPropertySavedRes.dart';
import 'package:quityown/pojo/ErrorRes.dart';
import 'package:quityown/pojo/PropertyInRes.dart';
import 'package:quityown/pojo/StateListRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProjectScreen extends StatefulWidget{

  const EditProjectScreen({super.key});

  @override
  State<EditProjectScreen> createState() => _EditProjectScreen();
}

class _EditProjectScreen extends State<EditProjectScreen> with SingleTickerProviderStateMixin{
  static const textfieldColor= const Color(0xffD6F5E7);
  static const backgroundcolor= const Color(0xfff1f5f9);
  late TabController _tabController;
  final propertyNameController = TextEditingController();
  final propertyCodeController = TextEditingController();
  final propertyValueController = TextEditingController();
  final propertyOverviewController = TextEditingController();

  final startdate_controller = TextEditingController();
  final projectStartDateController = TextEditingController();
  final projectedgrossyieldController = TextEditingController();
  final projectDeliveryDateController = TextEditingController();
  final tenureController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? _selectedDate;

  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final zipcodeController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();


  Future<void> _selectProjectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Default to today's date if no date is selected
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {

        _selectedDate = picked;
        DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(_selectedDate.toString());
        String formattedDateString = DateFormat('dd/MM/yyyy').format(formattedDate);

        print(formattedDateString);
        projectStartDateController.text = formattedDateString;
      });
    }
  }
  Future<void> _selectProjectDeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Default to today's date if no date is selected
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {

        _selectedDate = picked;
        DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(_selectedDate.toString());
        String formattedDateString = DateFormat('dd/MM/yyyy').format(formattedDate);

        print(formattedDateString);
        projectDeliveryDateController.text = formattedDateString;
      });
    }
  }

  var stateList = [];

  initState()  {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();

    statesApi();
    propertyIndApi();

    //getSharedpref();
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
            if (projectedgrossyieldController.text.toString() != "") {
              if (tenureController.text.toString() != "") {
                if (valueController.text.toString() != "") {
                  if (projectStartDateController.text.toString() != "") {
                    if (projectDeliveryDateController.text.toString() != "") {
                      if (addressController.text.toString() != "") {
                        if (stateController.text.toString() != "") {
                          if (cityController.text.toString() != "") {
                            if (latitudeController.text.toString() != "") {
                              if (longitudeController.text.toString() != "") {
                                SaveApifun();
                              }
                              else {
                                Fluttertoast.showToast(
                                  msg: "Please enter Longitude",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            }
                            else {
                              Fluttertoast.showToast(
                                msg: "Please enter Latitude",
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
                            msg: "Please enter property Overview",
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
                    }
                    else {
                      Fluttertoast.showToast(
                        msg: "Please select project delivery date",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  }
                  else {
                    Fluttertoast.showToast(
                      msg: "Please select project start date",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                }
                else {
                  Fluttertoast.showToast(
                    msg: "Please enter Annual rate value",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              }
              else {
                Fluttertoast.showToast(
                  msg: "Please enter Tenure",
                  toastLength: Toast.LENGTH_SHORT,
                );
              }
            }
            else {
              Fluttertoast.showToast(
                msg: "Please enter Projected gross yield",
                toastLength: Toast.LENGTH_SHORT,
              );
            }
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
                Column(
                  children: [
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
                                          SizedBox(height: 20,),
                                        ],
                                      ),
                                    )
                                  ]
                              ),
                            )),
                      ),
                    ),
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
                                          Text('Property details',style: blackHeadStyle,textAlign: TextAlign.left,),

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
                                                      controller: projectedgrossyieldController,
                                                      decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                          ),
                                                          label:
                                                          Row(
                                                            children: [
                                                              Text("Projected gross yield ",style: TextStyle(fontSize: 12),),
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
                                                    child:
                                                    TextField(
                                                      controller: tenureController,
                                                      decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                          ),
                                                          label:
                                                          Row(
                                                            children: [
                                                              Text("Tenure",style: TextStyle(fontSize: 12),),
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
                                                    child:
                                                    TextField(
                                                      controller: valueController,
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
                                          InkWell(
                                            onTap:(){ _selectProjectDate(context!); },
                                            child: Center(
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: MediaQuery.of(context).size.width * 0.75,
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
                                                    new Expanded(
                                                      child:
                                                      TextField(
                                                        controller: projectStartDateController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "",
                                                          hintStyle: TextStyle(color: Colors.grey),
                                                          label:
                                                          Row(
                                                            children: [
                                                              Text("Project start date",style: TextStyle(fontSize: 12),),
                                                              Padding(
                                                                padding: EdgeInsets.all(3.0),
                                                              ),
                                                              const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                            ],
                                                          ),
                                                          contentPadding:
                                                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                          isDense: true,
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(10.0),
                                                      child: Icon(
                                                        Icons.calendar_month,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          InkWell(
                                            onTap: (){_selectProjectDeliveryDate(context!);},
                                            child: Center(
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: MediaQuery.of(context).size.width * 0.75,
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
                                                    new Expanded(
                                                      child: TextField(
                                                        controller: projectDeliveryDateController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "",
                                                          label:
                                                          Row(
                                                            children: [
                                                              Text("Project delivery date ",style: TextStyle(fontSize: 12),),
                                                              Padding(
                                                                padding: EdgeInsets.all(3.0),
                                                              ),
                                                              const Text('*', style: TextStyle(color: Colors.red,fontSize: 12)),

                                                            ],
                                                          ),
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
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(10.0),
                                                      child: Icon(
                                                        Icons.calendar_month,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
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
                    ),
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
                    ),
                    SizedBox(height: 300,),

                  ],

                )
            )),
      );
  }


  statesApi() async{
    ApiHelper apiHelper = ApiHelper(context);
    String response = await apiHelper.callApiWithTokenNoBodyGET(states);
    print("Avalible Response : "+response);

    if(response == "Error")
    {
      setState(() {
        stateList = [];
      });
    }else {
      StateListRes res = StateListRes.fromJson(json.decode(response));
      setState(() {
        stateList = [];
        for(int i=0;i<res.result!.length;i++){
            stateList.add(res.result![i]);
        }

      });
    }
  }
  propertyIndApi() async{
    ApiHelper apiHelper = ApiHelper(context);
    var apiUrl = addProperty+"/15";
    String response = await apiHelper.callApiWithTokenNoBodyGET(apiUrl);
    print("Avalible Response : "+response);

    if(response == "Error")
    {
      setState(() {
        stateList = [];
      });
    }else {
      PropertyInRes res = PropertyInRes.fromJson(json.decode(response));
      setState(() {
       // stateList = [];
       /* for(int i=0;i<res.result!.length;i++){
            stateList.add(res.result![i]);
        }*/

        propertyNameController.text = res.result!.name!;
        propertyCodeController.text = res.result!.code!;
        propertyValueController.text = res.result!.value.toString();
        propertyOverviewController.text = res.result!.overview.toString();
        projectedgrossyieldController.text = res.result!.projectedGrossYield.toString();
        tenureController.text = res.result!.tenure.toString();
        valueController.text = res.result!.annualReturn.toString();
        projectStartDateController.text = res.result!.startDate.toString();
        projectDeliveryDateController.text = res.result!.deliveryDate.toString();
        addressController.text = res.result!.address.toString();
        stateController.text = res.result!.state.toString();
        zipcodeController.text = res.result!.zipcode.toString();
        latitudeController.text = res.result!.latitude.toString();
        longitudeController.text = res.result!.longitude.toString();
        cityController.text = res.result!.city.toString();

      });
    }
  }
  SaveApifun() async{
    ApiHelper apiHelper = ApiHelper(context);
    var apiUrl = addProperty+"/15";

   // DateTime temp = DateFormat('yyyy-MM-dd').parse(projectDeliveryDateController.text.toString());
   // DateTime temp2 = DateFormat('yyyy-MM-dd').parse(projectStartDateController.text.toString());
   // String start = DateFormat('dd/MM/yyyy').format(temp);
   // String delivery = DateFormat('dd/MM/yyyy').format(temp2);



    final queryParameters = {
      "name" : propertyNameController.text.toString(),
      "code" : propertyCodeController.text.toString(),
      "value" : propertyValueController.text.toString(),
      "overview" : propertyOverviewController.text.toString(),
      "projected_gross_yield" : projectedgrossyieldController.text.toString(),
      "tenure" : tenureController.text.toString(),
      "start_date" : projectStartDateController.text.toString(),
      "delivery_date" : projectDeliveryDateController.text.toString(),
      "annual_return" : valueController.text.toString(),
      "address" : addressController.text.toString(),
      "state" : stateController.text.toString(),
      "city" : cityController.text.toString(),
      "zipcode" : zipcodeController.text.toString(),
      "latitude" : latitudeController.text.toString(),
      "longitude" : longitudeController.text.toString(),
    };

    String response = await apiHelper.callApiWithTokenPut(apiUrl,queryParameters);
    print("Avalible Response : "+response);

    if(response.startsWith("Error"))
    {
     // print('Errorrr'+response);

      response = response.replaceAll("Error: ", "");

      ErrorRes res = ErrorRes.fromJson(json.decode(response));
      print(res.error);
      Fluttertoast.showToast(
        msg: res.error.toString(),
        toastLength: Toast.LENGTH_SHORT,
      );


    }else {
      EditPropertySavedRes res = EditPropertySavedRes.fromJson(json.decode(response));
      //PropertyInRes res = PropertyInRes.fromJson(json.decode(response));
      setState(() {
       // stateList = [];
       /* for(int i=0;i<res.result!.length;i++){
            stateList.add(res.result![i]);
        }*/

        Fluttertoast.showToast(
          msg: res.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );

        propertyNameController.text = res.result!.name!;
        propertyCodeController.text = res.result!.code!;
        propertyValueController.text = res.result!.value.toString();
        propertyOverviewController.text = res.result!.overview.toString();
        projectedgrossyieldController.text = res.result!.projectedGrossYield.toString();
        tenureController.text = res.result!.tenure.toString();
        valueController.text = res.result!.annualReturn.toString();
        projectStartDateController.text = res.result!.startDate.toString();
        projectDeliveryDateController.text = res.result!.deliveryDate.toString();
        addressController.text = res.result!.address.toString();
        stateController.text = res.result!.state.toString();
        zipcodeController.text = res.result!.zipcode.toString();
        latitudeController.text = res.result!.latitude.toString();
        longitudeController.text = res.result!.longitude.toString();
        cityController.text = res.result!.city.toString();

      });
    }
  }

}

