import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quityown/pages/AddPropertiesPage.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddpropertyDetailsPage extends StatefulWidget{

  const AddpropertyDetailsPage({super.key});

  @override
  State<AddpropertyDetailsPage> createState() => _AddpropertyDetailsPage();
}

class _AddpropertyDetailsPage extends State<AddpropertyDetailsPage> with SingleTickerProviderStateMixin{
  static const textfieldColor= const Color(0xffD6F5E7);
  static const backgroundcolor= const Color(0xfff1f5f9);
  late TabController _tabController;
  final startdate_controller = TextEditingController();
  final projectStartDateController = TextEditingController();
  final projectedgrossyieldController = TextEditingController();
  final projectDeliveryDateController = TextEditingController();
  final tenureController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? _selectedDate;

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


  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    getSharedpref();
  }
  Future<void> Savefunction() async {
    if(projectedgrossyieldController.text.toString() != "") {
      if (tenureController.text.toString() != "") {
        if (valueController.text.toString() != "") {
          if (projectStartDateController.text.toString() != "") {
            if (projectDeliveryDateController.text.toString() != "") {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString("projected_gross_yield", projectedgrossyieldController.text);
              prefs.setString("tenure", tenureController.text);
              prefs.setString("value", valueController.text);
              prefs.setString("project_start_date", projectStartDateController.text);
              prefs.setString("project_delivery_date", projectDeliveryDateController.text);

              Fluttertoast.showToast(
                msg: "Propery details saved successfully ",
                toastLength: Toast.LENGTH_SHORT,
              );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPropertiesPage(pageIndex: 2),
                  ));

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
            msg: "Please enter property value",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      else {
        Fluttertoast.showToast(
          msg: "Please enter tenure",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else{
      Fluttertoast.showToast(
        msg: "Please enter projected gross yield",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }


  getSharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("propertyname") != ""){
      projectedgrossyieldController.text = prefs.getString("projected_gross_yield")!;
      tenureController.text = prefs.getString("tenure")!;
      valueController.text = prefs.getString("value")!;
      projectStartDateController.text = prefs.getString("project_start_date")!;
      projectDeliveryDateController.text = prefs.getString("project_delivery_date")!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset : false,
            backgroundColor: backgroundcolor,
            body:
            SingleChildScrollView(
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
                                            onPressed: (){Savefunction();},
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
            )
        ),
      );
  }



}

