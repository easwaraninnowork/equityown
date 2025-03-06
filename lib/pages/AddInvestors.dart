import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/InvestorsListPage.dart';
import 'package:quityown/pojo/AddIvestorRes.dart';
import 'package:quityown/widgets/CountrySelectionWidget.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_button.dart';

class AddInvestors extends StatefulWidget{

  const AddInvestors({super.key});

  @override
  State<AddInvestors> createState() => _AddInvestors();
}

class _AddInvestors extends State<AddInvestors> with SingleTickerProviderStateMixin{
  static const textfieldColor= const Color(0xffD6F5E7);
  static const backgroundcolor= const Color(0xfff1f5f9);
  late TabController _tabController;
  final firstnameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberConroller = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final zipCodeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  var _selectedCountryCode ;
  var base64Image;


  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });

          // Convert image to base64
          base64Image = base64Encode(_image!.readAsBytesSync());

          // Send the base64 image to the server
        }
      } else {
        print('No image selected.');
      }
    });
  }


  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  Future<void> saveAddInvestor(context) async {
    ApiHelper apiHelper = ApiHelper(context);
    Map<String,String> userContacts = new Map();

    userContacts = <String, String>{
      "address" : address1Controller.text,
      "address2" : address2Controller.text,
      "country" : _selectedCountryCode.toString(),
      "created_by" : "1",
      "mobile" : mobileNumberConroller.text,
      "pincode" : zipCodeController.text
    };
    if(firstnameController.text.toString() != ""){
      if(lastNameController.text.toString() != ""){
        if(emailController.text.toString() != ""){
          if(mobileNumberConroller.text.toString() != ""){
            if(address1Controller.text.toString() != ""){
              if(address2Controller.text.toString() != ""){
                if(newPasswordController.text.toString() != ""){
                  if(retypePasswordController.text.toString() != ""){
                    if(newPasswordController.text.toString() == retypePasswordController?.text.toString()){
                      Map<String,dynamic> bodyAPI = <String, dynamic>{
                        "corporate_id": "",
                        "email" : emailController.text,
                        "first_name" : firstnameController.text,
                        "last_name" : lastNameController.text,
                        "password" : newPasswordController.text,
                        "user_contact" : {
                          "address" : address1Controller.text,
                          "address2" : address2Controller.text,
                          "country" : _selectedCountryCode.toString(),
                          "created_by" : "1",
                          "mobile" : mobileNumberConroller.text,
                          "pincode" : zipCodeController.text
                        },
                        "profile_pic" : base64Image,
                      };

                      Map<String,Map<String,String>> userContact = <String,Map<String,String>>{
                      };


                      String apiUrl = addInvestor;
                      print(addInvestor);
                      print(bodyAPI);
                      String response = await apiHelper.callApiWithToken(apiUrl,bodyAPI);
                      print("response "+response);
                      String address="";

                      if(response == "Error")
                      {
                        print("Error");
                        Fluttertoast.showToast(
                          msg: "Please check email and other details",
                          toastLength: Toast.LENGTH_SHORT,
                        );

                        // Navigator.of(context).pop();
                      }else {
                        AddIvestorRes res = AddIvestorRes.fromJson(json.decode(response));
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
                            MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :3)),
                                (Route<dynamic> route) => false,
                          );




                      }
                    }else{
                      Fluttertoast.showToast(
                        msg: "Password mismatched",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  }else{
                    Fluttertoast.showToast(
                      msg: "Please enter retype password",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                }else{
                  Fluttertoast.showToast(
                    msg: "Please enter new password",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              }else{
                Fluttertoast.showToast(
                  msg: "Please enter address 2",
                  toastLength: Toast.LENGTH_SHORT,
                );
              }
            }else{
              Fluttertoast.showToast(
                msg: "Please enter address 1",
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          }else{
            Fluttertoast.showToast(
              msg: "Please enter mobile number",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }else{
          Fluttertoast.showToast(
            msg: "Please enter Email",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }else{
        Fluttertoast.showToast(
          msg: "Please enter last name",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }else{
      Fluttertoast.showToast(
        msg: "Please enter first name",
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
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("Add investors", style: blackHeadStyle,),
              backgroundColor: Colors.white,
            ),
            backgroundColor: backgroundcolor,
            body:SingleChildScrollView(
                child:
                Padding(padding: EdgeInsets.all(10.0),
                    child:
                    Container(
                      color: backgroundcolor,
                      child: Column(
                          children:
                          <Widget>
                          [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0,right: 10.0,top: 10.0,bottom: 5.0),
                                  child:
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.85,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey, width: 0.1)
                                    ),
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: _image == null
                                                      ? AssetImage('assets/images/admin.png')
                                                      : FileImage(_image!) as ImageProvider,
                                                )
                                              ],
                                            ),
                                          ),

                                          SizedBox(width: 30,),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width * 0.40,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        child: TextButton(
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty.resolveWith(
                                                  (states) => Colors.black12,
                                            ),
                                          ),
                                          onPressed: _pickImage,
                                          child: Text(
                                            "Choose profile image",

                                            style: TextStyle(color: Colors.white,fontSize: 10),
                                          ),
                                        ),
                                      )],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0,right: 10.0,top: 10.0,bottom: 5.0),
                                  child:
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.85,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey, width: 0.1)
                                    ),
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0,right: 8,top: 8,bottom: 8),
                                      child:
                                        Column(
                                          children: [
                                            SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                Text("First Name"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: firstnameController,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'First Name ',
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
                                            Row(
                                              children: [
                                                Text("Last Name"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: lastNameController,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Last Name ',
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
                                            Row(
                                              children: [
                                                Text("Email"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: emailController,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Email ',
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
                                            Row(
                                              children: [
                                                Text("Mobile number"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: mobileNumberConroller,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Mobile number ',
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
                                            Row(
                                              children: [
                                                Text("Address 1"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: address1Controller,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Address 1 ',
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
                                            Row(
                                              children: [
                                                Text("Address 2"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: address2Controller,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Address 2 ',
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
                                            Row(
                                              children: [
                                                Text("Select country"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              margin: EdgeInsets.only(top: 15),
                                              height: 80,
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  CountryCodePicker(
                                                    onChanged: (CountryCode countryCode) {
                                                      setState(() {
                                                        _selectedCountryCode = countryCode;
                                                      });
                                                    },
                                                    initialSelection: 'US',
                                                    favorite: ['+1', 'US'],
                                                    showCountryOnly: false,
                                                    showOnlyCountryWhenClosed: false,
                                                    alignLeft: false,
                                                  ),
                                                /*  SizedBox(width: 8.0),
                                                  _selectedCountryCode != null
                                                      ? Text(
                                                    _selectedCountryCode?.dialCode ?? '',
                                                    style: TextStyle(fontSize: 16.0),
                                                  )
                                                      : SizedBox(),*/
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15,),
                                            Row(
                                              children: [
                                                Text("Zipcode"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: zipCodeController,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Zipcode ',
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
                                            Row(
                                              children: [
                                                Text("New password"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: newPasswordController,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'New password ',
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
                                            Row(
                                              children: [
                                                Text("Retype password"),
                                                const Text('*', style: TextStyle(color: Colors.red)),
                                                Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                ),
                                              ],
                                            ),
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
                                                        controller: retypePasswordController,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                            )
                                                            ,
                                                            hintText: 'Retype password ',
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
                                            SizedBox(height: 25,),

                                            Align(
                                              alignment: Alignment.topCenter,
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
                                                  onPressed: (){
                                                    saveAddInvestor(context);
                                                   /* Navigator.push(
                                                        context, MaterialPageRoute(builder: (context) => InvestorsListPage()));*/
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: kButtonText.copyWith(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15,),

                                          ],
                                        )
                                    ),
                                  ),
                                ),

                              ],
                            )
                          ]
                      ),
                    ))
            )),
      );
  }

}

