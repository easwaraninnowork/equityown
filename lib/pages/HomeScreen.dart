import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/DashboardPage.dart';
import 'package:quityown/pages/InvestorsListPage.dart';
import 'package:quityown/pages/PortfolioPage.dart';
import 'package:quityown/pages/ProfilePage.dart';
import 'package:quityown/pages/PropertiesScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'CartPage.dart';

/*
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
*/

class HomeScreen extends StatefulWidget {

  var pageIndex = 0;
   HomeScreen({Key? key, required int this.pageIndex}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen(pageIndex);
}

class _HomeScreen extends State<HomeScreen> {
  int pageIndex = 0;
  String userValue = "";

  var pages = [];

  _HomeScreen(this.pageIndex);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: const Color(0xffC4DFCB),
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height/10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 0;
                          });
                        },
                        icon: pageIndex == 0
                            ? const Icon(
                          Icons.home_filled,
                          color: Colors.black,
                          size: 25,
                        )
                            : const Icon(
                          Icons.home_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.home,textAlign: TextAlign.center,),
                  ],
                ),
              ),
              if(userValue != 'Admin')
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                      icon: pageIndex == 1
                          ? const Icon(
                        Icons.account_balance,
                        color: Colors.black,
                        size: 25,
                      )
                          : const Icon(
                        Icons.account_balance_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.portfolio,textAlign: TextAlign.center,)
                ],
              ),
              if(userValue != 'Admin')
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          pageIndex = 2;
                        });
                      },
                      icon: pageIndex == 2
                          ? const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                        size: 25,
                      )
                          : const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.cart,textAlign: TextAlign.center,)
                ],
              ),
                if(userValue == 'Admin')
                Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                      icon: pageIndex == 1
                          ? Image.asset('assets/images/investors.png')
                          :  Image.asset('assets/images/investors.png'),
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.investors,textAlign: TextAlign.center,)
                ],
              ),
              if(userValue != 'Admin')
                Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          pageIndex = 3;
                        });
                      },
                      icon: pageIndex == 3
                          ? const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 25,
                      )
                          : const Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.profile,textAlign: TextAlign.center,)
                ],
              ),
              if(userValue == 'Admin')
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        icon: pageIndex == 2
                            ? const Icon(
                          Icons.dashboard_rounded,
                          color: Colors.black,
                          size: 25,
                        )
                            : const Icon(
                          Icons.dashboard_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.dashboard,textAlign: TextAlign.center,)
                  ],
                ),
              if(userValue == 'Admin')
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 3;
                          });
                        },
                        icon: pageIndex == 3
                            ? const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 25,
                        )
                            : const Icon(
                          Icons.person_outline,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.profile,textAlign: TextAlign.center,)
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    //HttpOverrides.global = MyHttpOverrides();
    super.initState();
    gettoken();


    Timer(Duration(seconds: 2), () {
      print("user 1 --->"+userValue);
      // if(userValue != "") {
      print("pages--->"+pages.length.toString());
    });

   // }
  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userValue = (prefs.getString('user') ?? '');
      print("uservalu_gettoken"+userValue);
      pages = addpage(userValue);
    });
  }
}


List addpage(user){
  var pages = [];


  print("userjbiubibi : "+user);

  if(user == "Admin"){
    pages = [
      const PropertiesScreen(),
     // PortfolioPage([], animate: false),
     // const CartPage(),
      const InvestorsListPage(),
      const DashboardPage(),
      const ProfilePage(),
    ];
  }else{
    pages = [
      const PropertiesScreen(),
      PortfolioPage([], animate: false),
      const CartPage(),
      const ProfilePage(),
    ];
  }
  return pages;
}



