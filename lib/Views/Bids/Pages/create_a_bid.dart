import 'dart:convert';
import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Widgets/snackbar.dart';
import '../../../Widgets/solid_button.dart';
import '../../../Widgets/text_form_field.dart';
import '../../../constants/constants.dart';
import '../Model/create_bid.dart';


class CreateABidPage extends StatefulWidget {
  CreateABidPage({Key? key}) : super(key: key);
  String? restorationId;
  String? restorationIdSecond;

  @override
  State<CreateABidPage> createState() => _CreateABidPageState();
}

class _CreateABidPageState extends State<CreateABidPage> with RestorationMixin {
  final TextEditingController _dobController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bidEndingController = TextEditingController();

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  FilePickerResult? secondResult;
  String? _fileNameSecond;
  PlatformFile? pickedFileSecond;
  bool isLoading = false;
  var isEditingProfile = false;
  var image_file;
  var bid_Id = '';

  var pdf_file;
  var user_id = '';

  // File? _file;
  File? fileToDisplay;
  File? fileToDisplayTwo;
  String dropdownvalue = 'Select'.tr();
  var items = [
    'Select'.tr(),
    '1week'.tr(),
    '2week'.tr(),
    '3week'.tr(),
    '4week'.tr(),
    '5week'.tr(),
  ];

  Future pickFilePhoto(String? fileName) async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png']);

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        fileToDisplay = File(result!.files.first.path!);
        image_file = File(result!.files.single.path!);
        // fileToSend = File(result!.files.single.path!);
        print('File-name:${_fileName}');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future pickFilePdf(String? fileName) async {
    try {
      setState(() {
        isLoading = true;
      });

      secondResult = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf']);

      if (secondResult != null) {
        _fileNameSecond = secondResult!.files.first.name;
        pickedFileSecond = secondResult!.files.first;
        // fileToDisplayTwo = File(pickedFileSecond!.path.toString());
        fileToDisplayTwo = File(secondResult!.files.first.path!);
        // fileToSend = File(result!.files.single.path!);
        print('File-name:${_fileNameSecond}');
        pdf_file = File(secondResult!.files.single.path!);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  uploadAssignmentApi(
      {String? user_id,
        String? title,
        String? description,
        String? schedule_date,
        String? bid_till,
        File? image,
        File? filename}) async {
    Map param = {
      'user_id': user_id,
      'title': title,
      'description': description,
      'schedule_date': schedule_date,
      'bid_till': bid_till,
    };

    var response = await callUploadAssignmentApi(param, image!, filename!);
    print(user_id);
    print(title);
    print(description);
    print(schedule_date);
    print(bid_till);

    isLoading = false;
    setState(() {});
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      print('city after setting$user_id');
    });
  }

  Future<dynamic> callUploadAssignmentApi(
      Map parameter, File file, File file_second) async {
    final response = await postAfterAuthMultiPartSecondCreateBid(
        parameter,
        file,
        file_second,
        ApiConstants.baseUrl + ApiConstants.addBidEndPoint,
        context);

    return response;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('createABid'.tr()),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'createYourOwnBid'.tr(),
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Text(
                        'title'.tr(),
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
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Description';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                        controller: titleController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'UploadPhoto'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        String? _fileName;
                        pickFilePhoto(_fileName);
                      },
                      child: Container(
                          height: 80,
                          width: double.infinity,
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100),
                          child: Column(
                            children: [
                              Center(child: Text(' ')),
                              if (pickedFile != null)
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Color(0xFF304803)),
                                    child: (Text(
                                      _fileName.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'AttachFilePdf'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        String? _fileName;
                        pickFilePdf(_fileName);
                      },
                      child: Container(
                          height: 80,
                          width: double.infinity,
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100),
                          child: Column(
                            children: [
                              Center(child: Text(' ')),
                              if (pickedFileSecond != null)
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Color(0xFF304803)),
                                    child: (Text(
                                      _fileNameSecond.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'StartingBidDate'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        autofocus: false,
                        onTap: () {
                          _restorableDatePickerRouteFuture.present();
                        },
                        controller: _dobController,
                        cursorColor: Colors.black,
                        decoration:
                        InputDecoration(hintText: "SelectStartDate".tr()),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select date ';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Text(
                        'BidEndingIn'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin:
                      const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String item) {
                          // print(user_type);
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            uploadAssignmentApi(
                                user_id: user_id.toString(),
                                title: descriptionController.text.toString(),
                                schedule_date: _dobController.text.toString(),
                                bid_till: dropdownvalue.toString(),
                                description:
                                titleController.text.toString(),
                                image: image_file,
                                filename: pdf_file);
                          }
                        },
                        child: isEditingProfile == true
                            ? SizedBox(
                            height: 45,
                            width: 45,
                            child:
                            Center(child: CircularProgressIndicator()))
                            : reusableSolidButton('postYourBid'.tr()))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCommonRow(String text, int lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MyTextFormField(
                hintText: '',
                maxLines: lines,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2023, 2, 2));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023, 1),
          lastDate: DateTime(2023, 12, 31),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        _dobController.text =
        '${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}';
      });
    }
  }

  Future<dynamic> postAfterAuthMultiPartSecondCreateBid(
      Map parameter,
      File _image,
      File _pdf,
      url,
      BuildContext context,
      ) async {
    var responseJson;
    setState(() {
      isEditingProfile = true;
    });
    //  SharedPreferences box = await SharedPreferences.getInstance();
    // String token = box.getString(NetworkConstants.token) ?? '';
    try {
      final response = http.MultipartRequest("POST", Uri.parse(url));
      // response.headers['authorization'] = "Bearer " + token;
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }
      if (_image != null && _pdf != null) {
        var stream = http.ByteStream(Stream.castFrom(_image.openRead()));
        var streamsecond = http.ByteStream(Stream.castFrom(_pdf.openRead()));
        var length = await _image.length();
        var lengthsecond = await _pdf.length();
        var multipartFile = http.MultipartFile('image', stream, length,
            filename: _image.path.toString());
        var multipartFileSecond = http.MultipartFile(
            'filename', streamsecond, lengthsecond,
            filename: _pdf.path.toString());
        response.files.add(multipartFile);
        response.files.add(multipartFileSecond);
      }

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) async {
          if (response.statusCode == 200) {
            setState(() {
              isEditingProfile = false;
            });
            SharedPreferences myPref = await SharedPreferences.getInstance();

            var responseee =
            createBidModelClass.fromJson(jsonDecode(response.body));
            responseJson = responseee;

            bid_Id = responseee.bidId.toString();
            myPref.setString("bid_Id", bid_Id);
            print('File Uploaded Successfully!');
            print(responseee.bidId.toString());
            print(bid_Id);

            print(responseee.message);
            SnackBarService.showSnackBar(
                context, responseee.message.toString());
            print('............................................');
            // Navigator.pop(context);
            Navigator.pop(context);
            return response.body;
          } else {
            setState(() {
              isEditingProfile = false;
            });
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
