import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/WelcomeScreen.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/pages/language.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    String token_value = "";
    SaveData saveData = SaveData();
    Future<String?> futurestring = saveData.getSavedString("token");
        futurestring.then((value) =>
       // if(value != null){
        token_value = value!

       // }
    );

    Timer(Duration(seconds: 2),() =>
        //print("token" +token_value)
        splash_fun(token_value, context)
    );






    /*Timer(Duration(seconds: 4),() =>
          Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context)=>
              WelcomePage()
          )));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container
          (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.99,
          /*decoration:
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vector_splash.png'),
              fit : BoxFit.cover,
            )
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.23,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/vector_splash.png'),
                        fit : BoxFit.cover,
                      )
                  ),
                  child: Image.asset("assets/images/equityown_logo_2.png")),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.65,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage('assets/images/splash_02.png'),
                  fit : BoxFit.cover,
                )
                                ),
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text("Regulated by DIFC",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white),),
                  )),
            ],
          ),
        ),
      ),


    );
  }
}

splash_fun(token_value,context){
  if(token_value == ""){
    Timer(Duration(seconds: 4), () =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder:
            (context)=>
            WelcomePage()
        )));
  }
  else
  {
    Timer(Duration(seconds: 4),() =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder:
            (context)=>
            HomeScreen(pageIndex :0)
        )
        )
    );
  }
}