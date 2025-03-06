import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/AccountInfoPage.dart';
import 'package:quityown/pages/LoginPage.dart';
import 'package:quityown/pages/PreferencesPage.dart';
import 'package:quityown/pojo/GetMyProfileRes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:quityown/widgets/constants.dart';


class LearnwithequityPage extends StatefulWidget{
  const LearnwithequityPage({super.key});

  @override
  State<LearnwithequityPage> createState() => _LearnwithequityPage();
}

class _LearnwithequityPage extends State<LearnwithequityPage>{
  static const containerbackgrounColor = const Color(0xfff4f4f4);
  String fullname = "",userid = "",email = "",mobilenumber = "",mobile_verified = "",email_verified = "",profile_pic_path = "",mobile_verified_status = "",email_verified_status ="";

  getMyprofile() async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "per_page": "100"
    };
    print(queryParameters);
    String response = await apiHelper.callApiWithTokenGet(getMyProfile,queryParameters);
    print(response);

    if(response != "Error")
    {
      GetMyprofileRes res = GetMyprofileRes.fromJson(json.decode(response));
      setState(() {
        fullname = res.result!.fullName.toString();
        userid = res.result!.userId.toString();
        email = res.result!.email.toString();
        mobilenumber = res.result!.mobilenumber.toString();
        mobile_verified = res.result!.mobileVerified.toString();
        mobile_verified_status = res.result!.mobileVerifiedStatus.toString();
        email_verified = res.result!.emailVerified.toString();
        email_verified_status = res.result!.emailVerifiedStatus.toString();
        profile_pic_path = res.result!.profilePicPath.toString();
      });
    }
  }

  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/slider1.jpeg',
      'description' : 'How will you make money'
    },
    {
      'image': 'assets/images/slider1.png',
      'description' : 'How will you make money'
    },
    {
      'image': 'assets/images/slider2.png',
      'description' : 'How will you make money'
    },
    {
      'image': 'assets/images/slider6.jpg',
      'description' : 'How will you make money'
    }
  ];


  @override
  void initState() {
    getMyprofile();
    super.initState();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: ()=> Navigator.of(context).pop(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                alignment: Alignment.topLeft,
                child: Text(AppLocalizations.of(context)!.learn_with_equityown,style: TextStyle(color: Colors.black),),
              ),
              /*Container(
                width: MediaQuery.of(context).size.width * 0.10,
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    _showAlertDialog(context);
                  },
                  child: Icon(Icons.power_settings_new,color: Colors.black,),
                )
                ,)*/
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child:
            Padding(padding: EdgeInsets.only(left: 20,top: 15,right: 10,bottom: 15),
              child: Column(

                children: [
                  SizedBox(height: 20,),

                  InkWell(
                    onTap: (){
                      /*Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PreferencesPage()));*/
                      Fluttertoast.showToast(
                        msg: "There is no function for this section now.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                    },
                    child:               Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                      ),
                      child:
                      Row(
                        children: [

                          Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            alignment: Alignment.topLeft,
                            child: Text(AppLocalizations.of(context)!.why_equityown,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            alignment: Alignment.topRight,
                            child: Text("View all",style: blackChildStyle,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  InkWell(
                    onTap: (){
                      Fluttertoast.showToast(
                        msg: "There is no function for this section now.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                    },
                    child: Container(
                      height: 150.0, // Set height for the list
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  items[index]['image']!,
                                  height: 100.0,
                                  width: 170.0,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(items[index]['description']!,style: blackChildStyle,),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),

                  InkWell(
                    onTap: (){
                      /*Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PreferencesPage()));*/
                      Fluttertoast.showToast(
                        msg: "There is no function for this section now.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                    },
                    child:               Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                          color: containerbackgrounColor
                      ),
                      child:
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child:
                        Row(
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context)!.why_equityown,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              alignment: Alignment.topRight,
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      /*Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PreferencesPage()));*/
                      Fluttertoast.showToast(
                        msg: "There is no function for this section now.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                    },
                    child:               Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                          color: containerbackgrounColor
                      ),
                      child:
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child:
                        Row(
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context)!.faqs,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              alignment: Alignment.topRight,
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Fluttertoast.showToast(
                        msg: "There is no function for this section now.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                          color: containerbackgrounColor
                      ),
                      child:
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child:
                        Row(
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context)!.how_it_works,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              alignment: Alignment.topRight,
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
/*
                Image.asset('assets/images/slider2.png')
*/

                ],
              ),),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure to logout this application'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                settokenempty();

                SaveData saveData = SaveData();
                saveData.storeString("token","");
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                );



                //Navigator.of(context).pop(); // Dismiss the dialog



                // Do something when OK is pressed
              },
            ),
          ],
        );
      },
    );
  }
}

void settokenempty() {


}
