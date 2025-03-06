import 'package:flutter/material.dart';
import 'package:quityown/pages/LoginPage.dart';
import 'package:quityown/pages/SendEmailtoSignin.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/pages/language.dart';
import 'package:quityown/widgets/my_text.dart';
import 'package:quityown/widgets/my_text_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final emailController = TextEditingController();
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
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          /*decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_page_background_one.jpg'),
                fit : BoxFit.cover,
              )
          ),*/

         child: Padding(
           padding: const EdgeInsets.all(14.0),
           child: SingleChildScrollView(
             child: Column(
               children: [
               Align(
                 alignment: Alignment.topLeft,
                 child: Text("Explore properties",style: blackHeadStyle,),
               ),
                 SizedBox(height: 20,),
                 SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                   child: PageView(
                     onPageChanged: (int page) {
                       setState(() {
                         currentIndex = page;
                       });
                     },
                     controller: _pageController,
                     children:<Widget>[
                          makePage(
                              image: 'assets/images/welcome_page_background_one.jpg',
                              title: 'Easy way to grow your money to invest in real estate',
                              content:''
                          ),
                       makePage(
                           image: 'assets/images/start_01.jpg',
                           title: 'Transparent and Digital Investing',
                           content:'Digitally & Securely invest to new projects to maximize the profit!'
                       ),
                       makePage(
                           image: 'assets/images/start_02.jpg',
                           title: 'Invest from AED 500',
                           content:'Start your investment from only AED500 (USD 136), no matter where you are in the world!'
                       ),

                       makePage(
                         image: 'assets/images/start_03.png',
                         title: 'Investment Growth',
                         content: 'Start your investment from only AED500 (USD 136), no matter where you are in the world!'
                       ),

                       makePage(
                           image: 'assets/images/trust.jpg',
                           title: 'Trust',
                           content: 'EQUITYOWN is negulate by DIFC and follow all regular in UAE'
                       ),
                     ]
                   ),
                 ),
                 Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: _buildIndicator(),
                   ),
                 ),
                 SizedBox(height: 4,),
                 /*MyTextButton(buttonName: 'Get Started',
                     onTap: (){
                       Navigator.push(
                           context, MaterialPageRoute(builder: (context) => SendEmailtoSigin()));
                     },
                     bgColor: Colors.indigo, textColor: Colors.white),*/
                 SizedBox(height: 10,),
                 MyTextButton(buttonName: 'Login', onTap: (){
                   Navigator.push(
                       context, MaterialPageRoute(builder: (context) => LoginPage()));
                 }, bgColor: Colors.greenAccent, textColor: Colors.white),
                  SizedBox(height: 10,),
                 Text('Regulated by DIFC')
               ],
             ),
           ),
         )
        ),
      ),
    );
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

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<5; i++) {
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
