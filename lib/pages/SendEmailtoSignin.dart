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
import 'package:quityown/pages/SignupRes.dart';
import 'package:quityown/pages/language.dart';
import 'package:quityown/pages/my_text_field_without_border.dart';
import 'package:quityown/pojo/LoginRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:quityown/widgets/my_text_field.dart';

class SendEmailtoSigin extends StatefulWidget{
  const SendEmailtoSigin({super.key});

  @override
  State<SendEmailtoSigin> createState() => _SendEmailtoSigin();

}


class _SendEmailtoSigin extends State<SendEmailtoSigin> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
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

  callSignup() async
  {
    ApiHelper apiHelper = new ApiHelper(context);
    Map<String, String> bodyAPI = new Map();
    bodyAPI = <String, String>{
      "full_name": nameController.text.toString(),
      "email": emailController.text.toString(),
      "password": passwordController.text.toString(),
      "mobile": mobilenumberController.text.toString(),
      "country_code" : selectedCountryCode
    };
    print(bodyAPI);
    print(signupApi);
    String response = await apiHelper.callApi(signupApi, bodyAPI);
    print(response);

   // if (response != "error") {
      SignupRes signupRes = SignupRes.fromJson(json.decode(response));
      print("SignupError" + signupRes.error.toString());
      print("SignupMessage" + signupRes.message.toString());
      Fluttertoast.showToast(
          msg: "Please check otp",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
      /*if(signupRes.message.toString() == 'null')
      {
        final res = jsonDecode(response);
        Fluttertoast.showToast(
            msg: signupRes.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpView(mobileNumber: phoneController.text,)));
      }else
      {
        _pageController.jumpToPage(3);
        Fluttertoast.showToast(
            msg: signupRes.error.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );
      }*/

  }

  @override
  Widget build(BuildContext context) {
   /* return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          */
    /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/welcome_page_background_one.jpg'),
              fit : BoxFit.cover,
            )
        ),*/
    /*

          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/bg.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              child:  IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Align(alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text('Say Hello',style: whiteHeadStyle,textAlign: TextAlign.center,),
                                  Text('to Passive income',style: whiteHeadStyle,textAlign: TextAlign.center,)
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.40,
                              child: PageView(
                                  onPageChanged: (int page) {
                                    setState(() {
                                      currentIndex  = page;
                                    });
                                  },
                                  controller: _pageController,
                                  children:<Widget>[
                                    makePage1(),
                                    makePage2(),
                                    makePage3(),
                                    makePage4(),
                                    makePage5(),
                                    makePage6()
                                  ]
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildIndicator(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );*/
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
          child: Column(
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
              child: Column(
                children: [

                  SizedBox(
                    height: 400,
                    child: PageView(
                        onPageChanged: (int page) {
                          setState(() {
                            currentIndex  = page;
                          });
                        },
                        controller: _pageController,
                        children:<Widget>[
                          makePage1(),
                          makePage2(),
                          makePage3(),
                          makePage4(),
                          makePage5(),
                          makePage6()
                        ]
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildIndicator(),
                    ),
                  )
                ],
              ),
            ),
          ),
            ]
        ),
    ),
      ));
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Column(
        children:<Widget>[
          currentIndex == 0 ?
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height / 2,child: Image.asset(image)),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [ BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                        ),]
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: MyTextButton(
                          buttonName: 'How its works', onTap: (){}, bgColor: Colors.white, textColor: Colors.black
                      ),
                    )
                ),
              )
            ],
          ) :
          SizedBox(height:MediaQuery.of(context).size.height / 2,child: Image.asset(image)),
          Text(title,style: blackHeadStyle,),
          Text(content,style: styleHead2,textAlign: TextAlign.center,),
        ]
    );
  }
  Widget makePage1() {
    return
          Column(
            children: [
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Join',style: blackHeadStyle,),
                  SizedBox(width: 10,),
                  Text('Equityown',style: greenHeadStyle,)
                ],
              ),
              MyTextField(hintText: "Full Name", inputType: TextInputType.name,icon: Icons.person, textEditingController: nameController),
              MyTextField(hintText: "Email Address", inputType: TextInputType.emailAddress, icon : Icons.mail,textEditingController: emailController),
              Padding(padding: EdgeInsets.only(bottom: 10.0),
              child: Text('We will send you an email to create your account.',style: styleHead2,),),
              MyTextButton(buttonName: "Let's Go!", onTap: ()
              {
                _pageController.jumpToPage(1);
              }
              , bgColor: Colors.greenAccent, textColor: Colors.white),
            ],
          );
  }
  Widget makePage2() {
    return
          Column(
            children: [
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.only(bottom: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('You email has been verified !',style: greenChildStyle,)
              )),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                    child: Text('Create password',style: styleHead3,),
                  )),

              MyTextField(hintText: "Strong-password123#", inputType: TextInputType.name,icon: Icons.person, textEditingController: passwordController),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: EdgeInsets.all(10.0),
                  child: Text('Passwords should have :',style: blackHeadStyle,),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: EdgeInsets.all(2.0),
                  child: Text(
                    '. Minimum length at 8 characters',style: styleHead2,
                  ),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: EdgeInsets.all(2.0),
                  child:
                  Text('. At least one uppercase charater is required',style: styleHead2,textAlign: TextAlign.left,)
                    ,),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: EdgeInsets.all(2.0),
                  child:
                  Text('. At least one lowercase charater is required',style: styleHead2,textAlign: TextAlign.left,)
                  ,),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: EdgeInsets.all(2.0),
                  child:
                  Text('. Number character(s) is required',style: styleHead2,textAlign: TextAlign.left,),),
              ),
              Padding(padding: EdgeInsets.all(10.0),
              child: MyTextButton(buttonName: "Create Account", onTap: (){
                _pageController.jumpToPage(2);
              }, bgColor: Colors.greenAccent, textColor: Colors.white),)
            ],
          );
  }
  Widget makePage3() {
    return
          Column(
            children: [
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Enter Phone number',style: styleHead3,),
                  )),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Please enter your phone number to continue',style: blackChildStyle,),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 SizedBox(
                   width: 100,
                   height: 50,
                   child:  Center(
                     child: CountryCodePicker(
                       onChanged: (countryCode) {
                         setState(() {
                           selectedCountryCode = countryCode.dialCode!;
                         });
                       },
                       // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                       initialSelection: 'IT',
                       favorite: ['+39','FR'],
                       // optional. Shows only country name and flag
                       showCountryOnly: false,
                       // optional. Shows only country name and flag when popup is closed.
                       showOnlyCountryWhenClosed: false,
                       // optional. aligns the flag and the Text left
                       alignLeft: false,
                     ),
                   ),
                 ),
                  SizedBox(width: 10,),

                  SizedBox(
                    width: 200,
                    height: 70,
                    child: MyTextFieldWithoutBorder(hintText: "000 000 000 0", inputType: TextInputType.phone, textEditingController: mobilenumberController)
                  )
                ],
              ),
              MyTextButton(buttonName: "Next", onTap: (){
                callSignup();
              }, bgColor: Colors.greenAccent, textColor: Colors.white),
            ],
          );
  }
  Widget makePage4() {
    return
          Column(
            children: [
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Verify OTP',style: styleHead3,),
                  )),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Enter the OTP',style: blackChildStyle,),
                  )),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('We have sent an OTP to your phone',style: greyChildStyle,),
                  )),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('919******27 Please enter the OTP to Log In',style: greyChildStyle,),
                  )),
              MyTextFieldWithoutBorder(hintText: "........", inputType: TextInputType.name, textEditingController: otpController),
              MyTextButton(buttonName: "Submit", onTap: (){
                _pageController.jumpToPage(4);
              }, bgColor: Colors.greenAccent, textColor: Colors.white),
              Padding(
                  padding: EdgeInsets.all(10.0),
              child: Text('Resend OTP',style: greenChildStyle,),)
            ],
          );
  }
  Widget makePage5() {
    return
          Column(
            children: [
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Welcome Back !',style: styleHead3,),
                  )),
              MyTextField(hintText: "Email Address", inputType: TextInputType.emailAddress, icon : Icons.mail,textEditingController: emailController),
              MyTextField(hintText: ".............", inputType: TextInputType.visiblePassword,icon: Icons.remove_red_eye, textEditingController: passwordController),
              MyTextButton(buttonName: "Login", onTap: ()
              {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ConfirmEmailAddress()));
              }, bgColor: Colors.greenAccent, textColor: Colors.white),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Forgot password',style: greenChildStyle,),),

              Padding(padding: EdgeInsets.only(bottom: 10.0),
              child: Text('By clicking Log in you agree to Equityown',style: styleHead2,),),
              Padding(padding: EdgeInsets.only(bottom: 10.0),
              child: Text('Terms & conditions and Key Risks',style: styleHead2,),),
            ],
          );
  }
  Widget makePage6() {
    return
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :0)));
              }, bgColor: Colors.greenAccent, textColor: Colors.white),
            ],
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