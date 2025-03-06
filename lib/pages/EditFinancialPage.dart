import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pojo/BookmarkRes.dart';
import 'package:quityown/pojo/EditFinancialRes.dart';
import 'package:quityown/pojo/PropertyDetailsRes.dart';
import 'package:quityown/pojo/PublishNowRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pojo/InvestNowRes.dart';


class EditFinancialPage extends StatefulWidget{
  String propertyid;
  EditFinancialPage({super.key,required this.propertyid});


  @override
  State<EditFinancialPage> createState() => _EditFinancialPage(propertyid);
}

class _EditFinancialPage extends State<EditFinancialPage> with SingleTickerProviderStateMixin{

  String propertyid;
  _EditFinancialPage(this.propertyid);


  static const textfieldColor= const Color(0xfff1f5f9);
  static const backgroundColor= const Color(0xfffffdfd);
  final projectCostController = TextEditingController();
  final expectedTotalfundReturnController = TextEditingController();
  final expectedGainController = TextEditingController();
  final rateofreturnController = TextEditingController();
  final projectDeliveryDateController = TextEditingController();
  final projectFundreturnDateController = TextEditingController();
  int currentRange = 10;
  String sliderchangedString = "10";


  final items = [
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider3.jpeg',fit: BoxFit.fill,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider2.png',fit: BoxFit.fill,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider4.jpeg',fit: BoxFit.fill,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider5.jpg',fit: BoxFit.fill,)),
  ];

   int index = 0;

  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 0,
      "value": true,
      "title": "Below 500,000 AED",
      "color": Colors.black,
      "txt_color": Colors.white,
    },
    {
      "id": 1,
      "value": false,
      "title": "Above 500,000  ",
      "color": textfieldColor,
      "txt_color": Colors.black,

    }
  ];

  int currentIndex = 0;

  String navigate_id="";

  late PropertyDetailsRes itemList = PropertyDetailsRes();
  String address="";
  String fund_return_date="";
  String tenure="";
  int projected_gross_yield=0;
  String userValue = "";
  int show_in_website = 0;
  DateTime? _selectedDate;
  var financialList = [];



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
        projectFundreturnDateController.text = formattedDateString;
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

    super.initState();
    gettoken();
    financialListApi("15");

    rateofreturnController.text = sliderchangedString;

  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userValue = (prefs.getString('user') ?? '');
      print("uservalu "+userValue);
    });
  }



  SaveData() async{
    ApiHelper apiHelper = ApiHelper(context);


    final queryParameters = {
      "delivery_date" : projectDeliveryDateController.text.toString(),
      "expected_gain" : expectedGainController.text.toString(),
      "expected_total_fund_return" : expectedTotalfundReturnController.text.toString(),
      "fund_return_date" : projectFundreturnDateController.text.toString(),
      "rate_of_return" : rateofreturnController.text.toString(),
      "value" : projectCostController.text.toString(),
    };
    print(queryParameters);
    String apiUrl = financialApi+"/"+propertyid;
    String response = await apiHelper.callApiWithTokenPut(apiUrl,queryParameters);
    print("response "+response);
    String address="";

    //if(response != "Error")
    //  {
    EditFinancialRes res = EditFinancialRes.fromJson(json.decode(response));
    setState(() {
      //cartQty = totalQty.toString();
      //  investItemList = res.result! as InvestNowRes;

      print(res.message);
      Fluttertoast.showToast(
        msg: res.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context)=>
          HomeScreen(pageIndex :0)
      )
      );

      /* fundinglogList = res.result!.fundingLog!;
      amenitiesList = res.result!.amenities!;
      amenities_near_byList = res.result!.amenitiesNearBy!;
      documentsList = res.result!.documents!;
      similarPopertiesList = res.result!.similarProperties!;*/

    });
    // }


  }

  void _handleSubmitted(String value) {
    sliderchangedString = value;
    currentRange = int.parse(value);
  }






  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: backgroundColor,
          body:SafeArea(
            child:
            SingleChildScrollView(
                child:
                /*Container(child: () {
                  if (itemList.result == null) {
                    return Center(child: Text("Loading please wait",textAlign: TextAlign.center,),);
                  }else
                  {
                    return */
                      Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: backgroundColor
                      ),
                      child:
                      Column(
                          children:
                          <Widget>
                          [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Padding(padding: EdgeInsets.all(10.0),
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Image.asset("assets/images/project_overview.png"),
                                                  SizedBox(width: 10,),
                                                  Text('Financials',style: blackHeadStyle,)
                                                ],
                                              )),

                                          Container(
                                            decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                                                color: backgroundColor,
                                                border: Border.all(color: Colors.grey,width: 1.0)
                                            ),
                                            child:
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
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
                                                                controller: projectCostController,
                                                                decoration: InputDecoration(
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                                  ),
                                                                  label:
                                                                  Row(
                                                                    children: [
                                                                      Text("Project cost",style: TextStyle(fontSize: 12),),
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
                                                                controller: expectedTotalfundReturnController,
                                                                decoration: InputDecoration(
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                                  ),
                                                                  label:
                                                                  Row(
                                                                    children: [
                                                                      Text("Expected total fund return %",style: TextStyle(fontSize: 12),),
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
                                                                controller: expectedGainController,
                                                                decoration: InputDecoration(
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                                  ),
                                                                  label:
                                                                  Row(
                                                                    children: [
                                                                      Text("Expected gain %",style: TextStyle(fontSize: 12),),
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
                                                  SizedBox(height: 20,),
                                                  SizedBox(height: 20,),
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
                                                  InkWell(
                                                    onTap: (){_selectProjectDate(context!);},
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
                                                                controller: projectFundreturnDateController,
                                                                keyboardType: TextInputType.text,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "",
                                                                  label:
                                                                  Row(
                                                                    children: [
                                                                      Text("Fund return date (Exp)",style: TextStyle(fontSize: 12),),
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
                                                  Slider(
                                                    value: currentRange.toDouble(),
                                                    min : 0,
                                                    max : 100,
                                                    activeColor: Colors.black,
                                                    onChanged:   (double value) {
                                                      setState(() {
                                                        currentRange = value.toInt();
                                                        sliderchangedString = currentRange.toString() + " AED";
                                                        rateofreturnController.text = currentRange.toString();

                                                      });
                                                    },
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    height: 30,
                                                    margin: EdgeInsets.only(left: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('Rate of  return',style: blackChildStyle,),
/*
                                                        Text(sliderchangedString,style: greenHeadStyle,),
*/
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:
                                                          TextField(
                                                            controller: rateofreturnController,
                                                            onSubmitted: (String value){
                                                              _handleSubmitted(value);
                                                            },
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey, width: .0),
                                                                ),
                                                                hintText: sliderchangedString,
                                                                hintStyle: TextStyle(fontSize: 12)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),


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
                                                        onPressed: (){ SaveData(); },
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
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),




                          ]
                      ),
                    )
                  /*}
                }())*/

            ),
          ));
  }

  checknull(string){
    if(string != null){
      return string;
    }else{
      return "";
    }
  }
  checknullzero(value){
    if(value != null){
      return value;
    }else{
      return 0;
    }
  }



  financialListApi(propertyid) async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "per_page": "100"
    };
    // print(queryParameters);
    String apiUrl = userPropertiesApi+"/"+propertyid;
    String response = await apiHelper.callApiWithTokenGet(apiUrl,queryParameters);
    //print("response "+response);


    //if(response != "Error")
    //  {
    PropertyDetailsRes res = PropertyDetailsRes.fromJson(json.decode(response));
    setState(() {
      //cartQty = totalQty.toString();
      itemList = res;
      address = res.result!.address!;
      fund_return_date = res.result!.fundReturnDate!;
      tenure = res.result!.tenure!.toString();
      projected_gross_yield = res.result!.projectedGrossYield!;
      show_in_website = res.result!.showInWebsite!;

      projectCostController.text = res.result!.value!.toString();
      expectedTotalfundReturnController.text = res.result!.expectedTotalFundReturn!.toString();
      expectedGainController.text = res.result!.expectedGain!.toString();
      projectDeliveryDateController.text = res.result!.deliveryDate!.toString();
      projectFundreturnDateController.text = res.result!.fundReturnDate!.toString();
      rateofreturnController.text = res.result!.rateOfReturn!.toString();

    });
    // }
  }


}
