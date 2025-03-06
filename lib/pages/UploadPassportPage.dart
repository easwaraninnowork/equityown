import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/PropertiesDetailsPage.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_button.dart';

class UploadPassportPage extends StatefulWidget{
  const UploadPassportPage({super.key});

  @override
  State<UploadPassportPage> createState() => _UploadPassPortPage();
}

class _UploadPassPortPage extends State<UploadPassportPage>{
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
    return
      Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Upload your password",style: blackHeadStyle,),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
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
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.0),
                                    child: Text('Financial regulations require us to verify your \n identity before you can invest',style: blackChildStyle,textAlign: TextAlign.center,),),
                                  SizedBox(height: 10,),
                                  Padding(padding: EdgeInsets.only(bottom: 20.0),
                                    child: Text('This helps protect your investment and allows us to \n register you as the legal owner of each property \n you invest in',style: blackChildStyle,textAlign: TextAlign.center,),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                    children: [
                                      Column(
                                        children: [
                                          Image.asset('assets/images/passport6.png',width: 100,height: 100,),
                                          Text('Show all details - including \n the 2 lines at the bottom',style: blackChildStyle,textAlign: TextAlign.center,),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.asset('assets/images/passport2.png',width: 100,height: 100,),
                                          Text('No photos captured \n from another screen',style: blackChildStyle,textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset('assets/images/passport3.png',width: 100,height: 100,),
                                          Text('No glare or overexposed \n photos',style: blackChildStyle,textAlign: TextAlign.center,),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.asset('assets/images/passport5.png',width: 100,height: 100,),
                                          Text('No overcropped or \n cutoff photos',style: blackChildStyle,textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(10.0),
                                    child: MyTextButton(buttonName: 'Start verification', onTap: ()
                                    {
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => PropertiesDetailsPage(propertyid: '',)));
                                    }
                                        , bgColor: Colors.greenAccent, textColor: Colors.white),),
                                  Padding(padding: EdgeInsets.all(10.0),
                                    child: Text('Do this later',style: greenChildStyle,),),
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