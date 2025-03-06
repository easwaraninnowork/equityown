import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quityown/ApiHelper.dart';
import 'package:quityown/NetworkConstants.dart';
import 'package:quityown/SaveData.dart';
import 'package:quityown/pages/AddPropertiesPage.dart';
import 'package:quityown/pojo/DeleteInvestorRes.dart';
import 'package:quityown/pojo/EditAmentiesListResponse.dart';
import 'package:quityown/pojo/EditAmentiesRes.dart';
import 'package:quityown/pojo/PropertyDocumentRes.dart';
import 'package:quityown/pojo/PropertyImageRes.dart';
import 'package:quityown/widgets/Item.dart';
import 'package:quityown/widgets/ItemDialog.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';  // Add this line

import 'package:flutter_quill/flutter_quill.dart' as quill;



class EditAmentiesPage extends StatefulWidget{

  const EditAmentiesPage({super.key});

  @override
  State<EditAmentiesPage> createState() => _EditAmentiesPage();
}

class _EditAmentiesPage extends State<EditAmentiesPage> with SingleTickerProviderStateMixin {
  static const textfieldColor = const Color(0xffD6F5E7);
  static const backgroundcolor = const Color(0xfff1f5f9);
  late TabController _tabController;
  final startdate_controller = TextEditingController();
  final projectStartDateController = TextEditingController();
  final projectedgrossyieldController = TextEditingController();
  final projectDeliveryDateController = TextEditingController();
  final tenureController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? _selectedDate;
  var imageList = [];
  var imageId = [];
  var amentiesList = [];
  var amenitiesNearBy = "";
  List<File> _imageFiles = [];
  List<File> pdfFiles = [];



  void initState() {
    super.initState();
    //_tabController = new TabController(length: 3, vsync: this);

    amenitieslistApicall();
    //propertyDouApi();
    //getSharedpref();
    print(amenitiesNearBy+"datatata");

    _controller = quill.QuillController(
      document: quill.Document()..insert(0,amenitiesNearBy),
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  Future<void> Savefunction() async {
    if (projectedgrossyieldController.text.toString() != "") {
      if (tenureController.text.toString() != "") {
        if (valueController.text.toString() != "") {
          if (projectStartDateController.text.toString() != "") {
            if (projectDeliveryDateController.text.toString() != "") {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString(
                  "projected_gross_yield", projectedgrossyieldController.text);
              prefs.setString("tenure", tenureController.text);
              prefs.setString("value", valueController.text);
              prefs.setString(
                  "project_start_date", projectStartDateController.text);
              prefs.setString(
                  "project_delivery_date", projectDeliveryDateController.text);

              Fluttertoast.showToast(
                msg: "Propery details saved successfully ",
                toastLength: Toast.LENGTH_SHORT,
              );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPropertiesPage(pageIndex: 2),
                  ));
            }
            else {
              Fluttertoast.showToast(
                msg: "Please select project delivery date",
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          }
          else {
            Fluttertoast.showToast(
              msg: "Please select project start date",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
        else {
          Fluttertoast.showToast(
            msg: "Please enter property value",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      else {
        Fluttertoast.showToast(
          msg: "Please enter tenure",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please enter projected gross yield",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }


  //final quill.QuillController _controller = quill.QuillController.basic();
  late quill.QuillController _controller = quill.QuillController(
    document: quill.Document()..insert(0, 'first'),
    selection: TextSelection.collapsed(offset: 0),
  );

  List<Item> _items = [];
  final FocusNode _editorFocusNode = FocusNode();

  void _addItem(Item item) {
    setState(() {
      _items.add(item);
    });
  }
  void _editItem(int index, Item updatedItem) {
    setState(() {
      _items[index] = updatedItem;
    });
  }

  void _showEditItemDialog(int index) {
    showDialog(
      context: context,
      builder: (ctx) => ItemDialog(
        onAddItem: (updatedItem) => _editItem(index, updatedItem),
        currentItem: _items[index],
      ),
    );
  }


  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (ctx) => ItemDialog  (onAddItem: _addItem),
    );
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:
        SingleChildScrollView(

          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  width: MediaQuery
                      .sizeOf(context)
                      .width,
                  height: 351,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery
                            .sizeOf(context)
                            .width,
                        child:
                        Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Amenties', style: blackHeadStyle,
                                  textAlign: TextAlign.left,)),
                            SizedBox(height: 10,),
                            Container(
                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.black12,
                                  ),
                                ),
                                onPressed: () {
                                  _showAddItemDialog();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Add amenties",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      Icon(Icons.add_circle_outline_rounded,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery
                                  .sizeOf(context)
                                  .width,
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return
                                    Column(
                                      children: [

                                        Stack(
                                          children: [
                                            // Rounded Corner Image Container
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    16.0),
                                                color: Colors.black12,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(
                                                      5), // Set the corner radius
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          width: 250,
                                                          height: 40,
                                                          child: Text(
                                                              _items[index].name
                                                                  .toString()))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Delete Icon Overlay
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: InkWell(
                                                onTap: () {
                                                  deleteDocument(_items[index].id);
                                                  // Handle delete action here
                                                },
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.red,
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 50,
                                              child: InkWell(
                                                onTap: () {
                                                  // Handle delete action here
                                                  _showEditItemDialog(index);
                                                },
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.black,
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,)
                                      ],
                                    );
                                },
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap:() {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: 300,
                    child: Column(
                      children: [
                        quill.QuillToolbar.simple(controller: _controller),
                        Expanded(
                          child: quill.QuillEditor.basic(
                            controller: _controller,
                            focusNode: _editorFocusNode,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),



                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topRight,
                  child:
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
                      onPressed: (){ savedata(); },
                      child: Text(
                        "Save",
                        style: kButtonText.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      );
  }



  amenitieslistApicall() async {
    ApiHelper apiHelper = ApiHelper(context);
    var apiUrl = amenitieslistApi + "?property_id=15";
    String response = await apiHelper.callApiWithTokenNoBodyGET(apiUrl);
    print("Avalible Response : " + response);

    if (response == "Error") {
      setState(() {
        amentiesList = [];
      });
    } else {
      EditAmentiesListResponse res = EditAmentiesListResponse.fromJson(
          json.decode(response));
      amenitiesNearBy = res.result!.amenitiesNearBy.toString();

      setState(() {
        amentiesList = [];
        for (int i = 0; i < res.result!.amenities!.length; i++) {
          amentiesList.add(res.result!.amenities![i]);
          final newItem = Item(name: res.result!.amenities![i].name!,id : res.result!.amenities![i].id!);

          _items.add(newItem);
          print(res.result!.amenities![i]);


        }
      });
    }
  }

  String extractPlainText(quill.QuillController controller) {
    return controller.document.toPlainText().trim();
  }


  Future<void> savedata() async {
    ApiHelper apiHelper = ApiHelper(context);

    // Convert the list of Item objects to a JSON-compatible format

    // Define the body for the API request
    Map<String, dynamic> bodyAPI = <String, dynamic>{
      "names": _items, // Use the converted JSON list of items
      "near_by_amenities": extractPlainText(_controller),
      "property_id": "15"
    };

    print("ferfer : $bodyAPI");
    String apiUrl = amenitiesApi; // Replace with your API endpoint
    String response = await apiHelper.callApiWithToken(apiUrl, bodyAPI);

    print("Available Response: " + response);
    if (response != "Error") {
      EditAmentiesRes res = EditAmentiesRes.fromJson(json.decode(response));
      setState(() {
        print(res.message);
        Fluttertoast.showToast(
            msg: res.message!,
            toastLength: Toast.LENGTH_SHORT
        );
        // Clear and refresh amenities list
        amentiesList = [];
        _items = [];
        amenitieslistApicall();
      });
    }
  }
  Future<void> deleteDocument(index) async {
    print(index);
    ApiHelper apiHelper = ApiHelper(context);
    String apiUrl = amenitiesApi + "/" + index.toString(); // Replace with your API endpoint
    String response = await apiHelper.callApiWithTokenDelete(apiUrl);
    print("Avalible Response : " + response);
    if (response != "Error") {
      DeleteInvestorRes res = DeleteInvestorRes.fromJson(json.decode(response));
      setState(() {
        print(res.message);
        Fluttertoast.showToast(
            msg: res.message!,
            toastLength: Toast.LENGTH_SHORT
        );
        // initState();

        imageList = [];
        imageId = [];
       _items = [];
       amenitieslistApicall();
      });
    }
  }


}
