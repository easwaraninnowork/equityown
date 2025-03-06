import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/AddInvestors.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/InvestorDetailsPage.dart';
import 'package:quityown/pojo/ApprovedApiRes.dart';
import 'package:quityown/pojo/DeleteInvestorRes.dart';
import 'package:quityown/pojo/PropertiesInvestedRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:quityown/widgets/my_text_button.dart';


class DashboardPage extends StatefulWidget{
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage>{
  static const textfieldColor = const Color(0xffD6F5E7);
  static const backgroundcolor = const Color(0xfff1f5f9);
  final investor_search_controller = TextEditingController();


  List<Data> itemList = <Data>[];






  void initState(){
    getInvestorList();
    super.initState();
  }

  void searchootion(){
    itemList.clear();
    getInvestorList();
  }

  getInvestorList() async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "search" : investor_search_controller.text,
      "limit": "10",
      "page": "1"
    };
    print(queryParameters);

    String response = await apiHelper.callApiWithTokenGet(getPropertiesInvestedListApi,queryParameters);

    if(response != "Error")
    {
      PropertiesInvestedRes res = PropertiesInvestedRes.fromJson(json.decode(response));
      setState(() {
        itemList.addAll(res!.result!.data!);
      });
    }
  }
  deleteInvestor(id) async{
    ApiHelper apiHelper = ApiHelper(context);

    String response = await apiHelper.callApiWithTokenDelete(deleteInvestorApi+"/"+id);
    print(response);


    if(response != "Error")
    {
      DeleteInvestorRes res = DeleteInvestorRes.fromJson(json.decode(response));
      setState(() {
        print(res.message);
        Fluttertoast.showToast(
            msg: res.message!,
            toastLength: Toast.LENGTH_SHORT
        );
        itemList.clear();
        getInvestorList();

      });
    }
  }
  void dialog(BuildContext context, String projectname, String amount, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Investment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Reduce the gap between content and actions
              children: [
                Text("Are you sure want to confirm :" + amount.toString() + " USD investment for project " + projectname.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                callYEs(id);
              },
            )
          ],
        );
      },
    );
  }

  callYEs(id) async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "type": "approved",
    };
    print(queryParameters);

    var url = approvedApi+id.toString();

    String response = await apiHelper.callApiWithToken(url,queryParameters);

    if(response != "Error")
    {
      ApprovedApiRes res = ApprovedApiRes.fromJson(json.decode(response));
      setState(() {
        Fluttertoast.showToast(
            msg: res.message!,
            toastLength: Toast.LENGTH_SHORT
        );
        Navigator.pop(context);
        initState();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: backgroundcolor,
      body:
      SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child:
                Container(
                  color: Colors.white,
                  child: Column(
                      children:
                      <Widget>
                      [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0,top: 10.0,right: 10.0,bottom: 10.0),
                                child:Text(AppLocalizations.of(context)!.payment_dashboard,style: blackHeadStyle,),

                                /*Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppLocalizations.of(context)!.payment_dashboard,style: blackHeadStyle,),
                                    InkWell
                                      (
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddInvestors()));
                                        },
                                        child: Icon(Icons.add_circle_outline_rounded,color: Colors.black,))
                                  ],
                                ),*/
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      height: 50,
                                      margin: EdgeInsets.only(top: 15),
                                      child:
                                      TextField(
                                        controller: investor_search_controller,
                                      ),
                                    ),
                                    InkWell
                                      (
                                        onTap: (){
                                          searchootion();
                                        },
                                        child: Icon(Icons.search,color: Colors.black,))
                                  ],
                                ),
                              ),
                              SizedBox(height: 30,)
                            ],
                          ),
                        )
                      ]
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white
                  ),
                  child: Column(
                      children:
                      <Widget>
                      [
                        Container(
                          child:
                          Column(
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: itemList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return
                                    GestureDetector(
                                      onTap: () => {
                                        /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PropertiesDetailsPage(propertyid : similarPopertiesList[index].id.toString()),
                                            ))*/
                                      },
                                      child:
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 18.0,top: 10.0,right: 10.0,bottom: 10.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Column(
                                                      children: [
                                                        // Image.network(itemList[index].profilePicPath.toString())
                                                        Image.asset('assets/images/admin.png')
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 15,),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Name",style: TextStyle(fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.center,
                                                              child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(itemList[index].fullName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Project ",style: TextStyle(fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.center,
                                                              child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(itemList[index].projectName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Code ",style: TextStyle(fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.center,
                                                              child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(itemList[index].propertyCode.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Invest date ",style: TextStyle(fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.center,
                                                              child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(itemList[index].investedDate.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Amount ",style: TextStyle(fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.center,
                                                              child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(itemList[index].investedAmount.toString()+" AED",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Payment status",style: TextStyle(fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.center,
                                                              child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child:
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  if(itemList[index].paymentStatus == "approved")
                                                                  Text("Approved",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                                  if(itemList[index].paymentStatus == "pending")
                                                                    Text("Pending",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          if(itemList[index].paymentStatus == "approved")
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.25,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: MyTextButton(buttonName: "Success", onTap: (){}, bgColor: Colors.green, textColor: Colors.white)),
                                                          SizedBox(width: 10,),
                                                          if(itemList[index].paymentStatus != "approved")
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.25,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: MyTextButton(buttonName: "Confirm", onTap: (){dialog(context,itemList[index].projectName!,itemList[index].investedAmount!,itemList[index].id.toString());}, bgColor: Colors.grey, textColor: Colors.white)),
                                                          if(itemList[index].paymentStatus != "approved")
                                                          SizedBox(width: 10,),
                                                          if(itemList[index].paymentStatus != "approved")
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.25,
                                                              height: MediaQuery.of(context).size.height*0.05,
                                                              alignment: Alignment.centerLeft,
                                                              child: MyTextButton(buttonName: "Cancel", onTap: (){}, bgColor: Colors.red, textColor: Colors.white)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    );
                                },
                              ),

                            ],
                          ),
                        )
                      ]
                  ),
                ),
              )
            ],
          )
      ),
    ));
  }
}