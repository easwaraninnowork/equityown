import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/language.dart';
import 'package:quityown/pages/my_text_field_without_border.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:quityown/widgets/my_text_field.dart';

class ConfirmEmailAddress extends StatefulWidget{
  const ConfirmEmailAddress({super.key});

  @override
  State<ConfirmEmailAddress> createState() => _ConfirmEmailAddress();

}

class _ConfirmEmailAddress extends State<ConfirmEmailAddress> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final mobilenumberController = TextEditingController();
  late PageController _pageController;
  int currentIndex = 0;

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
        backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Confirm Email Address",style: blackHeadStyle,),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
        body: Container(
            width: double.infinity,
            height: double.infinity,

            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(alignment: Alignment.center,
                            child: Column(
                              children: [
                                Image.asset('assets/images/confirm_email_image.jpg',
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  height: 400,),
                                Text('Confirm your email address',style: blackChildStyle,textAlign: TextAlign.center,),
                                SizedBox(height: 10,),
                                Text('Confirmation link was sent to ',style: blackChildStyle,textAlign: TextAlign.center,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('ebenezer@innowork.com .',style: greenChildStyle,),
                                    SizedBox(width: 3,),
                                    Text('Please click',style: blackChildStyle,),
                                  ],
                                ),
                                Text('on the link in your inbox to verify',style: blackChildStyle,textAlign: TextAlign.center,),
                                Text('your account',style: blackChildStyle,textAlign: TextAlign.center,),
                                SizedBox(height: 30,),
                                MyTextButton(buttonName: 'open Inbox', onTap: ()
                                {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :0)));
                                }
                                , bgColor: Colors.black, textColor: Colors.white)
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

}