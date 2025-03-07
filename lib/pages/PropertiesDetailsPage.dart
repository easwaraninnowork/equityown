import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pojo/BookmarkRes.dart';
import 'package:quityown/pojo/PropertyDetailsRes.dart';
import 'package:quityown/pojo/PublishNowRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pojo/InvestNowRes.dart';


class PropertiesDetailsPage extends StatefulWidget{
  String propertyid;
  PropertiesDetailsPage({super.key,required this.propertyid});

  
  @override
  State<PropertiesDetailsPage> createState() => _PropertiesDetailsPage(propertyid);
}

class _PropertiesDetailsPage extends State<PropertiesDetailsPage> with SingleTickerProviderStateMixin{

  String propertyid;
  _PropertiesDetailsPage(this.propertyid);


  static const textfieldColor= const Color(0xfff1f5f9);
  static const backgroundColor= const Color(0xfffffdfd);
  final emailController = TextEditingController();
  final projectTenureController = TextEditingController();
  final projectCompletionDateController = TextEditingController();
  final fundReturnDateController = TextEditingController();
  final initial_investment_amountController = TextEditingController();
  int currentRange = 5000;
  String sliderchangedString = "5000";


  final items = [
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider3.jpeg',fit: BoxFit.fill,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider2.png',fit: BoxFit.fill,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider4.jpeg',fit: BoxFit.fill,)),
    Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
        ),
        child: Image.asset('assets/images/slider5.jpg',fit: BoxFit.fill,)),
  ];

  int _index = 0;
  int index = 0;

  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 0,
      "value": true,
      "title": "Below 500,000 AED",
      "color": Colors.black,
      "txt_color": Colors.white,
    },
    {
      "id": 1,
      "value": false,
      "title": "Above 500,000  ",
      "color": textfieldColor,
      "txt_color": Colors.black,

    }
  ];

int currentIndex = 0;

String navigate_id="";


  //List<Data> itemList = <Data>[];

  late PropertyDetailsRes itemList = PropertyDetailsRes();
  List<FundingLog> fundinglogList = <FundingLog>[];
  List<Amenities> amenitiesList = <Amenities>[];
  List<AmenitiesNearBy> amenities_near_byList = <AmenitiesNearBy>[];
  List<Documents> documentsList = <Documents>[];
  List<SimilarProperties> similarPopertiesList = <SimilarProperties>[];
  String address="";
  String fund_return_date="";
  String tenure="";
  dynamic projected_gross_yield=0;
  String userValue = "";
  int show_in_website = 0;



  void initState(){
    propertiesApi(this.propertyid);
    //print(similarPopertiesList.length);

    //Future.delayed(const Duration(seconds: 3),(){
      super.initState();
  //  });
    gettoken();

    initial_investment_amountController.text = sliderchangedString;

  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userValue = (prefs.getString('user') ?? '');
      print("uservalu "+userValue);
    });
  }


  Future<void> downloadPdf(String url, String name) async {
    // Request storage permission
    if (await Permission.manageExternalStorage.request().isGranted ||
        await Permission.storage.request().isGranted) {
      print("Manage External Storage permission granted");

      // Access the default Downloads folder
      final downloadFolder = Directory("/storage/emulated/0/Download");

      // Ensure the directory exists
      if (!await downloadFolder.exists()) {
        await downloadFolder.create(recursive: true);
      }

      // Set the file path
      final filePath = "${downloadFolder.path}/$name.pdf";

      // Download the file
      Dio dio = Dio();
      try {
        await dio.download(url, filePath);
        print("File downloaded to: $filePath");

        // Show success toast
        Fluttertoast.showToast(
          msg: "PDF downloaded successfully to Downloads",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        print("Error downloading file: $e");

        // Show error toast
        Fluttertoast.showToast(
          msg: "Failed to download PDF",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.red,
          fontSize: 16.0,
        );
      }
    } else {
      print("Permission denied or permanently denied");
      openAppSettings(); // Redirect to settings if needed
    }
  }

  Future<void> requestManageStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      print("Manage External Storage permission granted");
    } else {
      print("Permission denied or permanently denied");
      openAppSettings(); // Redirect to settings if needed
    }
  }
  Future<void> _requestStoragePermission(BuildContext context) async {
    // Check the current permission status
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      // Permission already granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission already granted')),
      );
    } else if (status.isDenied) {
      // Request permission
      PermissionStatus result = await Permission.storage.request();

      print(result);
      if (result.isGranted) {
        // Permission granted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission granted')),
        );
      } else if (result.isPermanentlyDenied) {
        // Permission permanently denied
        openAppSettings(); // Open app settings to enable permission manually
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enable storage permission in settings')),
        );
      } else {
        // Permission denied
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission denied')),
        );
        openAppSettings(); // Open app settings to enable permission manually
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enable storage permission in settings')),
        );
      }
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      openAppSettings(); // Open app settings to enable permission manually
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enable storage permission in settings')),
      );
    }
  }

  void _launchDocument(BuildContext context, String documentUrl) async {
    final Uri url = Uri.parse(Uri.encodeFull(documentUrl));

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching document: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open document: $e')),
      );
    }
  }



  propertiesApi(propertyid) async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "per_page": "100"
    };
   // print(queryParameters);
    String apiUrl = userproperDetailsApi+"/"+propertyid;
    String response = await apiHelper.callApiWithTokenGet(apiUrl,queryParameters);
    //print("response "+response);


    //if(response != "Error")
  //  {
    PropertyDetailsRes res = PropertyDetailsRes.fromJson(json.decode(response));
      setState(() {
        //cartQty = totalQty.toString();
        itemList = res;
        address = res.result!.address!;
        fund_return_date = res.result!.fundReturnDate!;
        tenure = res.result!.tenure!.toString();
        projected_gross_yield = res.result!.projectedGrossYield!;
        show_in_website = res.result!.showInWebsite!;
        fundinglogList = res.result!.fundingLog!;
        amenitiesList = res.result!.amenities!;
        amenities_near_byList = res.result!.amenitiesNearBy!;
        documentsList = res.result!.documents!;
        similarPopertiesList = res.result!.similarProperties!;
      });
   // }
  }

  investnowApi(propertyid,expected_closing_date,expected_rate_of_return) async{

    ApiHelper apiHelper = ApiHelper(context);
    var exepected_return = (projected_gross_yield/currentRange)*100;
    print(currentRange);
    if(currentRange <= 5000){
      DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(expected_closing_date);
      String formattedDateString = DateFormat('dd/MM/yyyy').format(formattedDate);

      print(formattedDateString);

      final queryParameters = {
        "expected_closing_date": formattedDateString.toString(),
        "expected_rate_of_return": this.projected_gross_yield.toString(),
        "expected_return": exepected_return.toString(),
        "investment": initial_investment_amountController.text,
      };
       print(queryParameters);
      String apiUrl = investNowApi+"/"+propertyid;
      String response = await apiHelper.callApiWithToken(apiUrl,queryParameters);
      print("response "+response);
      String address="";

      //if(response != "Error")
      //  {
      InvestnowRes res = InvestnowRes.fromJson(json.decode(response));
      setState(() {
        //cartQty = totalQty.toString();
        //  investItemList = res.result! as InvestNowRes;

        print(res.message);
        Fluttertoast.showToast(
          msg: res.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );

        Navigator.pushReplacement(context, MaterialPageRoute(builder:
            (context)=>
            HomeScreen(pageIndex :0)
        )
        );

        /* fundinglogList = res.result!.fundingLog!;
      amenitiesList = res.result!.amenities!;
      amenities_near_byList = res.result!.amenitiesNearBy!;
      documentsList = res.result!.documents!;
      similarPopertiesList = res.result!.similarProperties!;*/

      });
      // }
    }else{
      Fluttertoast.showToast(
        msg: "Your amount is more 5000 AED.So Please invest within 5000AED",
        toastLength: Toast.LENGTH_SHORT,
      );
    }

  }
  publishnowApi() async{
    ApiHelper apiHelper = ApiHelper(context);


      final queryParameters = {
        "show_in_website" : "1"
      };
       print(queryParameters);
      String apiUrl = publishNowApi+"/"+propertyid;
      String response = await apiHelper.callApiWithTokenPut(apiUrl,queryParameters);
      print("response "+response);
      String address="";

      //if(response != "Error")
      //  {
      PublishNowRes res = PublishNowRes.fromJson(json.decode(response));
      setState(() {
        //cartQty = totalQty.toString();
        //  investItemList = res.result! as InvestNowRes;

        print(res.message);
        Fluttertoast.showToast(
          msg: res.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );

        Navigator.pushReplacement(context, MaterialPageRoute(builder:
            (context)=>
            HomeScreen(pageIndex :0)
        )
        );

        /* fundinglogList = res.result!.fundingLog!;
      amenitiesList = res.result!.amenities!;
      amenities_near_byList = res.result!.amenitiesNearBy!;
      documentsList = res.result!.documents!;
      similarPopertiesList = res.result!.similarProperties!;*/

      });
      // }


  }

  bookmarkApi(propertyid) async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
    };
    // print(queryParameters);
    String apiUrl = bookMarkApi+"/"+propertyid;
    String response = await apiHelper.callApiWithTokenNoBody(apiUrl);
    print("response "+response);
    String address="";

    //if(response != "Error")
    //  {
    BookmarkRes res = BookmarkRes.fromJson(json.decode(response));
    setState(() {
      //cartQty = totalQty.toString();
      //  investItemList = res.result! as InvestNowRes;

     // print(res.message);
      Fluttertoast.showToast(
          msg: res.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      initState();
      /* fundinglogList = res.result!.fundingLog!;
      amenitiesList = res.result!.amenities!;
      amenities_near_byList = res.result!.amenitiesNearBy!;
      documentsList = res.result!.documents!;
      similarPopertiesList = res.result!.similarProperties!;*/

    });
    // }
  }
  bookmarkRemoveApi(propertyid) async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
    };
    // print(queryParameters);
    String apiUrl = bookmarkRemove +"/"+propertyid;
    String response = await apiHelper.callApiWithTokenNoBody(apiUrl);
    print("response "+response);
    String address="";

    //if(response != "Error")
    //  {
    BookmarkRes res = BookmarkRes.fromJson(json.decode(response));
    setState(() {
      //cartQty = totalQty.toString();
      //  investItemList = res.result! as InvestNowRes;

     // print(res.message);
      Fluttertoast.showToast(
          msg: res.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );

      initState();

      /* fundinglogList = res.result!.fundingLog!;
      amenitiesList = res.result!.amenities!;
      amenities_near_byList = res.result!.amenitiesNearBy!;
      documentsList = res.result!.documents!;
      similarPopertiesList = res.result!.similarProperties!;*/

    });
    // }
  }

  void _handleSubmitted(String value) {
    sliderchangedString = value;
    currentRange = int.parse(value);
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure to logout this application'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                //Navigator.of(context).pop(); // Dismiss the dialog
                // Do something when OK is pressed
              },
            ),
          ],
        );
      },
    );
  }






  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: backgroundColor,
          body:SafeArea(
            child:
            SingleChildScrollView(
                child:
                Container(child: () {
                  if (itemList.result == null) {
                    return Center(child: Text("Loading please wait",textAlign: TextAlign.center,),);
                  }else
                  {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: backgroundColor
                      ),
                      child:
                      Column(
                          children:
                          <Widget>
                          [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children:
                                          [
/*                                        CarouselSlider(
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
                                        )*/


                                            if(itemList.result!.images!.length != 0)
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
                                              items: itemList.result!.images?.map(
                                                      (item) =>Container(
                                                      width: double.infinity,
                                                      height: 300,
                                                      decoration: BoxDecoration(
                                                        color: backgroundColor,
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
                                            if(itemList.result!.images!.length == 0)
                                              Container(
                                                  width: double.infinity,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                                                  ),
                                                  child: Image.asset('assets/images/slider2.png',fit: BoxFit.cover))
                                            /* Padding(
                                          padding: const EdgeInsets.only(bottom: 20.0),
                                          child: DotsIndicator(
                                            decorator: DotsDecorator(
                                              color: Colors.white,
                                            ),
                                            dotsCount: itemList.images!.length,
                                            position: currentIndex.toDouble(),
                                          ),
                                        ),*/
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          padding: EdgeInsets.all(5.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () => Navigator.of(context).pop(),
                                                child: Image.asset('assets/images/back_image_round.png',width: 30,height: 30,),
                                              ),
                                              Row(
                                                children: [
                                                  if(itemList.result!.bookmark == 0)
                                                  InkWell(
                                                    onTap: () {
                                                      bookmarkApi(propertyid);
                                                      },
                                                    child: Image.asset('assets/images/flag_round.png',width: 30,height: 30,),
                                                  ),

                                                  if(itemList.result!.bookmark == 1)
                                                    InkWell(
                                                    onTap: () {
                                                      bookmarkRemoveApi(propertyid);
                                                      },
                                                    child: Image.asset('assets/images/bookmark.png',width: 30,height: 30,),
                                                  ),
                                                  SizedBox(width: 15,),
                                                  InkWell(
                                                    onTap: () {
                                                      // Share text
                                                      Share.share("https://equityown.com/property-details/"+itemList.result!.id.toString());

                                                      // Share text with subject (optional)
                                                      // Share.share('Check out my website https://example.com', subject: 'Look what I made!');
                                                    },
                                                    child: Image.asset('assets/images/share_round.png',width: 30,height: 30,),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Padding(padding: EdgeInsets.all(10.0),
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Image.asset("assets/images/project_overview.png"),
                                                  SizedBox(width: 10,),
                                                  Text('Project overview',style: blackHeadStyle,)
                                                ],
                                              )),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Text(checknull(itemList.result!.overview),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),)),
                                          Padding(padding: EdgeInsets.all(10.0),
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Image.asset('assets/images/project_overview.png'),
                                                  SizedBox(width: 10,),
                                                  Text('Project Details',style: blackHeadStyle,)
                                                ],
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0,top: 8.0,right: 8.0,bottom: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.50,
                                                      child: Text('Project Gross Yield',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 13),),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                      child: Text(checknull(itemList.result!.projectedGrossYield.toString()),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.50,
                                                      child: Text('Tenure',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 13),),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                      child: Text(checknull(itemList.result!.tenure.toString())+" months",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.50,
                                                      child: Text('Project start date ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 13),),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                      child: Text(checknull(itemList.result!.startDate.toString()),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.50,
                                                      child: Text('Project delivery date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 13),),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                      child: Text(checknull(itemList.result!.deliveryDate.toString()),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.50,
                                                      child: Text('%Annual Return',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 13),),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                      child: Text(checknull(itemList.result!.annualReturn.toString()+"% (approx)"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                                                color: backgroundColor,
                                                border: Border.all(color: Colors.grey,width: 1.0)
                                            ),
                                            child:
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(padding: EdgeInsets.all(8.0),
                                                      child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Image.asset('assets/images/calculator.png'),
                                                          SizedBox(width: 10,),
                                                          Text('Investment calculator',style: blackHeadStyle,),
                                                        ],
                                                      )),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.only(top : 3.0,bottom : 10,left : 5,right : 5),
                                                        child: Text('Select Amount (Investment)',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Row(
                                                    children: List.generate(checkListItems.length, (index) =>
                                                        Expanded(child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            color: checkListItems[index]["color"],
                                                          ),

                                                          child: CheckboxListTile(
                                                            controlAffinity: ListTileControlAffinity.leading,
                                                            contentPadding: EdgeInsets.zero,
                                                            dense: true,
                                                            title: Text(
                                                              checkListItems[index]["title"],
                                                              style:  TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: checkListItems[index]["txt_color"]
                                                              ),
                                                            ),
                                                            value: checkListItems[index]["value"],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                checkListItems[index]["value"] = value;
                                                                if (multipleSelected.contains(checkListItems[index])) {
                                                                  multipleSelected.remove(checkListItems[index]);
                                                                } else {
                                                                  multipleSelected.add(checkListItems[index]);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        )),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            height: 40,
                                                            child: Text('Project Tenure',style: blackChildStyle,)),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:
                                                          Text(tenure,style: blackChildStyle,)
                                                          /*TextField(
                                                            controller: projectTenureController,
                                                            decoration: InputDecoration(
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                              ),
                                                              hintText: '20 months',
                                                              hintStyle: TextStyle(fontSize: 12),
                                                            ),

                                                          )*/,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            height: 40,
                                                            child: Text('Project completion date',style: blackChildStyle,)),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:Text(fund_return_date.toString(),style: blackChildStyle,)
                                                          /*TextField(
                                                            controller: projectCompletionDateController,
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                ),
                                                                hintText: '01/Nov/2025',
                                                                hintStyle: TextStyle(fontSize: 12)
                                                            ),
                                                          )*/,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment:  CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            height: 40,
                                                            child: Text('Fund return date',style: blackChildStyle,)),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:Text(fund_return_date,style: blackChildStyle,)
                                                          /*TextField(
                                                            controller: fundReturnDateController,
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey, width: .0),
                                                                ),
                                                                hintText: '01/Jan/2026',
                                                                hintStyle: TextStyle(fontSize: 12)
                                                            ),
                                                          )*/,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 30,
                                                    margin: EdgeInsets.only(left: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('Initial investment (AED)',style: blackChildStyle,),
/*
                                                        Text(sliderchangedString,style: greenHeadStyle,),
*/
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:
                                                          TextField(
                                                            controller: initial_investment_amountController,
                                                            onSubmitted: (String value){
                                                              _handleSubmitted(value);
                                                            },
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey, width: .0),
                                                                ),
                                                                hintText: sliderchangedString,
                                                                hintStyle: TextStyle(fontSize: 12)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
/*
                                              Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 2,left: 2),
                                                child:
                                                LinearPercentIndicator(
                                                  animation: true,
                                                  lineHeight: 10.0,
                                                  animationDuration: 500,
                                                  percent: 0.9,
                                                  barRadius: Radius.circular(10),
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  progressColor: Colors.black,
                                                ),
                                              ),
*/
                                                  Slider(
                                                    value: currentRange.toDouble(),
                                                    min : 0,
                                                    max : 1000000,
                                                    activeColor: Colors.black,
                                                    onChanged:   (double value) {
                                                      setState(() {
                                                        currentRange = value.toInt();
                                                        sliderchangedString = currentRange.toString() + " AED";
                                                        initial_investment_amountController.text = currentRange.toString();

                                                      });
                                                    },
                                                  ),

                                                  /*Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          height: 40,
                                          child: Text('Initial investment',style: blackHeadStyle,)),
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.30,
                                          height: 40,
                                          child: Text('500,000 AED',style: greenHeadStyle,)),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(5.0),
                                      child:
                                      LinearProgressIndicator(
                                        minHeight: 8,
                                        backgroundColor: Colors.white,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black,),
                                        value: 0.8,
                                      )),*/
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            child: Text('Expected annual yield',style: blackChildStyle,)),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:Text(projected_gross_yield.toString(),style: blackChildStyle,)
                                                          /*TextField(
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                ),
                                                                hintText: itemList.result!.annualReturn.toString()+" %",
                                                                hintStyle: TextStyle(fontSize: 12)
                                                            ),
                                                          )*/,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                 /* Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            child: Text('Management fee',style: blackChildStyle,)),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          height: 40,
                                                          child:
                                                          TextField(
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                                ),
                                                                hintText: '2 %',
                                                                hintStyle: TextStyle(fontSize: 12)
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: backgroundColor,
                                                border: Border.all(color: Colors.grey,width: 1.0)
                                            ),
                                            child:
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Padding(padding: EdgeInsets.all(10.0),
                                                      child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Image.asset('assets/images/calculator.png'),
                                                          SizedBox(width: 10,),
                                                          Text('Financials',style: blackHeadStyle,),
                                                        ],
                                                      )),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text('Property cost',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text(itemList.result!.value.toString()+" AED",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text('Property delivery date (exp)',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text(itemList.result!.deliveryDate.toString(),
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text('Fund return date (exp)',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text(itemList.result!.fundReturnDate.toString(),
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text('Rate of return',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text(itemList.result!.rateOfReturn.toString()+" %",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text('Expected total fund return',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text(itemList.result!.expectedTotalFundReturn.toString()+" AED",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text('Expected gain',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.grey,fontSize: 13),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  Align(
                                                    child: Padding(padding: EdgeInsets.all(3.0),
                                                        child: Text(itemList.result!.expectedGain.toString()+" AED",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 15,),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: backgroundColor,
                                                border: Border.all(color: Colors.grey,width: 1.0)
                                            ),
                                            child:
                                            Column(
                                              children: [
                                                Padding(padding: EdgeInsets.all(10.0),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset('assets/images/funding_timeline.png'),
                                                        SizedBox(width: 10,),
                                                        Text('Funding Timeline',style: blackHeadStyle,),
                                                      ],
                                                    )),
                                                SizedBox(height: 10,),
                                                ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  scrollDirection: Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: fundinglogList!.length,
                                                  itemBuilder: (BuildContext context, int index){
                                                    return Padding(
                                                      padding: EdgeInsets.only(left: 30.0,top: 20.0,right: 20.0,bottom: 10.0),
                                                      child: Column(
                                                          children: [
                                                            if (index == 0)
                                                              TimelineTile(
                                                                alignment: TimelineAlign.center,
                                                                isFirst: true,
                                                                indicatorStyle: const IndicatorStyle(
                                                                  width: 15,
                                                                  color: Colors.greenAccent,
                                                                  indicatorXY: 0.2,
                                                                  padding: EdgeInsets.all(8),
                                                                ),
                                                                endChild: Container(
                                                                  constraints: const BoxConstraints(
                                                                      minHeight: 80
                                                                  ),
                                                                  child: Text(fundinglogList[index].description.toString()),
                                                                ),
                                                                startChild: Container(
                                                                  constraints: const BoxConstraints(
                                                                      minHeight: 80
                                                                  ),
                                                                  child: Text(fundinglogList[index].date.toString()),
                                                                ),
                                                              ),
                                                            if(index != 0 && index != fundinglogList.length-1)
                                                              TimelineTile(
                                                                alignment: TimelineAlign.center,
                                                                indicatorStyle: const IndicatorStyle(
                                                                  width: 15,
                                                                  color: Colors.grey,
                                                                  indicatorXY: 0.2,
                                                                  padding: EdgeInsets.all(8),
                                                                ),
                                                                endChild: Container(
                                                                  constraints: const BoxConstraints(
                                                                      minHeight: 80
                                                                  ),
                                                                  child: Text(fundinglogList[index].description.toString()),
                                                                ),
                                                                startChild: Container(
                                                                  constraints: const BoxConstraints(
                                                                      minHeight: 80
                                                                  ),
                                                                  child: Text(fundinglogList[index].date.toString()),
                                                                ),
                                                              ),
                                                            if(index == fundinglogList.length-1)
                                                              TimelineTile(
                                                                alignment: TimelineAlign.center,
                                                                isLast: true,
                                                                indicatorStyle: const IndicatorStyle(
                                                                  width: 15,
                                                                  color: Colors.grey,
                                                                  indicatorXY: 0.2,
                                                                  padding: EdgeInsets.all(8),
                                                                ),
                                                                endChild: Container(
                                                                  constraints: const BoxConstraints(
                                                                      minHeight: 80
                                                                  ),
                                                                  child: Text(fundinglogList[index].description.toString()),
                                                                ),
                                                                startChild: Container(
                                                                  constraints: const BoxConstraints(
                                                                      minHeight: 80
                                                                  ),
                                                                  child: Text(fundinglogList[index].date.toString()),
                                                                ),
                                                              ),

                                                          ]
                                                      ),
                                                    );
                                                  },
                                                ),
                                                /*Padding(
                                              padding: EdgeInsets.only(left: 30.0,top: 20.0,right: 20.0,bottom: 20.0),
                                              child: Column(
                                                children: [
                                                  TimelineTile(
                                                    alignment: TimelineAlign.center,
                                                    isFirst: true,
                                                    indicatorStyle: const IndicatorStyle(
                                                      width: 15,
                                                      color: Colors.greenAccent,
                                                      indicatorXY: 0.2,
                                                      padding: EdgeInsets.all(8),
                                                    ),
                                                    endChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('Project Announced'),
                                                    ),
                                                    startChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('10/Aug/2023'),
                                                    ),
                                                  ),
                                                  TimelineTile(
                                                    alignment: TimelineAlign.center,
                                                    indicatorStyle: const IndicatorStyle(
                                                      width: 15,
                                                      color: Colors.grey,
                                                      indicatorXY: 0.2,
                                                      padding: EdgeInsets.all(8),
                                                    ),
                                                    endChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('Fund started'),
                                                    ),
                                                    startChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('28/Feb/2024'),
                                                    ),
                                                  ),
                                                  TimelineTile(
                                                    alignment: TimelineAlign.center,
                                                    indicatorStyle: const IndicatorStyle(
                                                      width: 15,
                                                      color: Colors.grey,
                                                      indicatorXY: 0.2,
                                                      padding: EdgeInsets.all(8),
                                                    ),

                                                    endChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('Fund completion'),
                                                    ),
                                                    startChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('10/Mar/2023'),
                                                    ),
                                                  ),
                                                  TimelineTile(
                                                    alignment: TimelineAlign.center,
                                                    isLast: true,
                                                    indicatorStyle: const IndicatorStyle(
                                                      width: 15,
                                                      color: Colors.grey,
                                                      indicatorXY: 0.2,
                                                      padding: EdgeInsets.all(8),
                                                    ),
                                                    endChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('Fund return date'),
                                                    ),
                                                    startChild: Container(
                                                      constraints: const BoxConstraints(
                                                          minHeight: 80
                                                      ),
                                                      child: Text('10/Nov/2025'),
                                                    ),
                                                  ),
                                                ],
                                              ),)*/
                                              ],
                                            )
                                            ,),
                                          Container(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20,),
                                                Padding(padding: EdgeInsets.all(10.0),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset('assets/images/project_overview.png'),
                                                        SizedBox(width: 10,),
                                                        Text('Project details',style: blackHeadStyle,),
                                                      ],
                                                    )),
                                                Padding(padding: EdgeInsets.only(left: 10,top: 5,right: 5,bottom: 10),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.location_on),
                                                        SizedBox(width: 8,),
                                                        Text(itemList.result!.address.toString(),style: blackChildStyle,),
                                                        SizedBox(width: 10,),
                                                      ],
                                                    )),
                                                Image.asset('assets/images/pro_location.png'),
                                                SizedBox(height: 20,),
                                                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Text(itemList.result!.projectDetails.toString(),
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),)),
                                                SizedBox(height: 20,),

                                                Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Image.asset('assets/images/home.png'),
                                                            SizedBox(width: 10,),
                                                            Text('Amenities',style: greenHeadStyle,),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        if(amenitiesList.length != 0)
                                                          Container(
                                            width: double.infinity,
                                            height : 50,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: amenitiesList.map((amenety){
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    if(amenety.name! == 'Gym')
                                                      Image.asset('assets/images/gym.png'),

                                                    if(amenety.name! == 'Shop')
                                                      Image.asset('assets/images/home_02.png'),

                                                    if(amenety.name! == 'Pool')
                                                      Image.asset('assets/images/pool.png'),

                                                    SizedBox(width: 4,),
                                                    Text(amenety.name!,style: greyChildStyle,),
                                                    SizedBox(width: 40,),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          )
                                                        else
                                                          Center(
                                                            child: Text("No amenities"),
                                                          ),

                                                        /*Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(padding: EdgeInsets.all(2.0),
                                                            child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset('assets/images/gym.png'),
                                                                SizedBox(width: 4,),
                                                                Text('Gym',style: greyChildStyle,),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            )),
                                                        Padding(padding: EdgeInsets.all(2.0),
                                                            child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset('assets/images/home_02.png'),
                                                                SizedBox(width: 4,),
                                                                Text('Shop',style: greyChildStyle,),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            )),
                                                        Padding(padding: EdgeInsets.all(2.0),
                                                            child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset('assets/images/pool.png'),
                                                                SizedBox(width: 4,),
                                                                Text('Pool',style: greyChildStyle,),
                                                                SizedBox(width: 10,),
                                                              ],
                                                            )),
                                                      ],
                                                    )*/
                                                      ],
                                                    ),
                                                  ),
                                                ),



                                                Padding(padding: EdgeInsets.all(2.0),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset('assets/images/location_01.png'),
                                                        SizedBox(width: 10,),
                                                        Text('Amenities near by',style: greenHeadStyle,),

                                                      ],
                                                    )),
                                                SizedBox(height: 15,),
                                                if(amenities_near_byList.length != 0)
                                                Container(
                                                  width: double.infinity,
                                                  height : MediaQuery.of(context).size.height*0.18,
                                                  child: ListView(
                                                    scrollDirection: Axis.vertical,
                                                    children: amenities_near_byList.map((amenety){
                                                      return
                                                        Padding(padding: EdgeInsets.all(2.0),
                                                            child:
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(". "+amenety.description.toString(),style: greyChildStyle,textAlign: TextAlign.start,),
                                                                SizedBox(height: 10,),
                                                              ],
                                                            ));
                                                    }).toList(),
                                                  ),
                                                )
                                                else
                                                  Center(
                                                    child: Text("No amenities near by found"),
                                                  ),


                                                /*Padding(padding: EdgeInsets.all(2.0),
                                                child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('. 2 schools within 5km proximity',style: greyChildStyle,textAlign: TextAlign.start,),
                                                    SizedBox(height: 10,),
                                                    Text('. 3 supermarkets within 5km proximity',style: greyChildStyle,textAlign: TextAlign.start),
                                                    SizedBox(height: 10,),
                                                    Text('. Mall of the emirates at 15 minutes drive',style: greyChildStyle,textAlign: TextAlign.start),
                                                    SizedBox(height: 10,),
                                                    Text('. Dubai mall & Dubai downtown within 25 minutes dates',style: greyChildStyle,textAlign: TextAlign.start),
                                                    SizedBox(height: 10,),
                                                    Text('. Dubai international Airport within 40 min drive',style: greyChildStyle,textAlign: TextAlign.start),
                                                    SizedBox(height: 10,),
                                                  ],
                                                )),*/
                                                SizedBox(height: 20,),

                                                Column(
                                                  children: [
                                                    Padding(padding: EdgeInsets.all(10.0),
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Image.asset('assets/images/funding_timeline.png'),
                                                            SizedBox(width: 10,),
                                                            Text('Project Timeline',style: blackHeadStyle,),
                                                          ],
                                                        )),
                                                    SizedBox(height: 10,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 30.0,top: 20.0,right: 20.0,bottom: 20.0),
                                                      child: Column(
                                                        children: [
                                                          TimelineTile(
                                                            alignment: TimelineAlign.center,
                                                            isFirst: true,
                                                            indicatorStyle: const IndicatorStyle(
                                                              width: 15,
                                                              color: Colors.greenAccent,
                                                              indicatorXY: 0.2,
                                                              padding: EdgeInsets.all(8),
                                                            ),
                                                            endChild: Container(
                                                              constraints: const BoxConstraints(
                                                                  minHeight: 80
                                                              ),
                                                              child: Text('Project start date'),
                                                            ),
                                                            startChild: Container(
                                                                constraints: const BoxConstraints(
                                                                    minHeight: 80
                                                                ),
                                                                child: Text(itemList.result!.startDate.toString())),
                                                          ),
                                                          TimelineTile(
                                                            alignment: TimelineAlign.center,
                                                            isLast: true,
                                                            indicatorStyle: const IndicatorStyle(
                                                              width: 15,
                                                              color: Colors.grey,
                                                              indicatorXY: 0.2,
                                                              padding: EdgeInsets.all(8),
                                                            ),
                                                            endChild: Container(
                                                              constraints: const BoxConstraints(
                                                                  minHeight: 80
                                                              ),
                                                              child: Text('Delivery date'),
                                                            ),
                                                            startChild: Container(
                                                              constraints: const BoxConstraints(
                                                                  minHeight: 80
                                                              ),
                                                              child: Text(itemList.result!.deliveryDate.toString()),
                                                            ),
                                                          ),
                                                        ],
                                                      ),)
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Padding(padding: EdgeInsets.all(10.0),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset('assets/images/document.png'),
                                                        SizedBox(width: 10,),
                                                        Text('Project documents',style: blackHeadStyle,),
                                                      ],
                                                    )),
                                                if(documentsList.length != 0)
                                                Container(
                                                  width: double.infinity,
                                                  height : 50,
                                                  child: ListView(
                                                    scrollDirection: Axis.horizontal,
                                                    children: documentsList.map((document){
                                                      return
                                                        InkWell(
                                                          onTap: () async {
                                                            await downloadPdf(document.path!,document.name!);
                                                            //_launchDocument(context,document.path!);
                                                          },
                                                          child: Padding(padding: EdgeInsets.all(2.0),
                                                              child:
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 40,
                                                                    alignment: Alignment.center,
                                                                    decoration: new BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                        color: Colors.white12,
                                                                        border: Border.all(color: Colors.grey,width: 1.0)
                                                                    ),
                                                                    child:
                                                                    Padding(padding: EdgeInsets.all(2.0),
                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: [
                                                                            Icon(Icons.file_download_outlined),
                                                                            SizedBox(width: 4,),
                                                                            Text(document.name.toString(),style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),
                                                                            SizedBox(width: 10,),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                  SizedBox(width: 10,)
                                                                ],
                                                              )),
                                                        );
                                                    }).toList(),
                                                  ),
                                                )
                                                else
                                                  Center(
                                                    child: Text("No documents"),
                                                  ),

/*
                                            Padding(padding: EdgeInsets.all(2.0),
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.30,
                                                      height: 40,
                                                      alignment: Alignment.center,
                                                      decoration: new BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                          color: Colors.white12,
                                                          border: Border.all(color: Colors.grey,width: 1.0)
                                                      ),
                                                      child:
                                                      Padding(padding: EdgeInsets.all(2.0),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.file_download_outlined),
                                                              SizedBox(width: 4,),
                                                              Text('Project plan',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.30,
                                                      height: 40,
                                                      alignment: Alignment.center,
                                                      decoration: new BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                          color: Colors.white12,
                                                          border: Border.all(color: Colors.grey,width: 1.0)
                                                      ),
                                                      child:
                                                      Padding(padding: EdgeInsets.all(2.0),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.file_download_outlined),
                                                              SizedBox(width: 4,),
                                                              Text('Delivery plan',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.30,
                                                      height: 40,
                                                      alignment: Alignment.center,
                                                      decoration: new BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                          color: Colors.white12,
                                                          border: Border.all(color: Colors.grey,width: 1.0)
                                                      ),
                                                      child:
                                                      Padding(padding: EdgeInsets.all(2.0),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.file_download_outlined),
                                                              SizedBox(width: 4,),
                                                              Text('Risk assesment',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                )),
*/
                                                SizedBox(height: 20,),
                                                if(userValue != "Admin")
                                                MyTextButton(buttonName: 'INVEST NOW !', onTap: ()
                                                {
                                                  investnowApi(this.propertyid,this.fund_return_date,currentRange);

                                                  /*Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => PortfolioPage([], animate: false)));*/
                                                }, bgColor: Colors.black, textColor: Colors.white),

                                                if(userValue == "Admin" && show_in_website == 0)
                                                MyTextButton(buttonName: 'Publish Now !', onTap: ()
                                                {
                                                  publishnowApi();

                                                  /*Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => PortfolioPage([], animate: false)));*/
                                                }, bgColor: Colors.black, textColor: Colors.white),

                                                if(userValue == "Admin" && show_in_website ==1)
                                                  MyTextButton(buttonName: 'Publish Now !', onTap: ()
                                                  {
                                                    Fluttertoast.showToast(
                                                      msg: "This property is already published",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                    );
                                                   // publishnowApi();
                                                  //  investnowApi(this.propertyid,this.fund_return_date,currentRange);

                                                    /*Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => PortfolioPage([], animate: false)));*/
                                                  }, bgColor: Colors.grey, textColor: Colors.white),
                                                SizedBox(height: 20,),

                                                Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height*0.65,
                                                    alignment: Alignment.center,
                                                    decoration: new BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                        color: backgroundColor,
                                                        border: Border.all(color: Colors.grey,width: 1.0)
                                                    ),
                                                    child:
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20.0,top: 15.0,bottom: 8.0),
                                                          child: Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text('Similar projects',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                                          ),
                                                        ),
                                                        ListView.builder(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: similarPopertiesList.length,
                                                          itemBuilder: (BuildContext context, int index){
                                                            return
                                                              GestureDetector(
                                                                onTap: () => {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => PropertiesDetailsPage(propertyid : similarPopertiesList[index].id.toString()),
                                                                      ))
                                                                },
                                                                child:
                                                                Padding(padding: EdgeInsets.all(10.0),
                                                                    child:
                                                                    Column(
                                                                        children:
                                                                        <Widget>
                                                                        [
                                                                          Column(
                                                                            children: [
                                                                              Stack(
                                                                                alignment: Alignment.bottomCenter,
                                                                                children: [


                                                                                  if(similarPopertiesList[index].images?.length != 0)
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
                                                                                    items: similarPopertiesList[index].images?.map(
                                                                                            (item) =>Container(
                                                                                            width: double.infinity,
                                                                                            height: 300,
                                                                                            decoration: BoxDecoration(
                                                                                              color: backgroundColor,
                                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                                                                                            ),
                                                                                            child: Image.network(item.path!,fit: BoxFit.cover))
                                                                                    ).toList(),
                                                                                  ),
                                                                                  if(similarPopertiesList[index].images?.length == 0)
                                                                                    Container(
                                                                                        width: double.infinity,
                                                                                        height: 180,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                                                                                        ),
                                                                                        child: Image.asset('assets/images/slider2.png',fit: BoxFit.cover))
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

                                                                          Column(
                                                                            children: [
                                                                              /*Row(
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
                                                                              hintText: 'Sellur madurai , tamilnadu',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              filled: true,
                                                                              fillColor: textfieldColor
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
                                                                  ),*/
                                                                              Padding(padding: EdgeInsets.all(10.0),
                                                                                child:
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child:
                                                                                  Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(similarPopertiesList[index].name!,style: blackHeadStyle,textAlign: TextAlign.left,),
                                                                                      Text(similarPopertiesList[index].address!,style: greyChildStyle,),
                                                                                      Text(similarPopertiesList[index].overview!,style: greyChildStyle,)
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Container(
                                                                            width: double.infinity,
                                                                            height: 30,
                                                                            margin: EdgeInsets.only(left: 10),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("AED "+similarPopertiesList[index].value.toString(),style: greenHeadStyle,),
                                                                                Text(similarPopertiesList[index].fundedPercentage!+" funded",style: blackChildStyle,)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 2,left: 2),
                                                                            child:
                                                                            LinearPercentIndicator(
                                                                              animation: true,
                                                                              lineHeight: 10.0,
                                                                              animationDuration: 500,
                                                                              percent: 0.9,
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
                                                                                color: textfieldColor
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                              children: [
                                                                                Padding(padding: EdgeInsets.all(10.0),
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
                                                                                            Text(checknull(similarPopertiesList[index].projectedGrossYield.toString()),style: blackChildStyle,),
                                                                                            Text(checknull(similarPopertiesList[index].tenure.toString()),style: blackChildStyle,),
                                                                                            Text(checknull(similarPopertiesList[index].startDate),style: blackChildStyle,),
                                                                                            Text(checknull(similarPopertiesList[index].deliveryDate),style: blackChildStyle,),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                ),

                                                                              ],
                                                                            ),
                                                                          ),

                                                                        ]
                                                                    )),
                                                              );
                                                          },
                                                        ),
/*
                                                    Padding(padding: EdgeInsets.all(10.0),
                                                        child:
                                                        Column(
                                                            children:
                                                            <Widget>
                                                            [
                                                              Column(
                                                                children: [
                                                                  Stack(
                                                                    alignment: Alignment.bottomCenter,
                                                                    children: [

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
                                                                        items: items,
                                                                      ),
                                                                      */
/*DotsIndicator(
                                                                        decorator: DotsDecorator(
                                                                          color: Colors.white,
                                                                        ),
                                                                        dotsCount: items.length,
                                                                        position: currentIndex.toDouble(),
                                                                      ),*//*

                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                              Column(
                                                                children: [
                                                                  */
/*Row(
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
                                                                              hintText: 'Sellur madurai , tamilnadu',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              filled: true,
                                                                              fillColor: textfieldColor
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
                                                                  ),*//*

                                                                  Padding(padding: EdgeInsets.all(10.0),
                                                                    child:
                                                                    Align(
                                                                      alignment: Alignment.topLeft,
                                                                      child:
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text('Wave Tower',style: blackHeadStyle,textAlign: TextAlign.left,),
                                                                          Text('24 Floor Building With 200 ',style: greyChildStyle,),
                                                                          Text('Flats Covering Studio 1BHK & 2BHK',style: greyChildStyle,)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 30,
                                                                margin: EdgeInsets.only(left: 10),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text('AED 100,000,000',style: greenHeadStyle,),
                                                                    Text('10% Funded',style: blackChildStyle,)
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 2,left: 2),
                                                                child:
                                                                LinearPercentIndicator(
                                                                  animation: true,
                                                                  lineHeight: 10.0,
                                                                  animationDuration: 500,
                                                                  percent: 0.9,
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
                                                                    color: textfieldColor
                                                                ),
                                                                child:
                                                                Column(
                                                                  children: [
                                                                    Padding(padding: EdgeInsets.all(10.0),
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
                                                                                Text(checknull(itemList.projectedGrossYield.toString()),style: blackChildStyle,),
                                                                                Text(checknull(itemList.tenure.toString()),style: blackChildStyle,),
                                                                                Text(checknull(itemList.startDate),style: blackChildStyle,),
                                                                                Text(checknull(itemList.deliveryDate),style: blackChildStyle,),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        )
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),

                                                            ]
                                                        )),
*/
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  top: 180.0,
                                  child:
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    height: 130,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        color: Colors.white
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child:
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 280,
                                                      height: 44,
                                                      child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(child: Text(checknull(itemList.result!.name),style: blackHeadStyle,)),
                                                          Image.asset('assets/images/location.png')
                                                        ],
                                                      ),
                                                    ),
                                                    Text(checknull(itemList.result!.code),style: TextStyle(color: Colors.black,fontSize: 11),),
                                                    Text('Project value',style: TextStyle(color: Colors.black,fontSize: 14),),
                                                    Container(
                                                      width: 280,
                                                      height: 30,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("AED "+checknullzero(itemList.result!.value.toString()),style: greenHeadStyle,),
                                                          InkWell(
                                                            onTap: (){
                                                              Fluttertoast.showToast(
                                                                msg: "There is no function for this section.It just a image",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.CENTER,
                                                                timeInSecForIosWeb: 1,
                                                                fontSize: 16.0,
                                                              );
                                                            },
                                                            child: Icon(Icons.arrow_circle_left_rounded))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                /* Padding(padding: EdgeInsets.all(10.0),
                                            child:Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(':',style: greyChildStyle,),
                                                Text(':',style: greyChildStyle,),
                                                Text(':',style: greyChildStyle,),
                                                Text(':',style: greyChildStyle,),
                                              ],
                                            )),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('22%',style: blackChildStyle,),
                                            Text('20 months',style: blackChildStyle,),
                                            Text('01/Mar/2024',style: blackChildStyle,),
                                            Text('01/Nov/2024',style: blackChildStyle,),
                                          ],
                                        ),*/
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),




                          ]
                      ),
                    );
                  }
                }())

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


class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: () {
        // Share text
        Share.share('Check out my website https://example.com');

        // Share text with subject (optional)
        // Share.share('Check out my website https://example.com', subject: 'Look what I made!');
      },
      child: Image.asset('assets/images/share_round.png',width: 30,height: 30,),
    );
  }

}