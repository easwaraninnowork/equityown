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
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pojo/AddpropertiesRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddfinancialDetailsPage extends StatefulWidget{

  const AddfinancialDetailsPage({super.key});

  @override
  State<AddfinancialDetailsPage> createState() => _AddfinancialDetailsPage();
}

class _AddfinancialDetailsPage extends State<AddfinancialDetailsPage> with SingleTickerProviderStateMixin{
  static const textfieldColor= const Color(0xffD6F5E7);
  static const backgroundcolor= const Color(0xfff1f5f9);
  late TabController _tabController;
  final propertyCostController = TextEditingController();
  final projectDeliveryController = TextEditingController();
  final fundReturndateController = TextEditingController();
  final expectedGainController = TextEditingController();
  final rateofreturnController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _selectedfundDate;



  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();


    getSharedpref();
  }

  getSharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("property_cost") != ""){
      propertyCostController.text = prefs.getString("property_cost")!;
      projectDeliveryController.text = prefs.getString("project_delivery_date")!;
      fundReturndateController.text = prefs.getString("fund_return_date")!;
      rateofreturnController.text = prefs.getString("rate_of_return")!;
      expectedGainController.text = prefs.getString("expected_gain")!;
    }
  }
  Future<void> Savefunction(context) async {
    ApiHelper apiHelper = ApiHelper(context);

    if(propertyCostController.text.toString() != "") {
      if (projectDeliveryController.text.toString() != "") {
        if (fundReturndateController.text.toString() != "") {
          if (rateofreturnController.text.toString() != "") {
            if (expectedGainController.text.toString() != "") {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("propertycost", propertyCostController.text);
                prefs.setString("project_delivery_date", projectDeliveryController.text);
                prefs.setString("fund_return_date", fundReturndateController.text);
                prefs.setString("rate_of_return", rateofreturnController.text);
                prefs.setString("expected_gain", expectedGainController.text);

                Fluttertoast.showToast(
                  msg: "Financial detail saved successfully",
                  toastLength: Toast.LENGTH_SHORT,
                );

                addPropertyApi();

              }
            else {
              Fluttertoast.showToast(
                msg: "Please enter expected gain",
                toastLength: Toast.LENGTH_SHORT,
              );
            }

          }
          else {
            Fluttertoast.showToast(
              msg: "Please enter rate of return",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
        else {
          Fluttertoast.showToast(
            msg: "Please enter project delivery",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      else {
        Fluttertoast.showToast(
          msg: "Please enter property cost",
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

  Future<void> addPropertyApi() async {
    ApiHelper apiHelper = ApiHelper(context);

    final prefs = await SharedPreferences.getInstance();
     /* propertyCostController.text = prefs.getString("property_cost")!;
      projectDeliveryController.text = prefs.getString("project_delivery_date")!;
      fundReturndateController.text = prefs.getString("fund_return_date")!;
      rateofreturnController.text = prefs.getString("rate_of_return")!;
      expectedGainController.text = prefs.getString("expected_gain")!;*/
    var address = prefs.getString("address")!;
    var state = prefs.getString("state")!;
    var city = prefs.getString("city")!;
    var zipcode = prefs.getString("zipcode")!;
    var latitude = prefs.getString("latitude")!;
    var longitude = prefs.getString("longitude")!;
    var propertyname = prefs.getString("propertyname")!;
    var propertycode = prefs.getString("propertycode")!;
    var propertyvalue = prefs.getString("propertyvalue")!;
    var propertyoverview = prefs.getString("propertyoverview")!;
    var projected_gross_yield = prefs.getString("projected_gross_yield")!;
    var tenure = prefs.getString("tenure")!;
    var value = prefs.getString("value")!;
    var project_start_date = prefs.getString("project_start_date")!;
    var project_delivery_date = prefs.getString("project_delivery_date")!;

    Map<String,dynamic> bodyAPI = <String, dynamic>{
      "address": address,
      "annual_return" : rateofreturnController.text,
      "city" : city,
      "code" : propertycode,
      "delivery_date" : project_delivery_date,
      "latitude" : latitude,
      "longitude" : longitude,
      "name" : propertyname,
      "overview" : propertyoverview,
      "projected_gross_yield" : projected_gross_yield,
      "start_date" : project_start_date,
      "state" : state,
      "tenure" : tenure,
      "value" : propertyvalue,
      "zipcode" : zipcode
    };

    String apiUrl = addProperty;
    print(addProperty);
    print(bodyAPI);
    String response = await apiHelper.callApiWithToken(apiUrl,bodyAPI);
    print("response "+response);

    if(response == "Error")
    {
      print("Error");
      Fluttertoast.showToast(
        msg: "Please check email and other details",
        toastLength: Toast.LENGTH_SHORT,
      );

      // Navigator.of(context).pop();
    }else {
      AddpropertiesRes res = AddpropertiesRes.fromJson(json.decode(response));
      Fluttertoast.showToast(
          msg: res.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :0)),
            (Route<dynamic> route) => false,
      );




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
        projectDeliveryController.text = formattedDateString;
      });
    }
  }
  Future<void> _selectFundReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedfundDate ?? DateTime.now(), // Default to today's date if no date is selected
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedfundDate) {
      setState(() {

        _selectedfundDate = picked;
        DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(_selectedfundDate.toString());
        String formattedDateString = DateFormat('dd/MM/yyyy').format(formattedDate);

        print(formattedDateString);
        fundReturndateController.text = formattedDateString;
      });
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
                                                height: 40,
                                                child:
                                                TextField(
                                                  controller: propertyCostController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      hintText: 'Property cost',
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
                                        onTap: (){
                                          _selectProjectDeliveryDate(context);
                                        },
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
                                                    controller: projectDeliveryController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Project delivery date (Exp) ",
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
                                      InkWell(
                                        onTap: (){
                                          _selectFundReturnDate(context);
                                        },
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
                                                    controller: fundReturndateController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Fund return date",
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
                                                  controller: rateofreturnController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      hintText: 'Rate of return',
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
                                                  controller: expectedGainController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                      )
                                                      ,
                                                      hintText: 'Expected gain',
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
                                            onPressed: (){ Savefunction(context);},
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

