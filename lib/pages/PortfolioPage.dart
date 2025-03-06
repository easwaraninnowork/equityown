import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/PropertiesDetailsPage.dart';
import 'package:quityown/pojo/DeleteInvestorRes.dart';
import 'package:quityown/pojo/GetInvestmentGrowthRes.dart';
import 'package:quityown/pojo/GetPortfolioRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class PortfolioPage extends StatefulWidget{
  final List<ChartSeries> seriesList;
  final bool animate;

  PortfolioPage(this.seriesList, {required this.animate});


  /// Creates a stacked [BarChart] with sample data and no transition.
/*
  factory PortfolioPage.withSampleData() {
    return new PortfolioPage(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }
*/


  @override
  State<PortfolioPage> createState() => _PortfolioPage(this.seriesList,this.animate);
}

/*List<charts.Series<InvestmentGrowth, String>> _createSampleData() {
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
    charts.Series<InvestmentGrowth, String>(
        id: 'Investment',
        domainFn: (InvestmentGrowth sales, _) => sales.year,
        measureFn: (InvestmentGrowth sales, _) => sales.amount,
        data: investmentData,
//seriesColor: charts.Color.fromHex(code: "#228B22")
        seriesColor: charts.Color.fromHex(code: "#000000")
    ),
    new charts.Series<InvestmentGrowth, String>(
        id: 'Growth',
        domainFn: (InvestmentGrowth sales, _) => sales.year,
        measureFn: (InvestmentGrowth sales, _) => sales.amount,
        data: growthData,
        seriesColor: charts.Color.fromHex(code: "#228B22")
    ),
  ];
}
*/

class _PortfolioPage extends State<PortfolioPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final mobilenumberController = TextEditingController();

  static const containerbackgrounColor1 = const Color(0xff2976ea);
  static const containerbackgrounColor2 = const Color(0xffff5492);
  static const buttonColor = const Color(0xff0b0837);
  static const backgroundcolor= const Color(0xfff1f5f9);

  GetPortfolioRes itemList = GetPortfolioRes();
  GetInvestmentGrowthRes investmentGrowth = GetInvestmentGrowthRes();
  late Future<List<dynamic>> _data;
  final portfolio_search_controller = TextEditingController();


  final List<ChartSeries> seriesList;
  final bool animate;

  _PortfolioPage(this.seriesList,this.animate);

  int currentIndex = 1;

  void initState(){
    getPortfolioApi('');
    _data = getinvestGrowthDetails();

    //getinvestGrowthDetails();
    super.initState();
  }

  getPortfolioApi(search) async{
    ApiHelper apiHelper = ApiHelper(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = (prefs.getString('userid') ?? '');
    print("uservalue -->"+userId);

    final queryParameters = {
      "search" : search,
      "id": userId,
      "limit": "10",
      "page": "1"
    };
    print(queryParameters);
    print(getPortfolio);

    String response = await apiHelper.callApiWithTokenGet(getPortfolio,queryParameters);

    if(response != "Error")
    {
      GetPortfolioRes res = GetPortfolioRes.fromJson(json.decode(response));
      setState(() {
        itemList = res;
      });
    }
  }
  Future<List<dynamic>> getinvestGrowthDetails() async{
    ApiHelper apiHelper = ApiHelper(context);

    print(getInvestMentGrowth);


    String response = await apiHelper.callApiWithTokenNoBodyGET(getInvestMentGrowth);
    var data = json.decode(response)['result'];
    print(data);
      return json.decode(response)['result'];



    /*if(response != "Error")
    {
      GetInvestmentGrowthRes res = GetInvestmentGrowthRes.fromJson(json.decode(response));
      setState(() {
        investmentGrowth = res;
      });
    }*/
  }

  void cancelInvestmentDialog(BuildContext context,String projectname,String amount,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel invesment'),
          content:
              Container(
                width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.1,
              child: Column(
                children: [
                  Text("Are you want to cancel "+amount.toString()+" USD"),
                  Text("investment for project "+projectname)
                ],
              ),),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
               // initState();
                //chequeDialog(context, projectname, amount);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                print("object");
                deleteItem(id);
                Navigator.pop(context);

              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteItem(id) async {
    ApiHelper apiHelper = ApiHelper(context);
    String apiUrl = getPortfolio + "/" + id; // Replace with your API endpoint
    String response = await apiHelper.callApiWithTokenDelete(apiUrl);
    print("Avalible Response : " + response);
    if (response != "Error") {
      DeleteInvestorRes res = DeleteInvestorRes.fromJson(json.decode(response));
      setState(() {
        print(res.message);
        Fluttertoast.showToast(
            msg: "Deleted Sucessfully",
            toastLength: Toast.LENGTH_SHORT
        );
        // initState();
        initState();
      });
    }else{
      initState();
    }
  }


  void searchootion(){
    //itemList.clear();
    itemList = GetPortfolioRes();
    getPortfolioApi(portfolio_search_controller.text);
  }



  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset : false,

          backgroundColor: Colors.white,
          appBar:
          AppBar(
            automaticallyImplyLeading: false,
            /* leading:
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: () => Navigator.of(context).pop(),
            ),*/
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
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.1,
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
                                            Text(AppLocalizations.of(context)!.invested_projects,
                                              style: blackHeadStyle,)
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: .5)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                height: 50,
                                                margin: EdgeInsets.only(top: 15),
                                                child:
                                                TextField(
                                                  controller: portfolio_search_controller,

                                                ),
                                              ),
                                              InkWell
                                                (
                                                  onTap: (){
                                                    searchootion();
                                                  },
                                                  child: Icon(Icons.search,color: Colors.black,))
                                            ],
                                          ),
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
                                               /* onTap: () => {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => PropertiesDetailsPage(propertyid: "5",),
                                                      ))
                                                },*/
                                                child:

                                                Column(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.86,
                                                      height: 185,
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
                                                            Container(
                                                              width : 220,
                                                              height : 180,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  SizedBox(height: 2,),
                                                                  Text(itemList.result!.data![index].projectName.toString(),
                                                                    style: TextStyle(
                                                                        color: Colors.green,
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight
                                                                            .bold),),
                                                                  SizedBox(height: 5,),
                                                                  Text("Invested Amount : USD "+itemList.result!.data![index].investedAmount.toString(),
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight
                                                                            .bold),),
                                                                  SizedBox(height: 5,),
                                                                  Text(
                                                                    "Exp Rate of Return : ${double.parse(itemList.result!.data![index].expectedRateOfReturn.toString()).toStringAsFixed(2)} %",
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),

                                                                  /*Text("Exp Rate of Return : "+itemList.result!.data![index].expectedRateOfReturn.toString()+ " %",
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight
                                                                            .bold),),*/
                                                                  SizedBox(height: 5,),
                                                                  Text("Exp Return : AED "+itemList.result!.data![index].expectedReturn.toString(),
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight
                                                                            .bold),),
                                                                  SizedBox(height: 5,),
                                                                  Text("Completion Date : "+itemList.result!.data![index].deliveryDate.toString(),
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight
                                                                            .bold),),
                                                                  SizedBox(height: 3,),
                                                                ],
                                                              ),
                                                            ),
                                                            if(itemList.result!.data![index].paymentStatus == "approved")
                                                              Container(
                                                                height: 30,
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.lightGreen,
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
                                                                    "Payment Received",
                                                                    style: TextStyle(color: Colors.black,fontSize: 8),
                                                                  ),
                                                                ),
                                                              )
                                                            else
                                                              Container(
                                                                height: 30,
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.grey,
                                                                  borderRadius: BorderRadius.circular(18),
                                                                ),
                                                                child: TextButton(
                                                                  style: ButtonStyle(
                                                                    overlayColor: MaterialStateProperty.resolveWith(
                                                                          (states) => Colors.black12,
                                                                    ),
                                                                  ),
                                                                  onPressed: (){
                                                                    cancelInvestmentDialog(context,itemList.result!.data![index].projectName.toString(),itemList.result!.data![index].investedAmount.toString(),itemList.result!.data![index].id.toString());
                                                                  },
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(color: Colors.black,fontSize: 8),
                                                                  ),
                                                                ),
                                                              ),
                                                          //  Icon(Icons.expand_circle_down_rounded)
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
                                        /*Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.85,
                                          height: 65,
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
                                                    Text('SAMEETHA TOWER',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                    SizedBox(height: 5,),
                                                    Text('AED 250,000',
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
                                        SizedBox(height: 10,),
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.85,
                                          height: 65,
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
                                        ),*/
                                        SizedBox(height: 10,),
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
                                        SizedBox(height: 20,),

                                        FutureBuilder<List<dynamic>>(
                                          future: _data,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Center(child: CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return Center(child: Text('Error: ${snapshot.error}'));
                                            } else {
                                              return
                                                SafeArea(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SizedBox(
                                                      height: MediaQuery.of(context).size.width * 0.9,
                                                      width: MediaQuery.of(context).size.width * 0.85,
                                                      child: Card(
                                                        elevation: 5.0,
                                                        child: BarChart(
                                                          BarChartData(
                                                            alignment: BarChartAlignment.spaceAround,
                                                            barGroups: snapshot.data!.map((data) {
                                                              final year = data['year'];
                                                              final amount = data['amount'].toDouble();
                                                              final interestAmount = data['interest_amount'].toDouble();

                                                              return BarChartGroupData(
                                                                x: year,
                                                                barRods: [
                                                                  BarChartRodData(
                                                                    toY: amount,
                                                                    color: Colors.green,
                                                                    width: 15,
                                                                  ),
                                                                  BarChartRodData(
                                                                    toY: interestAmount,
                                                                    color: Colors.black,
                                                                    width: 2,
                                                                  ),
                                                                ],
                                                              );
                                                            }).toList(),
                                                            titlesData: FlTitlesData(
                                                              topTitles: AxisTitles(
                                                                sideTitles: SideTitles(showTitles: false),
                                                              ),
                                                              rightTitles: AxisTitles(
                                                                sideTitles: SideTitles(showTitles: false),
                                                              ),
                                                              bottomTitles: AxisTitles(
                                                                sideTitles: SideTitles(
                                                                  showTitles: true,
                                                                  getTitlesWidget: (value, meta) {
                                                                    return Text(
                                                                      value.toString(),
                                                                      style: TextStyle(fontSize: 12),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              leftTitles: AxisTitles(
                                                                sideTitles: SideTitles(
                                                                  showTitles: true,
                                                                  reservedSize: 56,  // Adjust the reserved size to increase width
                                                                  getTitlesWidget: (value, meta) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets.only(left: 4.0),  // Adjust padding as needed
                                                                      child: Text(
                                                                        value.toString(),
                                                                        style: TextStyle(fontSize: 10),  // Increased font size
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            borderData: FlBorderData(show: false),
                                                            barTouchData: BarTouchData(enabled: true),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ;
                                            }
                                          },
                                        ),

                                        /*SafeArea(
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
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
/*List<charts.Series<dynamic, String>> _createBarChartData(List<dynamic> data) {
  return [
    charts.Series<dynamic, String>(
      id: 'Data',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (dynamic data, _) => data.result.year,
      measureFn: (dynamic data, _) => data.value.amount,
      data: data,
    )
  ];
}
*/
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





