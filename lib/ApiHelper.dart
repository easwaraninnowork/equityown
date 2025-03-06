import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'SaveData.dart';

class ApiHelper {
  final BuildContext context;
  ApiHelper(this.context);

  final Connectivity _connectivity = Connectivity();
  Future<String> callApiWithToken(String link, Map<String, dynamic> body) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      print(token);

      var res = await http.post(Uri.parse(link),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.body;
      }else{
        Navigator.pop(context);
        print(res.body);
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }
  Future<String> callApiWithTokenPut(String link, Map<String, dynamic> body) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      print(token);

      var res = await http.put(Uri.parse(link),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.body;
      }else{
        Navigator.pop(context);
        print(res.body);
        return "Error: ${res.body}";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }
  Future<String> callApiWithTokenGet2(String link, Map<String,String> body) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      final uri = Uri.parse(link).replace(queryParameters : body);
      print(uri);
      var res = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print("Status_code "+res.statusCode.toString());
      print("resbody "+res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.body;
      }else{
        Navigator.pop(context);
        print(res.body);
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }

  Future<String> callApiWithTokenGet(String link, Map<String,dynamic> body) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      final uri = Uri.parse(link).replace(queryParameters : body);
      print(uri);
      var res = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print("Status_code "+res.statusCode.toString());
      print("resbody "+res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.body;
      }else{
        Navigator.pop(context);
        print(res.body);
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }

  Future<String> callApiWithTokenGetMultipart(
      String link, Map<String, dynamic> body, List<http.MultipartFile> files) async {
    bool isNetworkConnected = await checkNetwork(); // Ensure this function checks network connectivity
    showLoaderDialog(context); // Show loader dialog while the request is being processed

    if (isNetworkConnected) {
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token"); // Retrieve the token

      // Create the request
      var request = http.MultipartRequest('POST', Uri.parse(link));

      // Add headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Add the body fields
      body.forEach((key, value) {
        request.fields[key] = value.toString(); // Add fields from the body map
      });

      // Add files to the request
      for (var file in files) {
        request.files.add(file); // Assuming `files` is a list of MultipartFile
      }

      try {
        // Send the request and wait for a response
        var res = await request.send();
        var responseBody = await http.Response.fromStream(res);

        // Check the response status
        print("Status code: ${responseBody.statusCode}");
        print("Response body: ${responseBody.body}");

        if (responseBody.statusCode == 200) {
          Navigator.pop(context); // Hide loader
          return responseBody.body; // Return the response body
        } else {
          Navigator.pop(context); // Hide loader
          print("Error response: ${responseBody.body}");
          return "Error";
        }
      } catch (e) {
        Navigator.pop(context); // Hide loader
        print("Error occurred: $e");
        return "Error";
      }
    } else {
      Navigator.pop(context); // Hide loader
      return "Error: No network connection";
    }
  }

  Future<String> callApiWithTokenDelete(String link) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      final uri = Uri.parse(link).replace();
      print(uri);
      var res = await http.delete(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print("Status_code "+res.statusCode.toString());
      print("resbody "+res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.body;
      }else{
        Navigator.pop(context);
        print(res.body);
        Fluttertoast.showToast(
            msg: res.body!,
            toastLength: Toast.LENGTH_SHORT
        );
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }

  Future<String> callApiWithTokenNoBody(String link) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      var res = await http.post(Uri.parse(link),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': 'Bearer $token',
          });
      print("Link ---> $link");
      print("Res ---> "+res.body);

      if (res.statusCode == 200) {
        Navigator.pop(context);
        print("common response "+res.body);
        return res.body;
      }else{
        Navigator.pop(context);
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }
  Future<String> callApiWithTokenNoBodyGET(String link) async
  {
    bool isNetworkConnected = await checkNetwork();
    showLoaderDialog(context);
    if(isNetworkConnected){
      SaveData saveData = SaveData();
      String? token = await saveData.getSavedString("token");
      var res = await http.get(Uri.parse(link),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': 'Bearer $token',
          });
      print("Link ---> $link");
     // print("Res ---> "+res.body);

      if (res.statusCode == 200) {
        Navigator.pop(context);
       // print("common response "+res.body);
        return res.body;
      }else{
        Navigator.pop(context);
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }

  Future<List<Map<String, dynamic>>> fetchInvestmentGrowth() async {
    final response = await http.get(Uri.parse("https://equityown.innowork.com/equityown/api/users/invest/details"));

    print(response);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Assuming the response is a list of maps
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<String> callApi(String link, Map<String, String> body) async
  {
    bool isNetworkConnected =true;
    showLoaderDialog(context);
    if(isNetworkConnected){
      var res = await http.post(Uri.parse(link),
          headers: {
            //"Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode(body));
      print(""+res.statusCode.toString());
      print(""+res.statusCode.toString());
      print(""+link);
      print(jsonEncode(body));
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.body;
      }else{
        Navigator.pop(context);
        return "Error";
      }
    }else{
      Navigator.pop(context);
      return "Error";
    }

  }

  Future<bool> checkNetwork() async{
    print("Check internet is called");
    var connectivityResult;
    try{
      connectivityResult = await (_connectivity.checkConnectivity());
      print("connectivityResult $connectivityResult");
      if(connectivityResult == ConnectivityResult.none){
        Fluttertoast.showToast(
            msg: "No Internet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );
        return false;
      }else{
        return true;
      }
    }on Exception catch(e){
      print(e);
      return false;
    }

  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 50,),
          Container(child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}