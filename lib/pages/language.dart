import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/SendEmailtoSignin.dart';
import 'package:quityown/widgets/languagelayout.dart';
import 'package:quityown/widgets/constants.dart';

import '../controller/language_change_controller.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});
  @override
    State<LanguagePage> createState() => _LanguagePage();
}

class _LanguagePage extends State<LanguagePage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        body:
        Consumer<LanguageChangeController>(
            builder : (context,provider,child)
            {
              return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/language_bg.png'),
                fit : BoxFit.cover,
              )
          ),

          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Language',style: blackHeadStyle,textAlign: TextAlign.center,),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Image(image: AssetImage('assets/images/close.png'),alignment: Alignment.center,width: 30,height: 30,))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top : 50),
                      child : Image(image: AssetImage('assets/images/equityown.png'),width: 150,height: 50,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top : 30),
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LanguageLayout(language: 'Arabic', onTap: (){
                         provider.changeLanguage(Locale('es'));
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              HomeScreen(pageIndex :0))
                         );
                        }, imageName: 'assets/images/uae.png'),
                        SizedBox(width: 30,),
                        LanguageLayout(language: 'English', onTap: (){
                          provider.changeLanguage(Locale('en'));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              HomeScreen(pageIndex :0))
                          );
                        }, imageName: 'assets/images/uk.png'),
                      ],
                    ),
                  ),


                ],
              )
          )

      );
              },
      ),
    ));
  }
}