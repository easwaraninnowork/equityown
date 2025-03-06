import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/ConfirmEmailAddress.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/LoginPage.dart';
import 'package:quityown/pages/SignupRes.dart';
import 'package:quityown/pages/language.dart';
import 'package:quityown/pages/my_text_field_without_border.dart';
import 'package:quityown/pojo/ForgotPasswordRes.dart';
import 'package:quityown/pojo/LoginRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:quityown/widgets/my_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();

}


class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final mobilenumberController = TextEditingController();
  final otpController = TextEditingController();
  late PageController _pageController;
  int currentIndex = 0;
  String selectedCountryCode = '+1';

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

  forgotApi() async
  {
    ApiHelper apiHelper = new ApiHelper(context);
    Map<String, String> bodyAPI = new Map();
    bodyAPI = <String, String>{
      "email": emailController.text.toString(),
    };
    print(bodyAPI);
    print(forgotPasswordApi);
    String response = await apiHelper.callApi(forgotPasswordApi, bodyAPI);
    print("checjjjcjcjc "+response);

    if(response != 'Error'){
      var jsonResponse = jsonDecode(response);
      ForgotPasswordRes res = ForgotPasswordRes.fromJson(jsonResponse);
      //SignupRes signupRes = SignupRes.fromJson(json.decode(response));
      //print('Message: ${res.message}');
      if(res.message == "Password reset link successfully. Please check your email."){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );
      }
    }else{
      Fluttertoast.showToast(
          msg: "Please check your email",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );

    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: SafeArea(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit : BoxFit.cover,
                )
            ),
            child:
            Column(
                children: [
                  Container(
                    height: 300,
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
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Column(
                        children: [
                          SizedBox(height: 15,),
                          Padding(padding: EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text('Forgot your Password?',style: styleHead3,),
                              )),
                          Padding(padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("No worries, we'll send you a link to reset your password",style: styleHead2,),),
                          SizedBox(height: 20,),
                          MyTextField(hintText: "Email Address", inputType: TextInputType.emailAddress, icon : Icons.mail,textEditingController: emailController),
                          MyTextButton(buttonName: "Reset Password", onTap: ()
                          {
                            forgotApi();
                          }, bgColor: Colors.greenAccent, textColor: Colors.white),
                        ],
                      )
                    ),
                  ),
                ]
            ),
          ),
        ));
  }





}