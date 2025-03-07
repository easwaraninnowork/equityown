import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/ConfirmEmailAddress.dart';
import 'package:quityown/pages/ForgotPasswordScreen.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/SendEmailtoSignin.dart';
import 'package:quityown/pages/language.dart';
import 'package:quityown/pages/my_text_field_without_border.dart';
import 'package:quityown/pojo/LoginRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late PageController _pageController;
  int currentIndex = 0;
  bool _obscureText = true;
  bool _isChecked = false;


  callLogin() async
  {
    ApiHelper apiHelper = new ApiHelper(context);
    Map<String,String> bodyAPI = new Map();
    bodyAPI = <String, String>{
      "email" : emailController.text,
      "password" : passwordController.text
    };
    print(loginApi);
    print(bodyAPI);
    String response = await apiHelper.callApi(loginApi, bodyAPI);
    print(response);

    if(response != "Error")
    {
      LoginRes loginRes = LoginRes.fromJson(json.decode(response));

      if(loginRes.error == null)
      {
        final res = jsonDecode(response);
        print(res["otp"]);
        Fluttertoast.showToast(
            msg: loginRes.user!.firstName!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );
        SaveData saveData = SaveData();
        saveData.storeString("token", loginRes.token!);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', loginRes.user!.firstName!);
        await prefs.setString('userid', loginRes.user!.id!.toString());

        var userValue = (prefs.getString('user') ?? '');
        print("uservalue -->"+userValue);

        Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :0)));
       // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpView(mobileNumber: phoneController.text,)));
      }else
      {
        Fluttertoast.showToast(
            msg: loginRes.error!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );
      }
    }
    else{
      Fluttertoast.showToast(
          msg: "Kindly check your credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
      );
    }
  }

  @override
  void initState() {
    _pageController = PageController(
        initialPage: 0
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset : false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit : BoxFit.cover,
                )
            ),
            child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child:
                    Column(
                      children: [
                        Align(
                          child:  IconButton(
                            icon: Icon(Icons.arrow_back,color: Colors.white,),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 40,),
                              Text('Say Hello',style: whiteHeadStyle,textAlign: TextAlign.center,),
                              Text('to Passive income',style: whiteHeadStyle,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.50,
                            child:
                            Column(
                              children: [
                                SizedBox(height: 15,),
                                Padding(padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Welcome Back !',style: styleHead3,),
                                    )),
                                MyTextField(hintText: "Email Address", inputType: TextInputType.emailAddress, icon : Icons.mail,
                                    textEditingController: emailController),
                                /*Container(
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
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                      new Expanded(
                                        child: TextField(
                                          controller: passwordController,
                                          obscureText: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "............",
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
                                      )
                                    ],
                                  ),
                                ),*/
                                Container(
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
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText; // Toggle password visibility
                                            });
                                          },
                                          child: Icon(
                                            !_obscureText ? Icons.remove_red_eye : Icons.visibility_off,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: passwordController,
                                          obscureText: _obscureText,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "............",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                            isDense: true,
                                          ),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

    // MyTextField(hintText: ".............", inputType: TextInputType.,icon: Icons.remove_red_eye, textEditingController: passwordController),
                                MyTextButton(buttonName: "Login", onTap: ()
                                {
                                  if (!_isChecked) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          onCheckboxChanged: (bool value) {
                                            setState(() {
                                              _isChecked = value;
                                              callLogin();
                                            });
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    // Call another function if _isChecked is true
                                    callLogin();
                                  }


                                  /*Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => HomeScreen()));*/
                                }, bgColor: Colors.greenAccent, textColor: Colors.white),
                                SizedBox(height: 15,),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Forgot password',style: greenChildStyle,),),
                                ),
                                SizedBox(height: 10,),
                                Padding(padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text('By clicking Log in you agree to Equityown',style: styleHead2,),),
                                Padding(padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text('Terms & conditions and Key Risks',style: styleHead2,),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          )),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<6; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }

  Widget _indicator(bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isActive ? Colors.green : Colors.grey
        ),
      ),
    );
  }
  
}

class CustomAlertDialog extends StatefulWidget {
  final Function(bool) onCheckboxChanged;

  CustomAlertDialog({required this.onCheckboxChanged});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Read and Agree'),
      content: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final pdfPath = await _copyAssetPDFToLocal("data_processing_doc.pdf");
                _openPDF(pdfPath);
              },
                child: Text('1.Data processing agreement of Equityown',style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline))),
            InkWell(onTap: () async {
              final pdfPath = await _copyAssetPDFToLocal("terms_service_doc.pdf");
              _openPDF(pdfPath);
            },
                child: Text('2.Terms and services of Equityown',style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline))),
            InkWell(
                onTap: () async {
                  final pdfPath = await _copyAssetPDFToLocal("terms_condition_doc.pdf");
                  _openPDF(pdfPath);
                },
                child: Text('3.Terms and conditions of Equityown',style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline))),
            InkWell(
                onTap: () async {
                  final pdfPath = await _copyAssetPDFToLocal("privacy_policy_doc.pdf");
                  _openPDF(pdfPath);
                },
                child: Text('4.Privacy policy of Equityown',style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline))),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                    // Notify the parent widget about the checkbox change
                    widget.onCheckboxChanged(_isChecked);
                  },
                ),
                Text('I agree to the terms and conditions',style: TextStyle(fontSize: 10,color: Colors.black),),
              ],
            ),
          ],
        ),
      ),
      /*actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle the action when the user presses OK
            print('Checkbox is checked: $_isChecked');
            //callLogin();
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],*/
    );
  }


   // Add this package in pubspec.yaml

  Future<String> _copyAssetPDFToLocal(String pdfFile) async {
    try {
      final ByteData byteData = await rootBundle.load('assets/pdf/$pdfFile');
      final Directory tempDir = await getTemporaryDirectory();

      final Directory pdfDir = Directory('${tempDir.path}/assets/pdf');
      if (!pdfDir.existsSync()) {
        await pdfDir.create(recursive: true);
      }

      final File file = File('${pdfDir.path}/$pdfFile');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      return file.path;
    } catch (e) {
      print('Error copying asset PDF to local: $e');
      rethrow;
    }
  }

  void _openPDF(String path) async {
    try {
      final result = await OpenFile.open(path);  // Using open_file package
      print('Open result: ${result.message}');
    } catch (e) {
      print('Error opening PDF: $e');
      rethrow;
    }
  }


}