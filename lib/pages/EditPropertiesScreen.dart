import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/pages/AddPropertyLocationPage.dart';
import 'package:quityown/pages/AddpropertyDetailsPage.dart';
import 'package:quityown/pages/AddpropertyinfoPage.dart';
import 'package:quityown/pages/EditAmentiesPage.dart';
import 'package:quityown/pages/EditFinancialPage.dart';
import 'package:quityown/pages/EditProjectScreen.dart';
import 'package:quityown/pages/UploadsScreen.dart';


import 'AddfinancialDetailsPage.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class EditPropertiesScreen extends StatefulWidget{
  var pageIndex=0;


  EditPropertiesScreen({super.key,required this.pageIndex});

  @override
  State<EditPropertiesScreen> createState() => _EditPropertiesPage(pageIndex);
}

class _EditPropertiesPage extends State<EditPropertiesScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  var pageIndex = 0;

  _EditPropertiesPage(this.pageIndex);

  void initState(){
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();

    _tabController.animateTo(pageIndex);

  }


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
            title: Text('Add properties',style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
                children:
                <Widget>
                [
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: TabBar(
                            tabs: [
                              Container(
                                width: 70.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  "Projects",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: 100.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  'Uploads',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: 75.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  'Amenties',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: 75.0,
                                alignment: Alignment.center,
                                child: new Text(
                                  'Financials',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                            unselectedLabelColor: const Color(0xffacb3bf),
                            indicatorColor: Color(0xFFffac81),
                            labelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 3.0,
                            indicatorPadding: EdgeInsets.all(10),
                            isScrollable: false,
                            controller: _tabController,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                Container(
                                  child: EditProjectScreen(),
                                ),
                                Container(
                                  child: UploadsScreen(),
                                ),
                                Container(
                                  child: EditAmentiesPage(),
                                ),
                                Container(
                                  child: EditFinancialPage(propertyid: "1"),
                                ),
                              ]
                          ),
                        ),
                      ],

                    ),
                  )
                ]
            ),
          )),
    );
  }


}