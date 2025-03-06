import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/AddInvestors.dart';
import 'package:quityown/pages/AddPropertiesPage.dart';
import 'package:quityown/pages/ExitedPage.dart';
import 'package:quityown/pages/FundedPage.dart';
import 'package:quityown/pages/NewListingPage.dart';
import 'package:quityown/pages/PropertiesDetailsPage.dart';
import 'package:quityown/pages/UploadPassportPage.dart';
import 'package:quityown/pojo/UserPropertiesRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'CurrencyPage.dart';

class PropertiesScreen extends StatefulWidget{

  const PropertiesScreen({super.key});


  @override
  State<PropertiesScreen> createState() => _PropertiesScreen();
}

class _PropertiesScreen extends State<PropertiesScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  List<Data> newListingList = <Data>[];
  List<Data> fundedListingList = <Data>[];
  List<Data> exitedListingList = <Data>[];
  String userValue = "";



  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
    gettoken();
    propertiesApi();
    super.initState();
  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userValue = (prefs.getString('user') ?? '');
      print("uservalu "+userValue);
    });
  }


  propertiesApi() async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "per_page": "100"
    };
    print(queryParameters);
    String response = await apiHelper.callApiWithTokenGet(userPropertiesApi,queryParameters);
  //  print(response);

    if(response != "Error")
    {
      UserPropertiesRes res = UserPropertiesRes.fromJson(json.decode(response));
      setState(() {
        //cartQty = totalQty.toString();
        newListingList.clear();
        fundedListingList.clear();
        exitedListingList.clear();
        for(int i=0;i<res.result!.data!.length;i++){
          if(res.result!.data![i].status == "available"){
            newListingList.add(res.result!.data![i]);
          }else if(res.result!.data![i].status == "exited"){
            exitedListingList.add(res.result!.data![i]);
          }else if(res.result!.data![i].status == "funded"){
            fundedListingList.add(res.result!.data![i]);
          }
        }
        print(newListingList.length);
        print(fundedListingList.length);
        print(exitedListingList.length);

        //  newListingList.addAll(res.result!.data!);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset : false,
        body:
        Container(
          width : MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                children:
                <Widget>
                [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.properties,style: blackHeadStyle,),
                          Row(
                            children: [
                             /* InkWell(
                                  onTap: (){
                                    *//*Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => AddInvestors()));*//*
                                  },
                                  child: Icon(Icons.bookmark,color: Colors.black,)),*/
                              SizedBox(width: 2,),
                                if(userValue == "Admin")
                                InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => AddPropertiesPage(pageIndex:0)));
                                },
                                child: Icon(Icons.add_circle_outline_rounded,color: Colors.black,),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  /*Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Padding(padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),topLeft: Radius.circular(10.0)),
                                color: Colors.amberAccent
                            ),
                            child: Text(AppLocalizations.of(context)!.passport_address_proof_req,style: TextStyle(fontSize: 9.0)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: 30,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                                color: Colors.amber
                            ),
                            child:
                            GestureDetector(
                              onTap: (){
                                */
                  /*Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => UploadPassportPage()));*/
                  /*
                                Fluttertoast.showToast(
                                    msg: "There no function for this button. Its just a ui function",
                                    toastLength: Toast.LENGTH_SHORT
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.upload_file_rounded),
                                  Text(AppLocalizations.of(context)!.upload_passport,style: TextStyle(fontSize: 9.0))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),),
                  ),*/
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: TabBar(
                            tabs: [
                              Container(
                                width: 70.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  AppLocalizations.of(context)!.available,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Container(
                                width: 75.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  AppLocalizations.of(context)!.funded,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Container(
                                width: 75.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  AppLocalizations.of(context)!.exited,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                            unselectedLabelColor: const Color(0xffacb3bf),
                            indicatorColor: Color(0xFFffac81),
                            labelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 3.0,
                            indicatorPadding: EdgeInsets.all(10),
                            isScrollable: false,
                            controller: _tabController,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                Container(
                                  child: NewListingPage(newListingList :newListingList,type : "available"),
                                ),
                                Container(
                                  child: FundedPage(newListingList : fundedListingList,type: "funded",),
                                ),
                                Container(
                                  child: ExitedPage(newListingList : exitedListingList,type: "exited",),
                                )
                              ]
                          ),
                        ),
                      ],
            
                    ),
                  )
                ]
            ),
          ),
        )),
    );
  }


}