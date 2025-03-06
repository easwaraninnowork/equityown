import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/pages/AccountInfoPage.dart';
import 'package:quityown/pages/PreferencesPage.dart';
import 'package:quityown/pages/ProfilePage.dart';
import 'package:quityown/pages/SetDisplayCurrencyPage.dart';

class CurrencyPage extends StatefulWidget{
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPage();
}

class _CurrencyPage extends State<CurrencyPage>{
  static const bgColor1 = const Color(0xff41ce8e);
  static const bgColor2 = const Color(0xff18b16c);
  static const bgColor3 = const Color(0xff2c9666);
  static const buttonColor = const Color(0xff0b0837);

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
          backgroundColor: Colors.white,
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
                  Image.asset('assets/images/currency_image.png'),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text('Choosing a display currency lets \n you view yours assests in your \n preferred currency ',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AccountInfoPage()));
                    },
                    child:
                    Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                          color: bgColor1
                      ),

                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              alignment: Alignment.topLeft,
                              child: Image.asset('assets/images/currency_icon_1.png'),
                            ),

                            SizedBox(width: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Equityown functions in UAE Dirhams(AED)",
                                    style: TextStyle(fontSize: 14,
                                        color: Colors.white),textAlign: TextAlign.start,),
                                  Text("We hold your money securely and carry out all transactions in United Arab Emirates Dirhams(AED)",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.white),textAlign: TextAlign.start,)
                                ],
                              ),),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                          color: bgColor2
                      ),

                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              alignment: Alignment.topLeft,
                              child: Image.asset('assets/images/currency_icon_2.png'),
                            ),

                            SizedBox(width: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Your display currency is an approximation",
                                    style: TextStyle(fontSize: 14,
                                        color: Colors.white),textAlign: TextAlign.start,),
                                  Text("We show the estimated value of your assets in your preferred currency for reference purpose only. ",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.white),textAlign: TextAlign.start,)
                                ],
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                          color: bgColor3
                      ),

                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              alignment: Alignment.topLeft,
                              child: Image.asset('assets/images/currency_icon_3.png'),
                            ),

                            SizedBox(width: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("All properties on Equityown are priced and sold in UAE Dirhams (AED)",
                                    style: TextStyle(fontSize: 14,
                                        color: Colors.white),textAlign: TextAlign.start,),
                                  Text("Use this setting to approximate the value of your properties in local currencies. ",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.white),textAlign: TextAlign.start,)
                                ],
                              ),),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child:
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.black12,
                          ),
                        ),
                        onPressed: (){
                          /*Navigator.pushReplacement(context, MaterialPageRoute(builder:
                              (context)=>
                              SetDisplayCurrencyPage()
                          ));*/
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color:Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
          ),
        ),
      ),
    );
  }
}