import 'dart:convert';
import 'dart:io';

import 'package:bina_github/Widgets/solid_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Widgets/snackbar.dart';
import '../../../Widgets/text_form_field.dart';
import '../../../constants/constants.dart';
import '../../Jobs/Model/apply_for_job.dart';
import '../Model/place_an_offer.dart';

class PlaceAnOfferPage extends StatefulWidget {
  final var1;

  const PlaceAnOfferPage({Key? key, this.var1}) : super(key: key);

  @override
  State<PlaceAnOfferPage> createState() => _PlaceAnOfferPageState();
}

class _PlaceAnOfferPageState extends State<PlaceAnOfferPage> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  var user_id = '';
  var isEditingProfile = false;
  var fileToSend;

  // File? _file;
  File? fileToDisplay;

  Future pickFile(String? fileName) async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf']);

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        fileToDisplay = File(result!.files.first.path!);
        fileToSend = File(result!.files.single.path!);
        print('File-name:${_fileName}');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  TextEditingController offerAmountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  uploadAssignmentApi(
      {String? user_id,
        String? bid_id,
        String? offer_amount,
        String? offer_description,
        File? file}) async {
    setState(() {
      isEditingProfile = true;
    });
    Map param = {
      'user_id': user_id,
      'bid_id': bid_id,
      'offer_amount': offer_amount,
      'offer_description': offer_description,
    };

    var response = await callUploadAssignmentApi(param, file!);
    print(user_id);
    print(bid_id);
    print(offer_amount);
    print(offer_description);
    isLoading = false;
    var applyForJobResponseModel = placeOfferModelClass.fromJson(response);
    if (applyForJobResponseModel.status == true) {
      print(
          'inside model class multipart>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      SnackBarService.showSnackBar(
          context, applyForJobResponseModel.message.toString());

      // print('jobs_type');

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool("isLoggedin", true);
      // prefs.setString("name", result['name']);
    }
    // print(response);
    // print(applyForJobResponseModel.status);

    setState(() {});
  }

  Future<dynamic> callUploadAssignmentApi(Map parameter, File file) async {
    final response = await postAfterAuthMultiPart(
        parameter,
        file,
        ApiConstants.baseUrl + ApiConstants.addOfferEndPoint,
        context,
        'offer_file');

    return response;
  }

  final _formKey = GlobalKey<FormState>();

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      print('city after setting$user_id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('placeAnoffer'.tr()),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'placeYouroffer'.tr(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Text(
                      'offerAmount'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: MyTextFormField(
                      hintText: '',
                      controller: offerAmountController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Text(
                      'Description'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: MyTextFormField(
                      hintText: '',
                      controller: descriptionController,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Text(
                      'attachAnOffer'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      String? _fileName;
                      pickFile(_fileName);
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text(' ')),
                          if (pickedFile != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Color(0xFF304803)),
                              child: (Text(
                                _fileName!,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          uploadAssignmentApi(
                              user_id: user_id.toString(),
                              bid_id: widget.var1.toString(),
                              offer_amount:
                              offerAmountController.text.toString(),
                              offer_description:
                              descriptionController.text.toString(),
                              file: fileToSend);
                        }
                        // uploadAssignmentApi(user_id: ,bid_id: ,offer_amount: ,offer_description: ,image: );
                      },
                      child: isEditingProfile == true
                          ? SizedBox(
                          height: 45,
                          width: 45,
                          child: Center(child: CircularProgressIndicator()))
                          : reusableSolidButton('submitDetails'.tr()))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget commontextfldWidget(
      String text, int maxlines, TextInputType? textInputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: MyTextFormField(
                hintText: '',
                maxLines: maxlines,
                keyboardType: textInputType,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> postAfterAuthMultiPart(Map parameter, File _image, url,
      BuildContext context, var filename) async {
    setState(() {
      isEditingProfile = true;
    });
    var responseJson;
    //  SharedPreferences box = await SharedPreferences.getInstance();
    // String token = box.getString(NetworkConstants.token) ?? '';
    try {
      final response = http.MultipartRequest("POST", Uri.parse(url));
      // response.headers['authorization'] = "Bearer " + token;
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }
      if (_image != null) {
        var stream = http.ByteStream(Stream.castFrom(_image.openRead()));
        var length = await _image.length();
        var multipartFile = http.MultipartFile(filename, stream, length,
            filename: _image.path.toString());
        response.files.add(multipartFile);
      }
      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          if (response.statusCode == 200) {
            setState(() {
              isEditingProfile = false;
            });
            var responseee =
            applyForJobUserModel.fromJson(jsonDecode(response.body));
            print('File Uploaded Successfully!');

            print(responseee.message);
            SnackBarService.showSnackBar(
                context, responseee.message.toString());
            Navigator.pop(context);

            return response.body;
          } else {
            setState(() {
              isEditingProfile = false;
            });
            SnackBarService.showSnackBar(context, "fill details properly");
            print('File Uploaded Failed!');
            return "NetworkConstants.error";
          }
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
        SnackBarService.showSnackBar(context, e.toString());
      }

      return 'NetworkConstants.error';
      //  throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
