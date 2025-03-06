import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quityown/pages/AccountInfoPage.dart';
import 'package:quityown/pages/PreferencesPage.dart';

class SetDisplayCurrencyPage extends StatefulWidget{
  const SetDisplayCurrencyPage({super.key});

  @override
  State<SetDisplayCurrencyPage> createState() => _SetDisplayCurrencyPage();
}

class _SetDisplayCurrencyPage extends State<SetDisplayCurrencyPage>{
  static const backgroundcolor= const Color(0xfff1f5f9);


  List<Data> dataList = [
    Data(countrycode: "USD", image: "assets/images/usd_icon.png", countryname: "United States Dollar"),
    Data(countrycode: "AED", image: "assets/images/aed_icon.png", countryname: "United Arab Emirates Dirham"),
    Data(countrycode: "EUR", image: "assets/images/eur_icon.png", countryname: "Euro"),
    Data(countrycode: "GBP", image: "assets/images/gbp_icon.png", countryname: "Pound Sterling"),
    Data(countrycode: "SAR", image: "assets/images/sar_icon.png", countryname: "Saudi Arabian Riyal"),
    Data(countrycode: "EGP", image: "assets/images/egp_icon.png", countryname: "Eqyptian Pound"),
    Data(countrycode: "KWD", image: "assets/images/kwd_icon.png", countryname: "Kuwaiti Dinar"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: ()=> Navigator.of(context).pop(),
        ),
        title: Text('Set display currency',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child:
        Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.80,
              child: Padding(
                padding: EdgeInsets.only(left: 20,top: 15,right: 10,bottom: 15),
                child:
                ListView.builder(
                  itemCount: dataList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index){
                    return
                      InkWell(
                        onTap: (){}
                        /*{
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => AccountInfoPage()));
                        }*/,
                        child:
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 65,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                  color: backgroundcolor
                              ),

                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                Row(
                                  children: [
                                    Image.asset(dataList[index].image),
                                    SizedBox(width: 10,),
                                    Text(dataList[index].countrycode,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 10,),
                                    Text(dataList[index].countryname,style: TextStyle(color: Colors.black,fontSize: 16),)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      );
                  },
                ),),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: double.infinity,
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Properties are listed and purchased in AED (United Emirates Dirhams). Use this setting to approximate the value of your properties in local currencies',
                  style: TextStyle(color: Colors.black,fontSize: 14),),
              )
              ,
            )
          ],
        ),
      ),
    );
  }
}

class Data {

  String countrycode;
  String image;
  String countryname;

  Data({
    required this.countrycode,
    required this.image,
    required this.countryname
});
}