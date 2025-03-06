import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/pages/HomeScreen.dart';
import 'package:quityown/pojo/CartlistRes.dart';
import 'package:quityown/pojo/DeleteInvestorRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget{
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage>{
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final mobilenumberController = TextEditingController();
  final billingAddress1Controller = TextEditingController();
  final billingAddress2Controller = TextEditingController();
  final billingCityController = TextEditingController();
  final billingZipcodeController = TextEditingController();


  int currentIndex = 0;
  static const backgroundColor = const Color(0xfff1f5f9);
  double grandTotal = 0.0;
  double actualTotal = 0.0;
  List<Result> itemList = <Result>[];

  List multipleSelected = [];
  final portfolio_search_controller = TextEditingController();






  void initState(){
    itemList=[];
    getCartlisyApi('');
    super.initState();
  }

  getCartlisyApi(search) async {
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

    String response = await apiHelper.callApiWithTokenGet(getCartlist,queryParameters);

    if(response != "Error")
    {
      CartlistRes res = CartlistRes.fromJson(json.decode(response));
      setState(() {
        itemList.addAll(res.result!);

        for(int i=0;i < itemList.length;i++){
          itemList[i].selectedBool = false;
        }

        totalCalculation();
      });
    }
  }

  bool isChecked = false;

  Map<String, dynamic>? paymentIntent;

  void proceedCheckoutDialog(BuildContext context,String projectname,String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm payment'),
          content:
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Project - "+projectname.toString()),
                Text("Amount - "+amount.toString()),
                Text("Please choose below method to confirm payment")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Payment gateway'),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "No payment integration now",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0,
                );
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :2)));
              },
            ),
            TextButton(
              child: Text('Cheque'),
              onPressed: () {
                Navigator.pop(context);
                chequeDialog(context, projectname, amount);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :2)));
              },
            ),
          ],
        );
      },
    );
  }
  void chequeDialog(BuildContext context,String projectname,String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm payment'),
          content:
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Project - "+projectname.toString()),
                Text("Amount - "+amount.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Self'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :2)));
              },
            ),
            TextButton(
              child: Text('Meet customer'),
              onPressed: () {
                Navigator.pop(context);
                billingAddressDialog(context);
              },
            )
          ],
        );
      },
    );
  }
  void billingAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Billing Address'),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.35,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: EdgeInsets.only(top: 15),
                  height: 40,
                  child:
                  TextField(
                    controller: billingAddress1Controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                        ,
                        hintText: 'Address ',
                        suffixText: "*",
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                        hintStyle: TextStyle(fontSize: 12),
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: EdgeInsets.only(top: 15),
                  height: 40,
                  child:
                  TextField(
                    controller: billingAddress2Controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                        ,
                        hintText: 'Address line 2 ',
                        suffixText: "*",
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                        hintStyle: TextStyle(fontSize: 12),
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: EdgeInsets.only(top: 15),
                  height: 40,
                  child:
                  TextField(
                    controller: billingAddress1Controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                        ,
                        hintText: 'City ',
                        suffixText: "*",
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                        hintStyle: TextStyle(fontSize: 12),
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: EdgeInsets.only(top: 15),
                  height: 40,
                  child:
                  TextField(
                    controller: billingAddress1Controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                        ,
                        hintText: 'Zipcode ',
                        suffixText: "*",
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                        hintStyle: TextStyle(fontSize: 12),
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen(pageIndex :2)));
              },
            ),
            TextButton(
              child: Text('Save address'),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "This function not integrated now",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0,
                );
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
  void deleteCart(BuildContext context,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Cart'),
          content:
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are you want to delete !"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteItem(id);
                Navigator.pop(context);
                //initState();
                //billingAddressDialog(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
           /* leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),*/
            title: Text("Cart",style: blackHeadStyle,),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body:

          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child:
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: itemList.length,
                      itemBuilder: (BuildContext context, int index){
                        return
                          GestureDetector(
                            onTap: () => {
                             /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PropertiesDetailsPage(propertyid : similarPopertiesList[index].id.toString()),
                                  ))*/
                            },
                            child:
                                Stack(
                                  children: [
                                    Padding(padding: EdgeInsets.all(10.0),
                                        child:
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                color: Colors.white,
                                              ),
                                              child:
                                              CheckboxListTile(
                                                controlAffinity: ListTileControlAffinity.leading,
                                                contentPadding: EdgeInsets.zero,
                                                dense: true,
                                                title:
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0),)
                                                  ),
                                                  child:
                                                  Row(
                                                    children: [
                                                      /*
                                      Image.network(itemList[index].profilePicPath.toString()),
                                                              */
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.10,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                                            color: Colors.white
                                                        ),
                                                        child: Icon(Icons.home_work_sharp),
                                                      ),
                                                      Container(
                                                        width  : MediaQuery.of(context).size.width * 0.40,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              itemList[index].propertyName.toString(),
                                                              style:  TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                            Text(
                                                              itemList[index].code.toString(),
                                                              style:  TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: Colors.black
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.3,
                                                        child: Text("AED "+itemList[index].investment.toString(),style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                value: itemList[index].selectedBool,
                                                onChanged: (value) {
                                                  setState(() {
                                                    //itemList[index].propertyName = value as String?;
                                                    if(itemList[index].selectedBool == false){
                                                      itemList[index].selectedBool = true;
                                                      actualTotal = actualTotal + double.parse(itemList[index].investment.toString());
                                                    }else{
                                                      itemList[index].selectedBool = false;
                                                      actualTotal = actualTotal - double.parse(itemList[index].investment.toString());
                                                    }
                                                    print(itemList[index].selectedBool);
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                    Positioned(
                                      top : 2,
                                        right : 2,
                                        child: InkWell(
                                        onTap : () => {
                                  deleteCart(context,itemList[index].id.toString())
                        },
                                            child: Icon(Icons.delete,color: Colors.red,))
                                    ),
                                  ],
                                ),
                          );
                      },
                    )
                    ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(3.0),
                    height: MediaQuery.of(context).size.height * 0.14,
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Actual total",style: blackChildStyle,),
                            SizedBox(width: 10,),
                            Text("AED "+actualTotal.toString(),style: greenHeadStyle,),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Grand total ",style: blackChildStyle,),
                            SizedBox(width: 10,),
                            Text("AED "+grandTotal.toString(),style: greenHeadStyle,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context,rootNavigator: false).push(
                                      MaterialPageRoute(builder: (context) =>  HomeScreen(pageIndex :0),maintainState: false)
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Continue shopping ",style: TextStyle(color: Colors.black,fontSize: 16),),
                                  ),
                                )),
                            SizedBox(width: 10,),
                            if(actualTotal == 0)
                            GestureDetector(
                              onTap: (){
                                proceedCheckoutDialog(context, itemList[0].propertyName.toString(), itemList[0].investment.toString());
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      color: Colors.grey
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Proceed checkout",style: TextStyle(color: Colors.white,fontSize: 16),),
                                  )),
                            ),
              
                            if(actualTotal != 0)
                              GestureDetector(
                                onTap: (){
                                  proceedCheckoutDialog(context, itemList[0].propertyName.toString(), itemList[0].investment.toString());
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        color: Colors.greenAccent
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Proceed checkout",style: TextStyle(color: Colors.white,fontSize: 16),),
                                    )),
                              )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ),
        );
  }

  totalCalculation(){
    for(int i=0;i< itemList.length;i++){
      grandTotal = grandTotal + double.parse(itemList[i].investment.toString());
      print(grandTotal);
    }
  }
  void searchootion(){
    //itemList.clear();
    itemList = <Result>[];
    getCartlisyApi(portfolio_search_controller.text);
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

/*Future<void> payment() async{
    try{
      Map<String,dynamic> body = {
        'amount' : 10000,
        'currency' : "INR",
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers:{
          'Authorization' : 'Bearer ',
          'Content-type' : 'application/x-www-form-urlencoded'
        }
      );

      paymentIntent = json.decode(response.body);
    }catch(error){

    }



    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntent!['sk_test_51ObOJGSHf8pI4XiFUtE9288avVT1UCqzeenjMDREBhdnDSkwQzc4akuyTHdAJ1ZACjU1d7hHxnoElMXdeC5ufaT600cD0c7sKb'],
      style: ThemeMode.light,
      merchantDisplayName: 'Equityown'
    )).then((value) => {});


    try{
      await Stripe.instance.presentPaymentSheet().then((value) => {
        print("Payment successs")
      });
    }catch(error){

    }
  }*/

}

