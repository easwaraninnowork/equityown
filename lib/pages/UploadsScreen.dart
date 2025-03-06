import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
import 'package:quityown/pojo/PropertyDocumentRes.dart';
import 'package:quityown/pojo/PropertyImageRes.dart';
import 'package:quityown/widgets/constants.dart';
import 'package:quityown/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';  // Add this line


class UploadsScreen extends StatefulWidget{

  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() => _UploadsScreen();
}

class _UploadsScreen extends State<UploadsScreen> with SingleTickerProviderStateMixin {
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
  var documentList = [];
  List<File> _imageFiles = [];
  List<File> pdfFiles = [];


  Future<void> _selectProjectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      // Default to today's date if no date is selected
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(
            _selectedDate.toString());
        String formattedDateString = DateFormat('dd/MM/yyyy').format(
            formattedDate);

        print(formattedDateString);
        projectStartDateController.text = formattedDateString;
      });
    }
  }

  Future<void> _selectProjectDeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      // Default to today's date if no date is selected
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(
            _selectedDate.toString());
        String formattedDateString = DateFormat('dd/MM/yyyy').format(
            formattedDate);

        print(formattedDateString);
        projectDeliveryDateController.text = formattedDateString;
      });
    }
  }


  void initState() {
    super.initState();
    //_tabController = new TabController(length: 3, vsync: this);

    propertyIndApi();
    propertyDouApi();
    //getSharedpref();
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

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _imageFiles =
            pickedFiles.map((pickedFile) => File(pickedFile.path!)).toList();
      });
      _uploadImages();
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery
                .sizeOf(context)
                .width,
            height: MediaQuery
                .sizeOf(context)
                .height,
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
                  height: MediaQuery
                      .sizeOf(context)
                      .height * 0.48,
                  // Set a fixed height for the horizontal scroll
                  child:
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('Project Images', style: blackHeadStyle,
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
                            _pickImages();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select images",
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 250,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // Number of items per column
                            crossAxisSpacing: 10,
                            // Space between items horizontally
                            mainAxisSpacing: 10,
                            // Space between items vertically
                            childAspectRatio: 1, // Aspect ratio of each item
                          ),
                          itemCount: imageList.length,
                          itemBuilder: (context, index) {
                            return
                              Stack(
                                children: [
                                  // Rounded Corner Image Container
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      // Set the corner radius
                                      child: Image.network(
                                        imageList[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                  // Delete Icon Overlay
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: InkWell(
                                      onTap: () {
                                        // Handle delete action here
                                        deleteImages(imageId[index]);
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
                                ],
                              );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                            'Project documents', style: blackHeadStyle,
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
                            pickAndUploadDocument();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select documents",
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
                          itemCount: documentList.length,
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
                                                20), // Set the corner radius
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 50,
                                                  child: Image.asset(
                                                      "assets/images/pdf.png"),
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                    width: 250,
                                                    height: 50,
                                                    child: Text(
                                                        documentList[index]
                                                            .documentName
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
                                            // Handle delete action here
                                            deleteDocument(documentList[index].id);
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
        ),
      );
  }


  propertyIndApi() async {
    ApiHelper apiHelper = ApiHelper(context);
    var apiUrl = propertyImages + "/15";
    String response = await apiHelper.callApiWithTokenNoBodyGET(apiUrl);
    print("Avalible Response : " + response);

    if (response == "Error") {
      setState(() {
        imageList = [];
      });
    } else {
      PropertyImageRes res = PropertyImageRes.fromJson(json.decode(response));
      setState(() {
        imageList = [];
        for (int i = 0; i < res.result!.length; i++) {
          imageList.add(res.result![i].path);
          imageId.add(res.result![i].id);
          print(res.result![i].path!);
        }
        print("object" + imageList[0]);
        print("object" + imageList[1]);
      });
    }
  }

  propertyDouApi() async {
    ApiHelper apiHelper = ApiHelper(context);
    var apiUrl = propertyDocuments + "/15";
    String response = await apiHelper.callApiWithTokenNoBodyGET(apiUrl);
    print("Avalible Response : " + response);

    if (response == "Error") {
      setState(() {
        documentList = [];
      });
    } else {
      PropertyDocumentRes res = PropertyDocumentRes.fromJson(
          json.decode(response));
      setState(() {
        documentList = [];
        for (int i = 0; i < res.result!.length; i++) {
          documentList.add(res.result![i]);
          print(res.result![i]);
        }
      });
    }
  }

  imageUploadApi(image) async {
    ApiHelper apiHelper = ApiHelper(context);
    var apiUrl = imagUploadApi + "/15";

    List<http.MultipartFile> files = []; // Prepare your files list
    files.add(await http.MultipartFile.fromPath('image', image));

/*
    for (var file in _imageFiles) {
      // Convert each file to base64
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);

      // Add the base64 string to the request
      request.fields['images[]'] = base64String; // Use 'images[]' to signify an array
    }
*/

    final queryParameters = {
      "property_id": "15",
    };

    String response = await apiHelper.callApiWithTokenGetMultipart(
        apiUrl, queryParameters, files);
    print("request : " + queryParameters.toString());
    print("Avalible Response : " + response);

    if (response == "Error") {
      setState(() {
        documentList = [];
      });
    } else {
      PropertyDocumentRes res = PropertyDocumentRes.fromJson(
          json.decode(response));
      setState(() {
        documentList = [];
        for (int i = 0; i < res.result!.length; i++) {
          documentList.add(res.result![i]);
          print(res.result![i]);
        }
      });
    }
  }

  Future<void> _uploadImages() async {
    if (_imageFiles.isEmpty) return;

    String apiUrl = imagUploadApi; // Replace with your API endpoint
    String propertyId = '15'; // Replace with your actual property ID
    SaveData saveData = SaveData();

    String? token = await saveData.getSavedString(
        "token"); // Retrieve the token

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add the property_id as a query parameter
    // request.fields['property_id'] = propertyId; // Add as a form field, or adjust the API to accept it in the URL

    // Add the Authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Add the property_id as a query parameter (if required)
    request.fields['property_id'] =
        propertyId; // Add as a form field if your API accepts it this way

    // Add the images to the request
    for (var file in _imageFiles) {
      request.files.add(await http.MultipartFile.fromPath(
        'images[]', // Adjust this name according to your server's expectations
        file.path,
      ));
    }

    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      // Check the response status
      if (response.statusCode == 200) {
        print('Upload successful: ${responseBody.body}');

        // Refresh UI - Clear the selected images or update state
        setState(() {
          _imageFiles.clear(); // Clear selected files after successful upload
        });
        // Optionally show a success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Images uploaded successfully!')),
        );
        imageList = [];
        imageId = [];
        documentList = [];

        propertyIndApi();
        propertyDouApi();
        //initState();
      } else {
        print('Failed to upload: ${responseBody.statusCode} - ${responseBody
            .body}');
        // Optionally show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload images.')),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> deleteImages(imageIdn) async {
    print(imageIdn);
    ApiHelper apiHelper = ApiHelper(context);
    String apiUrl = imageDeleteApi + "/" + imageIdn.toString() +
        "?property_id=15"; // Replace with your API endpoint
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
        documentList = [];
        propertyIndApi();
        propertyDouApi();
      });
    }
  }
  Future<void> deleteDocument(imageIdn) async {
    print(imageIdn);
    ApiHelper apiHelper = ApiHelper(context);
    String apiUrl = documentUpload + "/" + imageIdn.toString() +
        "?property_id=15"; // Replace with your API endpoint
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
        documentList = [];
        propertyIndApi();
        propertyDouApi();
      });
    }
  }

  Future<void> pickAndUploadDocument() async {
    // Pick a document
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],  // Specify allowed file types
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;

      print('Picked file: ${file.name}');
      print('File path: ${file.path}');
      print('File size: ${file.size}');

      if (file.path != null) {
        // Call the upload function
        await uploadDocument(file.path!, file.name);
      }
    } else {
      // User canceled the picker
      print("No file selected.");
    }
  }

  Future<void> uploadDocument(String filePath, String fileName) async {
    try {


      SaveData saveData = SaveData();

      String? token = await saveData.getSavedString("token");

      // Create Dio instance
      Dio dio = Dio();

      // Prepare FormData
      FormData formData = FormData.fromMap({
        'property_id' : '15',
        'documents[0]': await MultipartFile.fromFile(
          filePath),
      });

      // Make the POST request
      Response response = await dio.post(
        documentUpload, // Replace with your actual API endpoint
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',  // Required header for file uploads
            'Authorization': 'Bearer $token',  // If you need authentication
          },
        ),
      );

      // Handle response
      if (response.statusCode == 200) {
        print("File uploaded successfully: ${response.data}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File uploaded successfully')),
        );
        imageList = [];
        imageId = [];
        documentList = [];
        propertyIndApi();
        propertyDouApi();
      } else {
        print("Failed to upload file. Status code: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.statusMessage.toString())),
        );
      }
    } catch (e) {
      print("Error occurred during file upload: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }


}
