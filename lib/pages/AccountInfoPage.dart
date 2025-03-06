import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pojo/GetMyProfileRes.dart';
import 'package:quityown/widgets/constants.dart';

class AccountInfoPage extends StatefulWidget{
  const AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPage();
}

class _AccountInfoPage extends State<AccountInfoPage>{
  static const backgroundcolor= const Color(0xfff1f5f9);
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
          title:
          Text("Account info",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child:
            Padding(padding: EdgeInsets.only(left: 20,top: 15,right: 10,bottom: 15),
              child:
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Personal information',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            ),
                            SizedBox(height: 30,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.25,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  color: backgroundcolor
                              ),
                              child:
                              Column(
                                   children: [
                                  Padding(padding: EdgeInsets.only(left: 10.0,bottom: 10.0,top: 10.0,right: 10.0),
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Name ',style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Email ',style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Phone number ',style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Invest type',style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(fullname,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(email,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(mobilenumber,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(email_verified_status,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                  ),

                                ],
                              ),
                            ),
                            /*SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Need help upload information ?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            SizedBox(height: 20,),
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
                                        width: MediaQuery.of(context).size.width * 0.10,
                                        alignment: Alignment.topLeft,
                                        child: Image.asset('assets/images/chat_icon.png'),
                                      ),
                                      SizedBox(width: 20,),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.50,
                                        alignment: Alignment.topLeft,
                                        child: Text("Send us message",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Fluttertoast.showToast(
                            msg: "Please contact app admin",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.15,
                          alignment: Alignment.bottomCenter,
                          child: Text('Delete my account ',style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                      )
                    ],
                  )
              ,),
          ),
        ),
      ),
    );
  }
}