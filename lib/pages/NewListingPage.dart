import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/pages/EditPropertiesScreen.dart';
import 'package:quityown/pages/PropertiesDetailsPage.dart';
import 'package:quityown/pojo/UserPropertiesRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NetworkConstants.dart';

class NewListingPage extends StatefulWidget{
  List<Data> newListingList = <Data>[];
  var type = "";


  NewListingPage({super.key,required this.newListingList,required this.type});


  @override
  State<NewListingPage> createState() => _NewListingPage(newListingList,type);
}

/*
* Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(top: 15),
                height: 40,
                child:
                TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: "Search by property city",
                      hintStyle: TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: Colors.white
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(top: 15),
                height: 40,
                child:
                TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: "Search by propertyname/code",
                      hintStyle: TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: Colors.white
                  ),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  showBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) => Container(
                        height: 250,

                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0))),
                            child: new Center(
                              child: new Text("This is a modal sheet"),
                            )),
                      ));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: 40,
                    alignment: Alignment.bottomCenter,
                    transformAlignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/location.png',alignment: Alignment.center,)),
              )

            ],
          ),
        ),
      )*/
class _NewListingPage extends State<NewListingPage> with SingleTickerProviderStateMixin{
  List<Data> newListingList = <Data>[];

  var type="";
  _NewListingPage(this.newListingList,this.type);
  List<Data> fundedListingList = <Data>[];
  List<Data> exitedListingList = <Data>[];

  static const textfieldColor = const Color(0xffD6F5E7);
  static const backgroundcolor = const Color(0xfff1f5f9);
  late TabController _tabController;
  final emailController = TextEditingController();
  final search_by_property_city_controller = TextEditingController();
  final search_by_property_name_code_controller= TextEditingController();



  /*final items = [
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: backgroundcolor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
        ),
        child: Image.asset('assets/images/slider3.jpeg',fit: BoxFit.cover)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider2.png',fit: BoxFit.cover)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider4.jpeg',fit: BoxFit.cover,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider5.jpg',fit: BoxFit.cover,)),
  ];*/

  int currentIndex = 1;
  var userValue = "";

  void _showModalBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: Text('Search property'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child:
                          TextField(
                            controller: search_by_property_city_controller,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              hintText: "Search by property city",
                              hintStyle: TextStyle(fontSize: 12),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child:
                          TextField(
                            controller: search_by_property_name_code_controller,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                hintText: "Search by propertyname/code",
                                hintStyle: TextStyle(fontSize: 12),
                                filled: true,
                                fillColor: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(onPressed:(){
              propertiesApi();
              Navigator.of(context).pop();
              }, child: Text('Search')),
            TextButton(onPressed:(){
              search_by_property_city_controller.text = "";
              search_by_property_name_code_controller.text = "";
              propertiesApi();
              Navigator.of(context).pop();
            }, child: Text('Refresh')),
            TextButton(onPressed:(){
              Navigator.of(context).pop();
              }, child: Text('Close'))
          ],
        )
        ;
      },
    );
  }

  propertiesApi() async{
    ApiHelper apiHelper = ApiHelper(context);

    var city_str  = " ";
    var name_code_str = " ";

    city_str = search_by_property_city_controller.text.toString();
    name_code_str = search_by_property_name_code_controller.text.toString();

     var queryParameters = {
      "per_page": "100"
    };

    if(city_str != ""){
      queryParameters = {
        "per_page": "100",
        "city" : city_str
      };
    }
    else if(name_code_str != "") {
      queryParameters = {
        "per_page": "100",
        "name" : name_code_str
      };
    }
    else if(city_str != "" && name_code_str != "") {
      queryParameters = {
        "per_page": "100",
        "city": city_str,
        "name" : name_code_str
      };
    }

    print(queryParameters);
    String response = await apiHelper.callApiWithTokenGet(userPropertiesApi,queryParameters);
      print("Avalible Response : "+response);

    if(response == "Error")
    {
      setState(() {
        newListingList = [];
      });
    }else {
      UserPropertiesRes res = UserPropertiesRes.fromJson(json.decode(response));
      setState(() {
        //cartQty = totalQty.toString();
        newListingList = [];
        for(int i=0;i<res.result!.data!.length;i++){
          if(res.result!.data![i].status == "available"){
            newListingList.add(res.result!.data![i]);
          }/*else if(res.result!.data![i].status == "exited"){
            exitedListingList.add(res.result!.data![i]);
          }else if(res.result!.data![i].status == "funded"){
            fundedListingList.add(res.result!.data![i]);
          }*/

        }
      /*  print("new listing $newListingList.length");

        print("type  "+type);
        if(type =="available"){
          newListingList = newListingList;
        }else if(type =="funded"){
          newListingList = fundedListingList;
        }else if(type =="exited"){
          newListingList = exitedListingList;
        }*/
        //  newListingList.addAll(res.result!.data!);
      });
    }
  }



  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
    propertiesApi();
    getValues();
    print(newListingList);
    super.initState();
  }

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userValue = (prefs.getString('user') ?? '');
      print("uservalu "+userValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: Colors.white10,
          body:SafeArea(
            child:
            SingleChildScrollView(
                child:
                Padding(padding: EdgeInsets.all(10.0),
                child:
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: backgroundcolor
                  ),
                  child:
                  Padding(padding: EdgeInsets.all(10.0),
                      child:
                      Container(
                        color: backgroundcolor,
                        child: Column(
                            children:
                            <Widget>
                            [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('New Listings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                                  ElevatedButton(
                                      onPressed:()=> _showModalBottomSheet(context),
                                      child: Icon(Icons.filter_list_rounded))
                                ],
                              ),
                              SizedBox(height: 20,),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: newListingList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return  
                                    GestureDetector(
                                      onTap: () => {
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PropertiesDetailsPage(propertyid: newListingList[index].id.toString(),),
                                      ))
                                      },
                                      child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  if(newListingList[index].images!.length != 0)
                                                  CarouselSlider(
                                                    options: CarouselOptions(
                                                      autoPlay: true,
                                                      enlargeCenterPage: false,
                                                      viewportFraction: 1.0,
                                                      onPageChanged: (index, reason) {
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                      },
                                                    ),
                                                    items: newListingList[index].images!.map(
                                                        (item) =>
                                                            Container(
                                                            width: double.infinity,
                                                            height: 300,
                                                            decoration: BoxDecoration(
                                                              color: backgroundcolor,
                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                                                            ),
                                                            child: Image.network(item.path!,
                                                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                  // Log the exception to understand the error
                                                                  print('Error loading image: $exception');

                                                                  // Return a default image in case of an error
                                                                  return Image.asset(
                                                                    'assets/images/slider2.png', // Path to your default image
                                                                    fit: BoxFit.cover,
                                                                  );
                                                                }
                                                                ,fit: BoxFit.cover))
                                                    ).toList(),
                                                  ),

                                                  if(newListingList[index].images!.length == 0)
                                                    Container(
                                                        width: double.infinity,
                                                        height: 180,
                                                        decoration: BoxDecoration(
                                                          color: backgroundcolor,
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                                                        ),
                                                        child: Image.asset('assets/images/slider2.png',fit: BoxFit.cover))
                                                  ,

                                                 /* CarouselSlider(
                                                    options: CarouselOptions(
                                                      autoPlay: true,
                                                      enlargeCenterPage: false,
                                                      viewportFraction: 1.0,
                                                      onPageChanged: (index, reason) {
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                      },
                                                    ),
                                                    items: items,
                                                  ),*/
                                                  /*DotsIndicator(
                                                    decorator: DotsDecorator(
                                                      color: Colors.white,
                                                    ),
                                                    dotsCount: items.length,
                                                    position: currentIndex.toDouble(),
                                                  ),*/
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.75,
                                                      margin: EdgeInsets.only(top: 15),
                                                      height: 40,
                                                      child:
                                                      TextField(
                                                        enabled: false,
                                                        decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                            ),
                                                            hintText: checknull(newListingList[index].address),
                                                            hintStyle: TextStyle(fontSize: 12),
                                                            filled: true,
                                                            fillColor: backgroundcolor
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),

                                                    if(userValue=="Admin")
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditPropertiesScreen(pageIndex: 0),
                                                            ));
                                                      },
                                                      child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                          height: 40,
                                                          alignment: Alignment.bottomCenter,
                                                          transformAlignment: Alignment.bottomCenter,
                                                          child: Image.asset('assets/images/edit.png',alignment: Alignment.center,)),
                                                    ),

                                                    if(userValue!="Admin")
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.10,
                                                            height: 40,
                                                            alignment: Alignment.bottomCenter,
                                                            transformAlignment: Alignment.bottomCenter,
                                                            child: Image.asset('assets/images/location.png',alignment: Alignment.center,)),
                                                      )


                                                  ],
                                                ),
                                                Padding(padding: EdgeInsets.all(10.0),
                                                  child:
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child:
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(checknull(newListingList[index].name!),style: blackHeadStyle,textAlign: TextAlign.left,),
                                                        Text(checknull(newListingList[index].overview!),style: greyChildStyle,),
                                                     //   Text('Flats Covering 1BHK & 2BHK',style: greyChildStyle,)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 30,
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[

                                                Text("AED "+checknull(newListingList[index].value!.toString()),style: greenHeadStyle,),
                                                Text(checknull(newListingList[index].fundedPercentage!)+"% funded",style: blackChildStyle,)
                                              ],
                                            ),
                                          ),

                                          if(checknullzero(double.tryParse(newListingList[index].fundedPercentage!)) != 0)
                                            if(checknullzero(double.tryParse(newListingList[index].fundedPercentage!))! < 100)
                                              Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 2,left: 2),
                                                child:
                                                LinearPercentIndicator(
                                                  animation: true,
                                                  lineHeight: 10.0,
                                                  animationDuration: 500,
                                                  percent: checknullzero(double.tryParse(newListingList[index].fundedPercentage!)!) / 100,
                                                  barRadius: Radius.circular(10),
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  progressColor: Colors.black,
                                                ),
                                              )
                                            else
                                              Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 2,left: 2),
                                                child:
                                                LinearPercentIndicator(
                                                  animation: true,
                                                  lineHeight: 10.0,
                                                  animationDuration: 500,
                                                  percent: 1,
                                                  barRadius: Radius.circular(10),
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  progressColor: Colors.black,
                                                ),
                                              ),

                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.85,
                                            height: 100,
                                            alignment: Alignment.center,
                                            decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                color: backgroundcolor
                                            ),
                                            child:
                                            Column(
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 10.0,bottom: 10.0,top: 10.0,right: 10.0),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Projected Gross Yield',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                                            Text('Tenure',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                                            Text('Project Start date',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                                            Text('Project delivery date',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(checknull(newListingList[index].projectedGrossYield!.toString())+" %",style: blackChildStyle,),
                                                            Text(checknull(newListingList[index].tenure.toString())+" Months",style: blackChildStyle,),
                                                            Text(checknull(newListingList[index].startDate.toString()),style: blackChildStyle,),
                                                            Text(checknull(newListingList[index].deliveryDate.toString()),style: blackChildStyle,),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                  ),
                                    );
                                },
                              ),
                              SizedBox(height: 300,)

                            ]
                        ),
                      )),
                ),
                )
            ),
          ));
  }

   checknull(string){
    if(string != null){
      return string;
    }else{
      return "";
    }
  }
   checknullzero(value){
    if(value != null){
      return value;
    }else{
      return 0;
    }
  }
  }