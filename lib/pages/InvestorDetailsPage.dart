import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pages/PropertiesDetailsPage.dart';
import 'package:quityown/pojo/GetPortfolioRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class InvestorDetailsPage extends StatefulWidget{
  final List<ChartSeries> seriesList;
  final bool animate;
  var id = 0;

  InvestorDetailsPage(this.seriesList, {required this.animate,required this.id});



  /// Creates a stacked [BarChart] with sample data and no transition.
  /*factory InvestorDetailsPage.withSampleData() {
    var id = 0;
    return new InvestorDetailsPage(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
      id: id
    );
  }*/



  @override
  State<InvestorDetailsPage> createState() => _InvestorDetailsPage(id);
}

/*
List<ChartSeries<InvestmentGrowth, String>> _createSampleData() {
  final investmentData = [
    new InvestmentGrowth('2024', 45000),
    new InvestmentGrowth('2025', 50000),
    new InvestmentGrowth('2026', 50000),
    new InvestmentGrowth('2027', 40000),
  ];

  final growthData = [
    new InvestmentGrowth('2024', 30000),
    new InvestmentGrowth('2025', 40000),
    new InvestmentGrowth('2026', 10000),
    new InvestmentGrowth('2027', 60000),
  ];

  return [
    ChartSeries<InvestmentGrowth, String>(
        id: 'Investment',
        domainFn: (InvestmentGrowth sales, _) => sales.year,
        measureFn: (InvestmentGrowth sales, _) => sales.amount,
        data: investmentData,
//seriesColor: charts.Color.fromHex(code: "#228B22")
        seriesColor: charts.Color.fromHex(code: "#000000")
    ),
    new ChartSeries<InvestmentGrowth, String>(
        id: 'Growth',
        domainFn: (InvestmentGrowth sales, _) => sales.year,
        measureFn: (InvestmentGrowth sales, _) => sales.amount,
        data: growthData,
        seriesColor: charts.Color.fromHex(code: "#228B22")
    ),
  ];
}
*/


class _InvestorDetailsPage extends State<InvestorDetailsPage> {
  var id = 0;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final mobilenumberController = TextEditingController();

  static const containerbackgrounColor1 = const Color(0xff2976ea);
  static const containerbackgrounColor2 = const Color(0xffff5492);
  static const buttonColor = const Color(0xff0b0837);
  static const backgroundcolor= const Color(0xfff1f5f9);

  GetPortfolioRes itemList = GetPortfolioRes();

  int currentIndex = 1;

  _InvestorDetailsPage(this.id);


  void initState(){
    print("userid -->"+id.toString());
    getPortfolioApi();
    super.initState();
  }

  getPortfolioApi() async{
    ApiHelper apiHelper = ApiHelper(context);
    final queryParameters = {
      "id": id.toString(),
      "limit": "10",
      "page": "1"
    };
    print(queryParameters);
    print(getPortfolio);

    String response = await apiHelper.callApiWithTokenGet2(getPortfolio,queryParameters);

    if(response != "Error")
    {
      GetPortfolioRes res = GetPortfolioRes.fromJson(json.decode(response));
      setState(() {
        itemList = res;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :1)),
                    (Route<dynamic> route) => false,
              ),
            ),
            title: Text(AppLocalizations.of(context)!.portfolio, style: blackHeadStyle,),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body:
          Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundcolor,
              child:
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(child: () {
                        if (itemList.result == null) {
                          return Center(child: Text("Loading please wait",textAlign: TextAlign.center,),);
                        }else
                        {
                          return
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,

                                          children: [
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.40,
                                              height: 80,
                                              decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10.0)),
                                                  color: containerbackgrounColor1
                                              ),
                                              child:
                                              Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Text(AppLocalizations.of(context)!.total_invested,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                        textAlign: TextAlign.center,),
                                                      Icon(Icons.invert_colors_sharp,
                                                        color: Colors.white,)
                                                    ],
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Text("AED "+itemList.totalInvestment.toString(), style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.center,),
                                                  SizedBox(height: 4,),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.40,
                                              height: 80,
                                              decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10.0)),
                                                  color: containerbackgrounColor2
                                              ),
                                              child:
                                              Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Text(AppLocalizations.of(context)!.total_gain,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                        textAlign: TextAlign.center,),
                                                      Icon(
                                                        Icons.currency_bitcoin_rounded,
                                                        color: Colors.white,)
                                                    ],
                                                  ),
                                                  SizedBox(height: 15,),
                                                  Text("AED "+itemList.totalGain.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.center,),
                                                  SizedBox(height: 4,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/images/project_overview.png"),
                                            SizedBox(width: 10,),
                                            Text(AppLocalizations.of(context)!.total_invested,
                                              style: blackHeadStyle,)
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: itemList.result!.data!.length,
                                          itemBuilder: (BuildContext context, int index){
                                            return
                                              GestureDetector(
                                                onTap: () => {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => PropertiesDetailsPage(propertyid: "5",),
                                                      ))
                                                },
                                                child:

                                                Column(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.85,
                                                      height: 90,
                                                      decoration: new BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10.0)),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors.grey, width: 0.5)
                                                      ),
                                                      child:
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                SizedBox(height: 2,),
                                                                Text(itemList.result!.data![index].projectName.toString(),
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight
                                                                          .bold),),
                                                                SizedBox(height: 5,),
                                                                Text("AED"+itemList.result!.data![index].investedAmount.toString(),
                                                                  style: TextStyle(
                                                                      color: Colors.greenAccent,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight
                                                                          .bold),),
                                                              ],
                                                            ),
                                                            Icon(Icons.expand_circle_down_rounded)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,)
                                                  ],
                                                ),
                                              );
                                          },
                                        ),
                                       /* SizedBox(height: 10,),
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.85,
                                          height: 60,
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 0.5)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    SizedBox(height: 2,),
                                                    Text('ROLEX TOWER',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                    SizedBox(height: 5,),
                                                    Text('AED 100,000',
                                                      style: TextStyle(
                                                          color: Colors.greenAccent,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                  ],
                                                ),
                                                Icon(Icons.expand_circle_down_rounded)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),*/
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/images/project_overview.png"),
                                            SizedBox(width: 10,),
                                            Text('Investment growth',
                                              style: blackHeadStyle,)
                                          ],
                                        ),
                                       /* SafeArea(
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                            SizedBox(
                                              height: 200,
                                              width: MediaQuery.of(context).size.width * 0.85,
                                              child: Card(
                                                elevation: 5.0,
                                                child: charts.BarChart(
                                                  _createSampleData(),
                                                  animate: true,
                                                  barGroupingType: charts.BarGroupingType.stacked,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),*/
                                        /* SizedBox(height: 10,),
                                        Container(
                                          width: MediaQuery.of(context).size
                                              .width * 0.85,
                                          height: 150,
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: .5)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(height: 2,),
                                                    Text('Exit window',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .bold),textAlign: TextAlign.center,),
                                                    SizedBox(height: 5,),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width * 0.35,
                                                        height: 60,
                                                        child: MyTextFieldWithoutBorder(hintText: "Open/closed", inputType: TextInputType.text, textEditingController: nameController)
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      height: 40,
                                                      width: MediaQuery.of(context).size.width * 0.30,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: buttonColor,
                                                        borderRadius: BorderRadius.circular(18),
                                                      ), child: TextButton(
                                                      style: ButtonStyle(
                                                        overlayColor: MaterialStateProperty.resolveWith(
                                                              (states) => Colors.black12,
                                                        ),
                                                      ),
                                                      onPressed: (){},
                                                      child: Text(
                                                        "Continue",
                                                        style: TextStyle(color:Colors.white),
                                                      ),
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    SizedBox(height: 2,),
                                                    Text('New exit window',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                      textAlign: TextAlign.center,),
                                                    SizedBox(height: 5,),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width * 0.35,
                                                        height: 60,
                                                        child: MyTextFieldWithoutBorder(hintText: "Date/time", inputType: TextInputType.datetime, textEditingController: nameController)
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      height: 40,
                                                      width: MediaQuery.of(context).size.width * 0.30,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.greenAccent,
                                                        borderRadius: BorderRadius.circular(18),
                                                      ),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          overlayColor: MaterialStateProperty.resolveWith(
                                                                (states) => Colors.black12,
                                                          ),
                                                        ),
                                                        onPressed: (){},
                                                        child: Text(
                                                          "Contact us",
                                                          style: kButtonText.copyWith(color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),*/
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            );
                        }
                      }())

                    ],
                  ),
                ),
              )

          ),
        ),
      );
  }
}

final MaterialColor _yellow700Swatch =
MaterialColor(Colors.yellow[700]!.value, _yellow700Map);
final Map<int, Color> _yellow700Map = {
  50: Color(0xFFFFD7C2),
  100: (Colors.yellow[100])!,
  200: (Colors.yellow[200])!,
  300: (Colors.yellow[300])!,
  400: (Colors.yellow[500])!,
  500: (Colors.yellow[600])!,
  600: (Colors.yellow[700])!,
  700: (Colors.yellow[800])!,
  800: (Colors.yellow[900])!,
  900: (Colors.yellow[1000])!,
};
/// Sample ordinal data type.
class InvestmentGrowth {
  final String year;
  final int amount;

  InvestmentGrowth(this.year, this.amount);
}



