import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/AddInvestors.dart';
import 'package:quityown/pages/InvestorDetailsPage.dart';
import 'package:quityown/pojo/DeleteInvestorRes.dart';
import 'package:quityown/pojo/GetInvestorsRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class InvestorsListPage extends StatefulWidget{
  const InvestorsListPage({super.key});

  @override
  State<InvestorsListPage> createState() => _InvestorsListPage();
}

class _InvestorsListPage extends State<InvestorsListPage>{
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

    String response = await apiHelper.callApiWithTokenGet(getInvestorsListApi,queryParameters);

    if(response != "Error")
    {
      GetInvestorsRes res = GetInvestorsRes.fromJson(json.decode(response));
      setState(() {
        itemList.addAll(res.investors!.data!);
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0,top: 10.0,right: 10.0,bottom: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppLocalizations.of(context)!.investors,style: blackHeadStyle,),
                                    InkWell
                                      (
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddInvestors()));
                                        },
                                        child: Icon(Icons.add_circle_outline_rounded,color: Colors.black,))
                                  ],
                                ),
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
                                      Padding(
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(itemList[index].fullName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                                SizedBox(height: 3,),
                                                Text(itemList[index].email.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey),),
                                                SizedBox(height: 3,),
                                                Text(itemList[index].mobilenumber.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    /*Container(
                                                        width : 20,
                                                        height: 20,
                                                        child: Image.asset('assets/images/edit.png')
                                                    ),
                                                    SizedBox(width: 3,),*/
                                                    InkWell(
                                                      onTap : () {
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                                        (context)=>
                                                            InvestorDetailsPage([], animate: false,id: itemList[index].userId!)
                                                        ));
                                                      },
                                                      child: Container(
                                                          width : 20,
                                                          height: 20,
                                                          child: Image.asset('assets/images/profile.png')),
                                                    ),
                                                    SizedBox(width: 3,),
                                                    InkWell(
                                                      onTap: (){deleteInvestor(itemList[index].userId.toString());},
                                                      child: Container(
                                                          width : 20,
                                                          height: 20,
                                                          child: Image.asset('assets/images/delete.png')),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
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