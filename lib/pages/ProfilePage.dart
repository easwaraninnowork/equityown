import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/AccountInfoPage.dart';
import 'package:quityown/pages/LearnwithequityPage.dart';
import 'package:quityown/pages/LoginPage.dart';
import 'package:quityown/pages/PreferencesPage.dart';
import 'package:quityown/pojo/GetMyProfileRes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>{
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
  
  String uservalue = "";


  @override
  void initState() {
    getMyprofile();
    gettoken();
    Timer(Duration(seconds: 2), () {
      print("user 1 --->"+uservalue);
      // if(userValue != "") {
    });
    super.initState();
  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uservalue = (prefs.getString('user') ?? '');
      print("uservalu_gettoken "+uservalue);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          /*leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: ()=> Navigator.of(context).pop(),
          ),*/
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                alignment: Alignment.topLeft,
                child: Text(AppLocalizations.of(context)!.profile,style: TextStyle(color: Colors.black),),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.10,
                alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  _showAlertDialog(context);
                },
                child: Icon(Icons.power_settings_new,color: Colors.black,),
              )
                ,)
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
              Align(
              alignment: Alignment.topLeft,
              child: Text(AppLocalizations.of(context)!.hello+" "+ fullname,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            ),
            SizedBox(height: 15,),
            if(uservalue != "Admin")
            Align(
              alignment: Alignment.topLeft,
              child: Text(AppLocalizations.of(context)!.total_invested,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            ),
            if(uservalue != "Admin")
            SizedBox(height: 5,),
            if(uservalue != "Admin")
            Align(
              alignment: Alignment.topLeft,
              child: Text("AED 900,000",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.greenAccent),textAlign: TextAlign.center,),
            ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AccountInfoPage()));
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
                            width:
                            MediaQuery.of(context).size.width * 0.10,
                            alignment: Alignment.topLeft,
                            child: Image.asset('assets/images/account_info_icon.png'),
                          ),

                          SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            alignment: Alignment.topLeft,
                            child: Text(AppLocalizations.of(context)!.account_info,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PreferencesPage()));
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
                            width: MediaQuery.of(context).size.width * 0.10,
                            alignment: Alignment.topLeft,
                            child: Image.asset('assets/images/filter_icon.png'),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            alignment: Alignment.topLeft,
                            child: Text(AppLocalizations.of(context)!.preferences,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
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
                /*InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LearnwithequityPage()));
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
                            width: MediaQuery.of(context).size.width * 0.10,
                            alignment: Alignment.topLeft,
                            child: Image.asset('assets/images/learn_icon.png'),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            alignment: Alignment.topLeft,
                            child: Text(AppLocalizations.of(context)!.learn_with_equityown,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
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
                ),*/
                SizedBox(height: 10,),
                /*InkWell(
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
                            width: MediaQuery.of(context).size.width * 0.10,
                            alignment: Alignment.topLeft,
                            child: Image.asset('assets/images/question_mark_icon.png'),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            alignment: Alignment.topLeft,
                            child: Text(AppLocalizations.of(context)!.help_support,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
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
                ),*/
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