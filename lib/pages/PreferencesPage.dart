import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/pages/language.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class PreferencesPage extends StatefulWidget{
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPage();
}

class _PreferencesPage extends State<PreferencesPage>{
  static const containerbackgrounColor = const Color(0xfff4f4f4);
  static const backgroundcolor= const Color(0xfff1f5f9);

  bool app_notification_boolean = true;
  bool biometric_boolean = false;
  bool marketing_email_boolean = true;
  bool haptic_feedback_boolean = false;

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
          title: Text(AppLocalizations.of(context)!.preferences,style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child:
            Padding(
              padding: EdgeInsets.only(left: 20,top: 15,right: 10,bottom: 15),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)),
                        color: backgroundcolor
                    ),

                    child:
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => LanguagePage()));
                              },
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  alignment: Alignment.topLeft,
                                  height: 40,
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/worldwide_icon.png'),
                                      SizedBox(width: 10,),
                                      Text(AppLocalizations.of(context)!.language,style: TextStyle(color: Colors.black,fontSize: 16),)
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(AppLocalizations.of(context)!.english,style: TextStyle(color: Colors.black,fontSize: 16),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.arrow_forward_ios_sharp)
                                    ],
                                  ),)
                              ],
                            ),
                          ),

                          /*SizedBox(height: 20,),
                          InkWell(
                              onTap: (){
                                *//*Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => CurrencyPage()));*//*
                              },
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  alignment: Alignment.topLeft,
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.currency_lira_sharp),
                                      SizedBox(width: 10,),
                                      Text(AppLocalizations.of(context)!.currency,style: TextStyle(color: Colors.black,fontSize: 16),)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  alignment: Alignment.topRight,
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('AED',style: TextStyle(color: Colors.black,fontSize: 16),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.arrow_forward_ios_sharp)
                                    ],
                                  ),)
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      /*Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AccountInfoPage()));*/
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
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(AppLocalizations.of(context)!.app_notification,style: blackHeadStyle,),
                                ),
                                Container(alignment: Alignment.topRight,
                                child: CupertinoSwitch(
                                  value: app_notification_boolean,
                                  onChanged: (value) {
                                    setState(() {
                                      app_notification_boolean = value;
                                    });
                                  },
                                ),)
                              ],
                            ),
                            Text(AppLocalizations.of(context)!.app_notification_content,style: blackChildStyle,textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      /*Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AccountInfoPage()));*/
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
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(AppLocalizations.of(context)!.biometric_authentication,style: blackHeadStyle,),
                                ),
                                Container(alignment: Alignment.topRight,
                                  child: CupertinoSwitch(
                                    value: biometric_boolean,
                                    onChanged: (value) {
                                      setState(() {
                                        biometric_boolean = value;
                                      });
                                    },
                                  ),)
                              ],
                            ),
                            Text(AppLocalizations.of(context)!.biometric_authentication_content
                                ,style: blackChildStyle,textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                     /* Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AccountInfoPage()));*/
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
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(AppLocalizations.of(context)!.marketing_emails,style: blackHeadStyle,),
                                ),
                                Container(alignment: Alignment.topRight,
                                  child: CupertinoSwitch(
                                    value: marketing_email_boolean,
                                    onChanged: (value) {
                                      setState(() {
                                        marketing_email_boolean = value;
                                      });
                                    },
                                  ),)
                              ],
                            ),
                            Text(AppLocalizations.of(context)!.marketing_email_content,style: blackChildStyle,textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      /*Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AccountInfoPage()));*/
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
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(AppLocalizations.of(context)!.haptic_feedback,style: blackHeadStyle,),
                                ),
                                Container(alignment: Alignment.topRight,
                                  child: CupertinoSwitch(
                                    value: haptic_feedback_boolean,
                                    onChanged: (value) {
                                      setState(() {
                                        haptic_feedback_boolean = value;
                                      });
                                    },
                                  ),)
                              ],
                            ),
                            Text(AppLocalizations.of(context)!.haptic_feedback_content,style: blackChildStyle,textAlign: TextAlign.start,)
                          ],
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